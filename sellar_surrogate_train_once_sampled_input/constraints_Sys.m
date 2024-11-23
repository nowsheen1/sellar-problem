function[c,ceq]= constraints_Sys(x)
Sub_system_1_output=Sub_system_1_opt(x(4),x(5));
Sub_system_2_output=Sub_system_2_opt(x(4),x(5));
c=[];
ceq(1)=Sub_system_1_output(5);
ceq(2)=Sub_system_2_output(4);

end