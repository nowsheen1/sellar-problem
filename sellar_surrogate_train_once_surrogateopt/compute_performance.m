
function [f,c,ceq]=compute_performance(x)
global count_sys
count_sys=count_sys+1;
coupling0=[1;1];
f_sol_out=  sys_coupling_solve(x,coupling0);
y1s=f_sol_out(1);
y2s=f_sol_out(2);




load('gp_model_1.mat', 'gpModel1');
load('gp_model_2.mat', 'gpModel2');

load('optimal_solution_1.mat', 'X_Sub_sys_1');
load('optimal_solution_2.mat', 'X_Sub_sys_2');


x11=X_Sub_sys_1(1);
x12=X_Sub_sys_1(2);
x13=X_Sub_sys_1(3);

x21=X_Sub_sys_2(1);
x22=X_Sub_sys_2(2);
x23=X_Sub_sys_2(3);

y1=  x11^2+x12+x13-0.2*y2s;
y2=sqrt(y1s)+x21+x23; 

f=x(2)^2+x(3)+y1+exp(-y2);

pred_point_1=[x11,x12,x13,x(1),x(2),x(3),y1s,y2s];
pred_point_2=[x21,x22,x23,x(1),x(2),x(3),y1s,y2s];

c=[];

ceq(1)=predict(gpModel1,pred_point_1);
ceq(2)=predict(gpModel2,pred_point_2 );

c=[];
%ceq(1)=(y1-x(4))^2;
%ceq(2)=(y2-x(5))^2;

%ceq(1)=Sub_system_1_output(2);
%ceq(2)=Sub_system_2_output(2);

%ceq(1)=(y1-y1s)^2;
%ceq(2)=(y2-y2s)^2;

end

