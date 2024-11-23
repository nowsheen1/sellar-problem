
function [f,c,ceq]=compute_performance(x)
global count_sys
count_sys=count_sys+1;
coupling0=[1;1];
f_sol_out=  sys_coupling_solve(x,coupling0);
y1s=f_sol_out(1);
y2s=f_sol_out(2);
Sub_system_1_output=Sub_system_1_opt(x(1),x(2),x(3),y1s,y2s);
Sub_system_2_output=Sub_system_2_opt(x(1),x(2),x(3),y1s,y2s);

%y1=  Sub_system_1_output(1)^2+Sub_system_1_output(2)+Sub_system_1_output(3)-0.2*Sub_system_1_output(4);
%y2=sqrt(Sub_system_2_output(3))+Sub_system_2_output(1)+Sub_system_2_output(2);

y1=  Sub_system_1_output(1);
y2=  Sub_system_2_output(1);

f=x(2)^2+x(3)+y1+exp(-y2);



c=[];
%ceq(1)=(y1-x(4))^2;
%ceq(2)=(y2-x(5))^2;

%ceq(1)=Sub_system_1_output(2);
%ceq(2)=Sub_system_2_output(2);

ceq(1)=(y1-y1s)^2;
ceq(2)=(y2-y2s)^2;

end

