FUN = @Sys_obj;
global count count1 count_sys;
count_sys=0;
count=0;
count1=0;
%X0 = [1;5;2;10;4]; % x(1)=xs,x(2)=t1,x(3)=t2
%%last old
%X0 = [1;5;2;1;1]; % x(1)=xs,x(2)=t1,x(3)=t2
%%new
X0 = [1.97;0;0;1;1]; % x(1)=xs,x(2)=t1,x(3)=t2
A = [];
B = [];
Aeq = [];
Beq = [];
LB = [0;0;0;0.1;0.1];
UB = [10;10;10;1000;1000];
NONLCON = @constraints_Sys;
%options = optimset('PlotFcns','optimplotfval','TolX',1e-7,'MaxIter',100000,'MaxFunEvals',100000,'Algorithm','sqp');
%options=optimoptions('fmincon','Algorithm','interior-point','MaxFunEvals' ,100000,'MaxIter' ,100000,'TolX',1e-100,'TolFun',1e-10,'Display','iter');

%options=optimoptions('fmincon','MaxFunEvals' ,300,'MaxIter' ,1000,'TolX',1e-6,'TolFun',1e-6,'TolCon',10^-2,'Display','iter','FiniteDifferenceStepSize',10^-8,'ScaleProblem', true);
%%last old
%
%%new
options=optimoptions('fmincon','Algorithm','sqp','MaxFunEvals' ,300,'MaxIter' ,1000,'TolX',1e-3,'TolFun',1e-6,'TolCon',10^-2,'ScaleProblem', true,'Display','iter','PlotFcn','optimplotfval');

%options=optimoptions('fmincon','MaxFunEvals' ,1000000,'MaxIter' ,10000000,'TolX',1e-16,'TolFun',1e-16,'TolCon',10^-16,'Display','iter','FiniteDifferenceStepSize',10^-8,'ScaleProblem', true);
%options=optimoptions('fmincon','ScaleProblem', true);
%options = optimoptions(options,'MaxFunEvals' ,100000);
%%TolFun is optimality tolerance%%fmincon takes the last option so be
%%careful about the options.
%options = optimoptions(options,'MaxIter' ,100000);
%options = optimset ('LargeScale', 'off', 'TolCon', 1e-8, 'TolX', 1e-8, 'TolFun',1e-7);
[X,fval,exitflag,Output] = fmincon(FUN,X0,A,B,Aeq,Beq,LB,UB,NONLCON);
z=count;
h=count1;
cn=count_sys