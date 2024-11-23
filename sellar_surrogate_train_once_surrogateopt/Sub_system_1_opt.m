function []=Sub_system_1_opt()
%global count1 y1;
global evalHistory; 
evalHistory=[];
rng default
%X0 = [1;5;2;4]; % x(1)=xs,x(2)=t1,x(3)=t2
%A = [];
%B = [];
%Aeq = [];
%Beq = [];
%LB = [0;0;0;0];
%UB = [10;10;10;10];
%X0=[1.97763615778319;1.02520219788701e-05;6.52003581716219e-08];
X0 = [1;5;2;1.97;0;0;0;0];  
%X0 = [1;5;2];  
A = [];
B = [];
Aeq = [];
Beq = [];
LB = [0;0;0;0;0;0;0;0];
UB = [10;10;10;10;10;10;10;10];

trials.X=X0;
%trials.Fval=y0;
% options.InitialPoints = trials;
%options = optimoptions('surrogateopt','PlotFcn','InitialPoints', trials);

%options = optimset('PlotFcns','optimplotfval','TolX',1e-7,'MaxIter',100000,'MaxFunEvals',100000,'Algorithm','sqp');
%options=optimoptions('fmincon','Algorithm','interior-point','MaxFunEvals' ,1000,'MaxIter' ,1000,'TolX',1e-100,'TolFun',1e-10,'Display','iter');
%options = optimoptions(options,'MaxFunEvals' ,100000);
%%TolFun is optimality tolerance%%fmincon takes the last option so be
%%careful about the options.
%options = optimoptions(options,'MaxIter' ,100000);
%options = optimset ('LargeScale', 'off', 'TolCon', 1e-8, 'TolX', 1e-8, 'TolFun',1e-7);
%options=optimoptions('surrogateopt','MinSampleDistance',10^-10,'MaxFunctionEvaluations',900,'ConstraintTolerance',10^-10,'InitialPoints', trials);


options=optimoptions('surrogateopt','InitialPoints', trials,'MinSurrogatePoints',50,'ObjectiveLimit',10^-10,'ConstraintTolerance',10^-10,'MaxFunctionEvaluations',300);

[X_Sub_sys_1,fval1,exitflag1,Output_sub_system_1] = surrogateopt(@(x)Sub_sys_1_obj(x),LB,UB,options);
%out=[y1,fval1];
%out_y1=X_Sub_sys_1(1)^2+X_Sub_sys_1(2)+X_Sub_sys_1(3)-0.2*y2s;
%out_fval=fval1;
%out=[out_y1,out_fval];

X = [evalHistory(:, 1),evalHistory(:, 2),evalHistory(:, 3),evalHistory(:, 4),evalHistory(:, 5),evalHistory(:, 6),evalHistory(:, 7),evalHistory(:, 8)]; % Inputs
Y = evalHistory(:, 9); % Objective values
% Fit a Gaussian process to visualize the surrogate
gpModel1 = fitrgp(X, Y);

% Predict across the domain
save('gp_model_1.mat', 'gpModel1', '-v7.3');
save('optimal_solution_1.mat', 'X_Sub_sys_1', '-v7.3');

function f= Sub_sys_1_obj(x)

  y1=  x(1)^2+x(2)+x(3)-0.2*x(8); %x1s is x(4),x2s is x(5),x3s is x(6),y1s is x(7),y2s is x(8)
   %y1=  x(1)^2+x(2)+x(3)-0.2*x(4);
  f.Fval=(x(1)-x(4))^2+(x(2)-x(5))^2+(x(3)-x(6))^2+((y1-x(7))^2);
 %v01=x(4);
  %y1=sub_sys_1_coupling_solve(x,v01);
 % y1=  x(1)^2+x(2)+x(3)-0.2*x(4);
  %coupling0=[1;1];
  %f_sol_out=  sub_sys_1_coupling_solve(x,coupling0);
  %y1=f_sol_out(1);
  %y2s=f_sol_out(2);
  
  %y1=  x(1)^2+x(2)+x(3)-0.2*x(4);
%f.Fval=((y1-y1s)^2);
 %c(1)=3.16-y1;

%ceq=[abs(x(4)-y1)];
f.Ineq(1)=3.16-y1;
%f.Ineq(2)=abs(x(4)-y1);
%f.Ineq(3)=-abs(x(4)-y1);
evalHistory = [evalHistory; x, f.Fval];

end
end
