function [Ac,Bc,Gc] = getDynMat(phi,theta,psi,dphi,dtheta,dpsi,m,g,Ixx,Iyy,Izz,A)
%GETDYNMAT
%    [AC,BC,GC] = GETDYNMAT(PHI,THETA,PSI,DPHI,DTHETA,DPSI,M,G,IXX,IYY,IZZ,A)

%    This function was generated by the Symbolic Math Toolbox version 7.0.
%    23-Jan-2017 16:12:09

t2 = 1.0./m;
t3 = cos(phi);
t4 = t3.^2;
t5 = sin(phi);
t6 = t5.^2;
t7 = Iyy.^2;
t8 = cos(theta);
t9 = Izz.^2;
t10 = 1.0./t8;
t11 = t4.^2;
t12 = Iyy.*Izz.*t11;
t13 = t6.^2;
t14 = Iyy.*Izz.*t13;
t15 = Iyy.*Izz.*t4.*t6.*2.0;
t16 = t12+t14+t15;
t17 = 1.0./t16;
t18 = t8.^2;
t19 = sin(theta);
t20 = t19.^2;
t21 = 1.0./Ixx;
t22 = Ixx.^2;
t23 = dtheta.*t4.*t6.*t7;
t24 = dtheta.*t4.*t6.*t9;
t25 = dpsi.*t3.*t6.*t7.*t8;
t26 = dpsi.*t3.*t6.*t8.*t9;
t27 = Iyy.*Izz.*dpsi.*t3.*t5.*t6.*t8;
t28 = Iyy.*Izz.*dpsi.*t3.*t4.*t5.*t8;
t29 = Ixx.*Iyy.*dpsi.*t3.*t5.*t8;
t30 = t23+t24+t25+t26+t27+t28+t29-Ixx.*Iyy.*dtheta.*t4-Ixx.*Izz.*dtheta.*t6-Iyy.*Izz.*dtheta.*t4.*t6.*2.0-dpsi.*t3.*t4.*t5.*t8.*t9-dpsi.*t3.*t5.*t6.*t8.*t9-Ixx.*Izz.*dpsi.*t3.*t5.*t8-Iyy.*Izz.*dpsi.*t3.*t6.*t8.*2.0;
t31 = cos(psi);
t32 = sin(psi);
t33 = Iyy-Izz;
Ac = reshape([0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,1.0,0.0,0.0,-A.*t2,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,1.0,0.0,0.0,-A.*t2,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,1.0,0.0,0.0,-A.*t2,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,1.0,0.0,0.0,-t10.*t17.*t19.*t30,t17.*(dpsi.*t8.*t9.*t11+Ixx.*Iyy.*dpsi.*t6.*t8+Ixx.*Izz.*dpsi.*t4.*t8-Iyy.*Izz.*dpsi.*t8.*t11-Ixx.*Iyy.*dtheta.*t3.*t5+Ixx.*Izz.*dtheta.*t3.*t5-dpsi.*t4.*t5.*t8.*t9+dpsi.*t5.*t6.*t7.*t8+dpsi.*t4.*t6.*t8.*t9-dtheta.*t3.*t4.*t5.*t9+dtheta.*t3.*t5.*t6.*t7+Iyy.*Izz.*dpsi.*t4.*t5.*t8-Iyy.*Izz.*dpsi.*t4.*t6.*t8-Iyy.*Izz.*dpsi.*t5.*t6.*t8+Iyy.*Izz.*dtheta.*t3.*t4.*t5-Iyy.*Izz.*dtheta.*t3.*t5.*t6),-t10.*t17.*t30,0.0,0.0,0.0,0.0,0.0,0.0,0.0,1.0,0.0,t10.*t17.*t21.*(-Ixx.*dphi.*t7.*t11.*t19-Ixx.*dphi.*t9.*t13.*t19+Ixx.*dpsi.*t7.*t11.*t20+Ixx.*dpsi.*t9.*t13.*t20+Ixx.*Iyy.*Izz.*dphi.*t11.*t19+Ixx.*Iyy.*Izz.*dphi.*t13.*t19+Ixx.*Iyy.*Izz.*dpsi.*t11.*t18-Ixx.*Iyy.*Izz.*dpsi.*t11.*t20+Ixx.*Iyy.*Izz.*dpsi.*t13.*t18+Ixx.*Iyy.*Izz.*psi.*t11.*t20-Ixx.*dpsi.*t4.*t6.*t9.*t20-Iyy.*dpsi.*t4.*t9.*t11.*t18+Iyy.*dpsi.*t4.*t9.*t13.*t18-Iyy.*dpsi.*t6.*t9.*t11.*t18+Iyy.*dpsi.*t6.*t9.*t13.*t18+Izz.*dpsi.*t4.*t7.*t11.*t18-Izz.*dpsi.*t4.*t7.*t13.*t18+Izz.*dpsi.*t6.*t7.*t11.*t18-Izz.*dpsi.*t6.*t7.*t13.*t18+Ixx.*psi.*t4.*t6.*t9.*t20+Iyy.*dtheta.*t3.*t5.*t8.*t9.*t11+Iyy.*dtheta.*t3.*t5.*t8.*t9.*t13-Izz.*dtheta.*t3.*t5.*t7.*t8.*t11-Izz.*dtheta.*t3.*t5.*t7.*t8.*t13+Ixx.*Iyy.*Izz.*dpsi.*t4.*t6.*t18.*2.0+Ixx.*Iyy.*Izz.*dpsi.*t4.*t6.*t20.*2.0+Iyy.*dtheta.*t3.*t4.*t5.*t6.*t8.*t9.*2.0-Izz.*dtheta.*t3.*t4.*t5.*t6.*t7.*t8.*2.0),t3.*t5.*t17.*t33.*(Iyy.*dphi.*t4+Izz.*dphi.*t6-Izz.*psi.*t4.*t19-Iyy.*dpsi.*t4.*t19+Izz.*dpsi.*t4.*t19-Izz.*dpsi.*t6.*t19),t10.*t17.*(-dphi.*t7.*t11-dphi.*t9.*t13+dpsi.*t7.*t11.*t19+dpsi.*t9.*t13.*t19+Iyy.*Izz.*dphi.*t11+Iyy.*Izz.*dphi.*t13-Iyy.*Izz.*dpsi.*t11.*t19+Iyy.*Izz.*psi.*t11.*t19-dpsi.*t4.*t6.*t9.*t19+psi.*t4.*t6.*t9.*t19+Iyy.*Izz.*dpsi.*t4.*t6.*t19.*2.0),0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,1.0,t10.*t17.*t21.*(-Iyy.*dtheta.*t4.*t20.*t22-Izz.*dtheta.*t6.*t20.*t22+Ixx.*Iyy.*Izz.*dtheta.*t11.*t20+Ixx.*Iyy.*Izz.*dtheta.*t13.*t20+Ixx.*dtheta.*t4.*t6.*t7.*t20+Ixx.*dtheta.*t4.*t6.*t9.*t20-Iyy.*dpsi.*t3.*t5.*t8.*t20.*t22+Izz.*dpsi.*t3.*t5.*t8.*t20.*t22-Ixx.*dphi.*t3.*t4.*t5.*t7.*t8.*t19+Ixx.*dphi.*t3.*t5.*t6.*t8.*t9.*t19+Ixx.*dpsi.*t3.*t4.*t5.*t7.*t8.*t20-Ixx.*dpsi.*t3.*t4.*t5.*t8.*t9.*t20+Ixx.*dpsi.*t3.*t5.*t6.*t7.*t8.*t20-Ixx.*dpsi.*t3.*t5.*t6.*t8.*t9.*t20-Iyy.*dpsi.*t3.*t5.*t8.*t9.*t11.*t18-Iyy.*dpsi.*t3.*t5.*t8.*t9.*t13.*t18+Izz.*dpsi.*t3.*t5.*t7.*t8.*t11.*t18+Izz.*dpsi.*t3.*t5.*t7.*t8.*t13.*t18-Iyy.*dpsi.*t3.*t4.*t5.*t6.*t8.*t9.*t18.*2.0+Izz.*dpsi.*t3.*t4.*t5.*t6.*t7.*t8.*t18.*2.0+Ixx.*Iyy.*Izz.*dphi.*t3.*t4.*t5.*t8.*t19-Ixx.*Iyy.*Izz.*dphi.*t3.*t5.*t6.*t8.*t19),-t17.*(-dphi.*t4.*t6.*t7.*t8-dphi.*t4.*t6.*t8.*t9+dpsi.*t7.*t8.*t13.*t19+dpsi.*t8.*t9.*t11.*t19+dpsi.*t4.*t6.*t7.*t8.*t19+dpsi.*t4.*t6.*t8.*t9.*t19-dtheta.*t3.*t4.*t5.*t9.*t19+dtheta.*t3.*t5.*t6.*t7.*t19-Ixx.*Iyy.*dpsi.*t6.*t8.*t19-Ixx.*Izz.*dpsi.*t4.*t8.*t19+Iyy.*Izz.*dphi.*t4.*t6.*t8.*2.0-Ixx.*Iyy.*dtheta.*t3.*t5.*t19+Ixx.*Izz.*dtheta.*t3.*t5.*t19+Iyy.*Izz.*dtheta.*t3.*t4.*t5.*t19-Iyy.*Izz.*dtheta.*t3.*t5.*t6.*t19),t10.*t17.*(-Ixx.*Iyy.*dtheta.*t4.*t19-Ixx.*Izz.*dtheta.*t6.*t19+Iyy.*Izz.*dtheta.*t11.*t19+Iyy.*Izz.*dtheta.*t13.*t19+dtheta.*t4.*t6.*t7.*t19+dtheta.*t4.*t6.*t9.*t19-dphi.*t3.*t4.*t5.*t7.*t8+dphi.*t3.*t5.*t6.*t8.*t9-Ixx.*Iyy.*dpsi.*t3.*t5.*t8.*t19+Ixx.*Izz.*dpsi.*t3.*t5.*t8.*t19+Iyy.*Izz.*dphi.*t3.*t4.*t5.*t8-Iyy.*Izz.*dphi.*t3.*t5.*t6.*t8+dpsi.*t3.*t4.*t5.*t7.*t8.*t19-dpsi.*t3.*t4.*t5.*t8.*t9.*t19+dpsi.*t3.*t5.*t6.*t7.*t8.*t19-dpsi.*t3.*t5.*t6.*t8.*t9.*t19)],[12,12]);
if nargout > 1
    t34 = Iyy.*Izz.*t11.*t18;
    t35 = Iyy.*Izz.*t13.*t18;
    t36 = Iyy.*Izz.*t4.*t6.*t18.*2.0;
    t37 = Iyy.*Izz.*t8.*t13;
    t38 = Iyy.*Izz.*t8.*t11;
    t39 = Iyy.*Izz.*t4.*t6.*t8.*2.0;
    t40 = t37+t38+t39;
    t41 = 1.0./t40;
    t42 = Iyy.*t4;
    t43 = Izz.*t6;
    t44 = t42+t43;
    t45 = t34+t35+t36;
    t46 = 1.0./t45;
    t47 = t19.*t44.*t46;
    Bc = reshape([0.0,0.0,0.0,t2.*(t5.*t32+t3.*t19.*t31),-t2.*(t5.*t31-t3.*t19.*t32),t2.*t3.*t8,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,(t34+t35+t36+Ixx.*Iyy.*t4.*t20+Ixx.*Izz.*t6.*t20)./(Ixx.*Iyy.*Izz.*t11.*t18+Ixx.*Iyy.*Izz.*t13.*t18+Ixx.*Iyy.*Izz.*t4.*t6.*t18.*2.0),-t3.*t5.*t19.*t33.*t41,t47,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,-t3.*t5.*t19.*t33.*t41,t17.*(Iyy.*t6+Izz.*t4),-t3.*t5.*t33.*t41,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,t47,-t3.*t5.*t33.*t41,t44.*t46],[12,4]);
end
if nargout > 2
    Gc = [0.0;0.0;0.0;0.0;0.0;-g;0.0;0.0;0.0;0.0;0.0;0.0];
end