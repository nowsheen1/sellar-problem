function[c,ceq]= constraints_Sys(x)
Sub_system_1_output=Sub_system_1_opt(x(4),x(5));
Sub_system_2_output=Sub_system_2_opt(x(4),x(5));
y1s=  x(1)^2+x(2)+x(3)-0.2*x(5);
y2s=sqrt(x(4))+x(1)+x(2);
y1=  Sub_system_1_output(1)^2+Sub_system_1_output(2)+Sub_system_1_output(3)-0.2*Sub_system_1_output(4);
y2=sqrt(Sub_system_2_output(3))+Sub_system_2_output(1)+Sub_system_2_output(2);
c=[];
%ceq(1)=(y1-x(4))^2;
%ceq(2)=(y2-x(5))^2;
ceq(1)=(y1-y1s)^2;
ceq(2)=(y2-y2s)^2;
end