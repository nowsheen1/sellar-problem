function y=sys_coupling_solve(x,coupling0)
fun = @eqn;

options = optimoptions('fsolve','Display','none');
y = fsolve(fun,coupling0,options);

 function f=eqn(coupling)
  f(1)=coupling(1)-(x(1)^2+x(2)+x(3)-0.2*coupling(2));
  f(2)=coupling(2)-(sqrt(coupling(1))+x(1)+x(3));
 end
end
