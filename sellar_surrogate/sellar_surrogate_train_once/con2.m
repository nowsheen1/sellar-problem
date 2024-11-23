
% f = OBJ(x)
%   f: Objective Function Value
%   x: Design Variables

function f = con2(x)
y2=sqrt(x(7))+x(1)+x(3);  % x1s is x4 x2s is x5, x3s is x6, y1s is x7, y2s is x8.
f=y2-24; 
end