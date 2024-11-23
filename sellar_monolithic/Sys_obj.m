function f= Sys_obj(x)
global count_sys
count_sys=count_sys+1;
f=x(2)^2+x(3)+x(4)+exp(-x(5));
end