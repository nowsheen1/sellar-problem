function out=Sub_system_2_opt(x1s,x2s,x3s,y1s,y2s)
%global count y2;
rng default
FUN = @Sub_sys_2_obj;

%X0 = [1;2;10]; % x(1)=xs,x(2)=t1,x(3)=t2
%A = [];
%B = [];
%Aeq = [];
%Beq = [];
%LB = [0;0;0];
%UB = [10;10;10];
%X0=[1.97763615778319;1.02520219788701e-05;6.52003581716219e-08];
X0 = [1;5;2]; % x1 , x2, x3
A = [];
B = [];
Aeq = [];
Beq = [];
LB = [0;0;0];
UB = [10;10;10];
trials.X=X0;
NONLCON = @constraints_Sub_sys_2;
%options = optimset('PlotFcns','optimplotfval','TolX',1e-7,'MaxIter',100000,'MaxFunEvals',100000,'Algorithm','sqp');
%options=optimoptions('fmincon','Algorithm','interior-point','MaxFunEvals' ,100000,'MaxIter' ,100000,'TolX',1e-100,'TolFun',1e-10,'Display','iter');
%options = optimoptions(options,'MaxFunEvals' ,100000);
%%TolFun is optimality tolerance%%fmincon takes the last option so be
%%careful about the options.
%options = optimoptions(options,'MaxIter' ,100000);
%options = optimset ('LargeScale', 'off', 'TolCon', 1e-8, 'TolX', 1e-8, 'TolFun',1e-7);
%options=optimoptions('surrogateopt','MinSampleDistance',10^-3,'MaxFunctionEvaluations',300);
%options=optimoptions('surrogateopt','MinSampleDistance',10^-10,'MaxFunctionEvaluations',900,'ConstraintTolerance',10^-10,'InitialPoints', trials);

%options=optimoptions('surrogateopt','InitialPoints', trials,'MinSurrogatePoints',50);
options=optimoptions('surrogateopt','InitialPoints', trials,'MinSurrogatePoints',50,'ConstraintTolerance',10^-10,'ObjectiveLimit',10^-10,'MaxFunctionEvaluations',300);
[X_Sub_sys_2,fval2,exitflag2,Output_sub_system_2] = surrogateopt(@(x)Sub_sys_2_obj(x),LB,UB,options);
%out_y2=sqrt(y1s)+X_Sub_sys_2(1)+X_Sub_sys_2(3);
%out_fval=fval2;
%out=[out_y2,out_fval];
%out=[y2,fval2];
out=[X_Sub_sys_2];

function f= Sub_sys_2_obj(x)
%u01=x(4);
%y2=sub_sys_2_coupling_solve(x,u01);
y2=sqrt(y1s)+x(1)+x(3);
%y2=sqrt(x(4))+x(1)+x(3);

f.Fval=(x(1)-x1s)^2+(x(3)-x3s)^2+((y2-y2s)^2);
%y2=sqrt(x(3))+x(1)+x(2);
%f.Fval=((y2-y2s)^2);

f.Ineq(1)=y2-24;
%f.Ineq(2)=abs(x(4)-y2);
%f.Ineq(3)=-abs(x(4)-y2);
end
end
