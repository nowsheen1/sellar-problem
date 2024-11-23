
function f = obj(x)
 y1=  x(1)^2+x(2)+x(3)-0.2*x(8);
 f=(x(1)-x(4))^2+(x(2)-x(5))^2+(x(3)-x(6))^2+((y1-x(7))^2); % x1s is x4 x2s is x5, x3s is x6, y1s is x7, y2s is x8.
 
end