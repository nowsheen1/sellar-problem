function System_optimization()
FUN = @Sys_obj_new;
xLast=[];
myf = []; % Use for objective at xLast
myc = []; % Use for nonlinear inequality constraint
myceq = []; % Use for nonlinear equality constraint
global count count1 count_sys;

count_sys=0;
count=0;
count1=0;
%X0 = [1;5;2]; % x(1)=xs,x(2)=t1,x(3)=t2
%X0=[1.97763615778319;1.02520219788701e-05;6.52003581716219e-08];
X0=[1.97;0;0];

%X0=[1;0;0];
A = [];
B = [];
Aeq = [];
Beq = [];
LB = [0;0;0];
UB = [10;10;10];
NONLCON = @constraints_Sys_new;
%options = optimset('PlotFcns','optimplotfval','TolX',1e-7,'MaxIter',100000,'MaxFunEvals',100000,'Algorithm','sqp');
%options=optimoptions('fmincon','Algorithm','interior-point','MaxFunEvals' ,100000,'MaxIter' ,100000,'TolX',1e-100,'TolFun',1e-10,'Display','iter');

%options=optimoptions('fmincon','MaxFunEvals' ,300,'MaxIter' ,1000,'TolX',1e-6,'TolFun',1e-6,'TolCon',10^-2,'Display','iter','FiniteDifferenceStepSize',10^-8);
%

%options=optimoptions('fmincon','MaxFunEvals' ,300,'MaxIter' ,1000,'TolX',1e-6,'TolFun',1e-6,'TolCon',10^-2,'FiniteDifferenceStepSize',  10^-16,'ScaleProblem', true,'Display','iter');

%options=optimoptions('fmincon','MaxFunEvals' ,300,'MaxIter' ,1000,'TolX',1e-16,'TolFun',1e-6,'TolCon',10^-2,'DiffMinChange',  10^0,'FiniteDifferenceStepSize',  10^-32,'ScaleProblem', true,'Display','iter');

%options=optimoptions('fmincon','Algorithm','sqp','MaxFunEvals' ,300,'MaxIter' ,1000,'TolX',1e-6,'TolFun',1e-6,'TolCon',10^-2,'FiniteDifferenceStepSize',  10^-8,'ScaleProblem', true,'Display','iter','PlotFcn','optimplotfval');


options=optimoptions('fmincon','Algorithm','sqp','MaxFunEvals' ,300,'MaxIter' ,1000,'TolX',1e-3,'TolFun',1e-6,'TolCon',10^-2,'ScaleProblem', true,'Display','iter','PlotFcn','optimplotfval');

%options = optimoptions(options,'MaxFunEvals' ,100000);
%%TolFun is optimality tolerance%%fmincon takes the last option so be
%%careful about the options.
%options = optimoptions(options,'MaxIter' ,100000);
%options = optimset ('LargeScale', 'off', 'TolCon', 1e-8, 'TolX', 1e-8, 'TolFun',1e-7);
[X,fval,exitflag,Output] = fmincon(FUN,X0,A,B,Aeq,Beq,LB,UB,NONLCON,options)
z=count;
h=count1;
cn=count_sys
function y = Sys_obj_new(x)
        if ~isequal(x,xLast) % Check if computation is necessary
            [myf,myc,myceq] = compute_performance(x);
            xLast = x;
        end
        % Now compute objective function
        y = myf;
end
function [c,ceq] = constraints_Sys_new(x)
        if ~isequal(x,xLast) % Check if computation is necessary
            [myf,myc,myceq] = compute_performance(x);
            xLast = x;
        end
        % Now compute constraint function
        c = myc; % In this case, the computation is trivial
        ceq = myceq;
    end
end