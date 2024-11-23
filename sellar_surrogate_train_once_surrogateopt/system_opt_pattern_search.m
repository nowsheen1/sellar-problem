
function system_opt_pattern_search()
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
X0=[3.4389;0.3;0.002];
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
options = optimoptions('patternsearch',...
    'InitialMeshSize',1e-9,...
    'MaxIterations',1,'UseCompletePoll',true);
%options=optimoptions('fmincon','MaxFunEvals' ,300,'MaxIter' ,1000,'TolX',1e-6,'TolFun',1e-6,'TolCon',10^-2,'FiniteDifferenceStepSize',10^-16,'ScaleProblem', true,'Display','iter');


%options = optimoptions(options,'MaxFunEvals' ,100000);
%%TolFun is optimality tolerance%%fmincon takes the last option so be
%%careful about the options.
%options = optimoptions(options,'MaxIter' ,100000);
%options = optimset ('LargeScale', 'off', 'TolCon', 1e-8, 'TolX', 1e-8, 'TolFun',1e-7);

problem = createOptimProblem('fmincon', ...
    'objective',FUN,'x0',[3.4389;0.3;0.002], ...
    'lb',[0;0;0],'ub',[10;10;10],'options',options);
problem.solver = 'patternsearch';
[X,fval,exitflag,Output] = patternsearch(problem)
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