function f= Sys_obj(x)
global count_sys
count_sys=count_sys+1;
Sub_system_1_output=Sub_system_1_opt(x(4),x(5));
Sub_system_2_output=Sub_system_2_opt(x(4),x(5));
y1=  Sub_system_1_output(1)^2+Sub_system_1_output(2)+Sub_system_1_output(3)-0.2*Sub_system_1_output(4);
y2=sqrt(Sub_system_2_output(3))+Sub_system_2_output(1)+Sub_system_2_output(2);

f=x(2)^2+x(3)+y1+exp(-y2);
end