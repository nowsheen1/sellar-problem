function [z]=Sub_system_2_opt(x1s,x2s,x3s,y1s,y2s)
global count   rho2  lambda2;

FUN = @Sub_sys_2_obj;
%X0 = [1;2;10]; % x(1)=xs,x(2)=t1,x(3)=t2
X0 = [1;5;2]; % x1 , x2, x3
A = [];
B = [];
Aeq = [];
Beq = [];
LB = [0;0;0];
UB = [10;10;10];
NONLCON = @constraints_Sub_sys_2;
%options = optimset('PlotFcns','optimplotfval','TolX',1e-7,'MaxIter',100000,'MaxFunEvals',100000,'Algorithm','sqp');
options=optimoptions('fmincon','Algorithm','interior-point','MaxFunEvals' ,100000,'MaxIter' ,100000,'TolX',1e-100,'TolFun',1e-10,'Display','iter');

%options=optimoptions('fmincon','Algorithm','interior-point','MaxFunEvals' ,1000,'MaxIter' ,1000,'TolX',1e-100,'TolFun',1e-10);
%options=optimoptions('fmincon','Algorithm','interior-point','MaxFunEvals' ,100000,'MaxIter' ,100000,'TolX',1e-16,'TolFun',1e-16,'TolCon',10^-16,'Display','iter');

%options = optimoptions(options,'MaxFunEvals' ,100000);
%%TolFun is optimality tolerance%%fmincon takes the last option so be
%%careful about the options.
%options = optimoptions(options,'MaxIter' ,100000);
%options = optimset ('LargeScale', 'off', 'TolCon', 1e-8, 'TolX', 1e-8, 'TolFun',1e-7);
[X_Sub_sys_2,fval2,exitflag2,Output2] = fmincon(FUN,X0,A,B,Aeq,Beq,LB,UB,NONLCON,options,x1s,x2s,x3s,y1s,y2s);
z=[X_Sub_sys_2',lambda2,rho2];
end
%out=[y2]
function f= Sub_sys_2_obj(x,x1s,x2s,x3s,y1s,y2s)

    global rho2  lambda2;
 % v01=x(4);
    %load('optimal_soln_1','X_Sub_sys_1');
 % y1=sub_sys_1_coupling_solve(x,v01);
   y1=   x(1)^2+ x(2)+ x(3)-0.2*y2s;
   y2=sqrt(y1s)+x(1)+x(3);
   f1=x2s^2+x3s+y1+exp(-y2)
   f=f1+lambda2*((x(1)-x1s)+(x(3)-x3s)+((y2-y2s)))+0.5*rho2*((x(1)-x1s)^2+(x(3)-x3s)^2+((y2-y2s)^2)); %x2 is sj . if there was more than one constraint then it could become x(2)+x(3)+....for one dimensioal variable
%%x2 is xs and x1, a2 is x2, x3 is x3
%gradf=[0.5*2*((x1s^2+x(1)+x3s-0.2*y2s)-y1s)*2*x1s; 0.5*2*((x1s^2+x(1)+x3s-0.2*y2s)-y1s)*1;0.5*2*((x1s^2+x(1)+x3s-0.2*y2s)-y1s)*(-1);0.5*2*((x1s^2+x(1)+x3s-0.2*y2s)-y1s)*(-0.2)];
%derivative wrt x1s, x2s y1s y3s.
   lambda2=lambda2+rho2*((x(1)-x1s)+(x(3)-x3s)+((y2-y2s)));
   rho2=rho2*1.1;

%u01=x(4);
%y2=sub_sys_2_coupling_solve(x,u01);

%y2=sqrt(y1s)+x(1)+x(3)
%f=(x(1)-x1s)^2+(x(3)-x3s)^2+((y2-y2s)^2);

%y2=sqrt(x(3))+x(1)+x(2);
%coupling0=[1;1];
%f_sol_out=  sub_sys_2_coupling_solve(x,coupling0);
%y2=f_sol_out(2);
%f=((y2-y2s)^2);
end
function [c,ceq]=constraints_Sub_sys_2(x,x1s,x2s,x3s,y1s,y2s)
%u01=x(4);
%y2=sub_sys_2_coupling_solve(x,u01);
%y2=sqrt(x(4))+x(1)+x(3);
y2=sqrt(y1s)+x(1)+x(3);
%y2=sqrt(x(3))+x(1)+x(2);
%coupling0=[1;1];
%f_sol_out=  sub_sys_2_coupling_solve(x,coupling0);
%y2=f_sol_out(2);
c(1)=y2-24;
%ceq=[abs(x(4)-y2)];
ceq=[];
end
