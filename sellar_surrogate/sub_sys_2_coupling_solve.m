function y=sub_sys_2_coupling_solve(x,u01)
fun = @eqn;
options = optimoptions('fsolve','Display','none');

y = fsolve(fun,u01,options);

 function f=eqn(coupling)
  %f(1)=coupling(1)-(x(1)^2+x(2)+x(3)-0.2*coupling(2));
  f=coupling-(sqrt(u01)+x(1)+x(3));
 end
end
