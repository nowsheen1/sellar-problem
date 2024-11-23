
% f = OBJ(x)
%   f: Objective Function Value
%   x: Design Variables

function f = con1(x)
y1=  x(1)^2+x(2)+x(3)-0.2*x(8);
f=3.16-y1;


end