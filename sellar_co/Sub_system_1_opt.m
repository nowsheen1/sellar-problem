function out=Sub_system_1_opt(x1s,x2s,x3s,y1s,y2s)
global count1 y1;
FUN = @Sub_sys_1_obj;
X0 = [1;5;2];  
%X0 = [1;5;2];  
A = [];
B = [];
Aeq = [];
Beq = [];
LB = [0;0;0];
UB = [10;10;10];
NONLCON = @constraints_Sub_sys_1;
%options = optimset('PlotFcns','optimplotfval','TolX',1e-7,'MaxIter',100000,'MaxFunEvals',100000,'Algorithm','sqp');
options=optimoptions('fmincon','Algorithm','interior-point','MaxFunEvals' ,1000,'MaxIter' ,1000,'TolX',1e-100,'TolFun',1e-10);
%options = optimoptions(options,'MaxFunEvals' ,100000);
%%TolFun is optimality tolerance%%fmincon takes the last option so be
%%careful about the options.
%options = optimoptions(options,'MaxIter' ,100000);
%options = optimset ('LargeScale', 'off', 'TolCon', 1e-8, 'TolX', 1e-8, 'TolFun',1e-7);
[X_Sub_sys_1,fval1,exitflag1,Output1] = fmincon(FUN,X0,A,B,Aeq,Beq,LB,UB,NONLCON,options);
out=[y1]
function f= Sub_sys_1_obj(x)
 % v01=x(4);
 % y1=sub_sys_1_coupling_solve(x,v01);
  y1=  x(1)^2+x(2)+x(3)-0.2*y2s
  f=(x(1)-x1s)^2+(x(2)-x2s)^2+(x(3)-x3s)^2+((y1-y1s)^2);
 % y1=  x(1)^2+x(2)+x(3)-0.2*x(4);
  %coupling0=[1;1];
  %f_sol_out=  sub_sys_1_coupling_solve(x,coupling0);
  %y1=f_sol_out(1);
  %y2s=f_sol_out(2);
  %f=((y1-y1s)^2);
end
function [c,ceq]=constraints_Sub_sys_1(x)
% v01=x(4);
% y1=  x(1)^2+x(2)+x(3)-0.2*x(4);
y1=  x(1)^2+x(2)+x(3)-0.2*y2s;
 %y1=sub_sys_1_coupling_solve(x,v01);
%y1=  x(1)^2+x(2)+x(3)-0.2*x(4);
 %coupling0=[1;1];
 %f_sol_out=  sub_sys_1_coupling_solve(x,coupling0);
 %y1=f_sol_out(1);
 c(1)=3.16-y1;

%ceq=[abs(x(4)-y1)];
ceq=[];
end

end