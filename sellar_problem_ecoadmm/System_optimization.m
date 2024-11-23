function System_optimization()
FUN = @Sys_obj_new;
xLast=[];
myf = []; % Use for objective at xLast
myc = []; % Use for nonlinear inequality constraint
myceq = [];
global count count1 count_sys rho2 lambda2 rho1 lambda1;
rho1=0.1;
%lambda=11;
lambda1=0;
rho2=0.1;
lambda2=0;
count_sys=0;
count=0;
count1=0;
%X0 = [1;5;2;10;4]; % x(1)=xs,x(2)=t1,x(3)=t2
%X0 = [1;5;2]; % x(1)=xs,x(2)=t1,x(3)=t2 %used before

X0 = [1.97;0;0]; %changed in 30 October
A = [];
B = [];
Aeq = [];
Beq = [];
LB = [0;0;0];
UB = [10;10;10];

%options = optimset('PlotFcns','optimplotfval','TolX',1e-7,'MaxIter',100000,'MaxFunEvals',100000,'Algorithm','sqp');
%options=optimoptions('fmincon','Algorithm','interior-point','MaxFunEvals' ,100000,'MaxIter' ,100000,'TolX',1e-100,'TolFun',1e-10,'Display','iter');

%options=optimoptions('fmincon','Algorithm','sqp','MaxFunEvals' ,300,'MaxIter' ,1000,'TolX',1e-3,'TolFun',1e-6,'TolCon',10^-2,'Display','iter','FiniteDifferenceStepSize',10^-8,'ScaleProblem', true,'Display','iter');
%

%options=optimoptions('fmincon','Algorithm','sqp','MaxFunEvals' ,300,'MaxIter' ,1000,'TolX',10^-3,'TolFun',1e-6,'TolCon',10^-6,'Display','iter','Display','iter');

options=optimoptions('fmincon','Algorithm','sqp','MaxFunEvals' ,300,'MaxIter' ,1000,'TolX',1e-16,'TolFun',1e-6,'TolCon',10^-2,'ScaleProblem', true,'Display','iter','PlotFcn','optimplotfval');
%options=optimoptions('fmincon','MaxFunEvals' ,1000000,'MaxIter' ,10000000,'TolX',1e-16,'TolFun',1e-16,'TolCon',10^-16,'Display','iter','FiniteDifferenceStepSize',10^-8,'ScaleProblem', true);
%options=optimoptions('fmincon','ScaleProblem', true);
%options = optimoptions(options,'MaxFunEvals' ,100000);
%%TolFun is optimality tolerance%%fmincon takes the last option so be
%%careful about the options.
%options = optimoptions(options,'MaxIter' ,100000);
%options = optimset ('LargeScale', 'off', 'TolCon', 1e-8, 'TolX', 1e-8, 'TolFun',1e-7);
[X,fval,exitflag,Output] = fmincon(FUN,X0,A,B,Aeq,Beq,LB,UB,[],options)
z=count;
h=count1;
cn=count_sys
function y = Sys_obj_new(x)
        if ~isequal(x,xLast) % Check if computation is necessary
            [myf] = compute_performance(x);
            xLast = x;
        end
        % Now compute objective function
        y = myf;
    end

end