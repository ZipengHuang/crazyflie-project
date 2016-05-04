# -*- coding: utf-8 -*-
import numpy as np
from scipy.linalg import inv
from subprocess import call
import sys, os, inspect, ctypes

curdir = os.path.dirname(os.path.abspath(inspect.getfile(inspect.currentframe())))
libdir = os.path.join(os.path.dirname(curdir),'modules')

# -------------------------------------------------------------------------

# Loads ctypes modules for the sum example
try:
    sumlib = ctypes.CDLL('sum.so')
    sumlib.sum_example.argtypes = (ctypes.c_int, ctypes.POINTER(ctypes.c_int))
except:
    raise Exception('Error when loading dynamical library sum.so, please source init.sh '+
                    'and\ncheck that the LD_LIBRARY_PATH contains the path to /modules, e.g. using\n'+
                    '\n    env|grep LD_LIBRARY_PATH\n')
    
def c_sum(numbers):
    # A c-wrapper for calling the sum example function in sum.c
    # from python. This is the way cvxGen solver will be called.

    global sumlib
    num_numbers = len(numbers)
    array_type = ctypes.c_int * num_numbers
    result = sumlib.sum_example(ctypes.c_int(num_numbers), array_type(*numbers))
    return int(result)

# -------------------------------------------------------------------------

# Loads ctypes modules for the CVX solver wrapper
cvxlib = ctypes.CDLL('ROS_solver.so')
cvxlib.call_solver.argtypes = (ctypes.c_int, ctypes.POINTER(ctypes.c_int))

def c_cvx_solver(numbers):
    # A c-wrapper for calling the CXVgen generated solver.c
    
    global cvxlib
    num_numbers = len(numbers)
    array_type = ctypes.c_int * num_numbers
    result = cvxlib.call_solver(ctypes.c_int(num_numbers), array_type(*numbers))
    return int(result)

# -------------------------------------------------------------------------

def discrete_KF_update(x, u, z, A, B, C, P, Q, R):
    # Makes a discrete kalman update and returns the new state
    # estimation and covariance matrix. Can handle empy control
    # signals and empty B. Currently no warnings are issued if
    # used improperly, which should be fixed in future iterations.
    #
    # N<=M and 0<K<=M are integers.
    # 
    # ARGS:
    #    x - np.array of shape (M,1). State estimate at t = h*(k-1)
    #    u - np.array of shape (N,1), emty list or None. If applicable, control signals at t = h*(k-1)
    #    z - np.array of shape (K,1). Measurements at t = h*k.
    #    A - np.array of shape (M,M). System matrix.
    #    B - np.array of shape (M,N), emty list or None. Control signal matrix.
    #    C - np.array of shape (K,M). Measurement matrix.
    #    P - np.array of shape (M,M). Covariance at the previous update.
    #    Q - np.array of shape (M,M). Estimated covariance matrix of model noise.
    #    R - np.array of shape (K,K). Estimated covariance matrix of measurement noise.
    #
    # RETURN:
    #    xhat - New estimate at t = h*k
    #    Pnew - New covariance matrix at t = h*k

    # Kalman prediction
    if B == [] or u == []:
        xf = np.transpose(np.dot(A,x))
    else:
        xf = np.transpose(np.dot(A,x)) + np.transpose(np.dot(B,u))
    Pf = np.dot(np.dot(A,P),np.transpose(A)) + Q
    
    # Kalman update
    if z is not None:
        Knum =  np.dot(Pf,np.transpose(C))
        Kden = np.dot(C,np.dot(Pf,np.transpose(C))) + R
        K = np.dot(Knum,inv(Kden))
        xhat = xf + np.dot(K, (z - np.dot(C,xf)))
        Pnew = np.dot((np.eye(Q.shape[0]) - np.dot(K,C)), Pf)
    else:
        xhat = xf
        Pnew = Pf
    return xhat, Pnew

# -------------------------------------------------------------------------

def discrete_AKF_update(x, u, z, zhist, A, B, C, P, Q, R, trajectory, t, Ts):
    # Makes an asynchronous kalman update and returns the new state
    # estimation and covariance matrix. Can handle emtpy control
    # signals and empty B. Currently no warnings are issued if
    # used improperly, which should be fixed in future iterations.
    # This function is very adapted to the problem at hand and should
    # not be used outside of the kinect node.
    #
    # N<=M and 0<K<=M are integers.
    # 
    # ARGS:
    #    x - np.array of shape (M,1). State estimate at t = h*(k-1)
    #    u - np.array of shape (N,1), emty list or None. If applicable, control signals at t = h*(k-1)
    #    z - np.array of shape (K,1). Measurements at t = h*k.
    #    zhist - np.array of shape (1,X). solution history of the measurements dating back X timesteps.
    #    A - np.array of shape (M,M). System matrix.
    #    B - np.array of shape (M,N), emty list or None. Control signal matrix.
    #    C - np.array of shape (K,M). Measurement matrix.
    #    P - np.array of shape (M,M). Covariance at the previous update.
    #    Q - np.array of shape (M,M). Estimated covariance matrix of model noise.
    #    R - np.array of shape (K,K). Estimated covariance matrix of measurement noise.
    #    trajectory - Vectorvalued function handle. Intended acceleration trajectory.
    #    t - float. The current time.
    #    Ts - float. The timestep at which the new data is generated by openni.
    # RETURN:
    #    xhat - New estimate at t = h*k
    #    Pnew - New covariance matrix at t = h*k

    # Updates zhistory vector
    zhist[0:-1] = zhist[1:]
    zhist[-1] = z
    
    # Updates the covariance with the most recent synchronized measurement
    if np.isnan(zhist[0][0]):
        xhat = x
        xpred = x
    else:
        xhat, P = discrete_KF_update(x, u, zhist[-1], A, B, C, P, Q, R)
    
        # Predics what the future state will look like based on current data
        xpred = xhat
        Ppred = P
        for ii in range(len(zhist)-1):
            zpred = zhist[ii+1]
            zpred[1] = trajectory(t + (1 + ii - len(zhist))*Ts) + np.dot(np.random.randn(1),R[1,1])[0]
            xpred, Ppred = discrete_KF_update(xpred, u, zhist[ii+1], A, B, C, Ppred, Q, R)

    return xhat, xpred, P, zhist