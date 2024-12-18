
function [f]=compute_performance(x)
global count_sys lambda2 rho2 lambda1 rho1

count_sys=count_sys+1;
coupling0=[1;1];
f_sol_out=  sys_coupling_solve(x,coupling0);
y1s=f_sol_out(1);
y2s=f_sol_out(2);
save('store1.mat','y1s');
save('store2.mat','y2s');
Sub_system_1_output=Sub_system_1_opt(x(1),x(2),x(3),y1s,y2s);
Sub_system_2_output=Sub_system_2_opt(x(1),x(2),x(3),y1s,y2s);

x11=Sub_system_1_output(1);
x12=Sub_system_1_output(2);
x13=Sub_system_1_output(3);

x21=Sub_system_2_output(1);
x22=Sub_system_2_output(2);
x23=Sub_system_2_output(3);

lambda1=Sub_system_1_output(4);
rho1=Sub_system_1_output(5);
lambda2=Sub_system_2_output(4);
rho2=Sub_system_2_output(5);

y1=  x11^2+x12+x13-0.2*y2s;
y2=sqrt(y1s)+x21+x23; 

save('store3.mat','y1');
save('store4.mat','y2');

%y1=  Sub_system_1_output(1)^2+Sub_system_1_output(2)+Sub_system_1_output(3)-0.2*Sub_system_1_output(4);
%y2=sqrt(Sub_system_2_output(3))+Sub_system_2_output(1)+Sub_system_2_output(2);

%y1=  Sub_system_1_output(1);
%y2=  Sub_system_2_output(1);
f=(((x11+lambda1/rho1-x(1)))).^2+(((x12+lambda1/rho1-x(2)))).^2+(((x13+lambda1/rho1-x(3)))).^2+(((x21+lambda2/rho2-x(1)))).^2+(((x22+lambda2/rho2-x(2)))).^2++(((x23+lambda2/rho2-x(3)))).^2;

%f=x(2)^2+x(3)+y1+exp(-y2);



%c=[];
%ceq(1)=(y1-x(4))^2;
%ceq(2)=(y2-x(5))^2;

%ceq(1)=(y1-y1s)^2;
%ceq(2)=(y2-y2s)^2;

%ceq(1)=(x(1)-Sub_system_1_output(2))^2+(x(2)-Sub_system_1_output(3))^2+(x(3)-Sub_system_1_output(4))^2+((y1-y1s)^2);
%ceq(2)=(x(1)-Sub_system_2_output(2))^2+(x(3)-Sub_system_2_output(4))^2+((y2-y2s)^2);


end