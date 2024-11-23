function y=sub_sys_1_coupling_solve(x,v01)
fun = @eqn;
options = optimoptions('fsolve','Display','none');

y = fsolve(fun,v01,options);

 function f=eqn(coupling)
  f=coupling-(x(1)^2+x(2)+x(3)-0.2*v01); % get y1 given y2
  
 end
end
