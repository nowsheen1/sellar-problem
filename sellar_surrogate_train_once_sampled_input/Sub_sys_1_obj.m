  function [y] = Sub_sys_1_obj(x,y1s,y2s)
        if ~isequal(x,xLast) % Check if computation is necessary
            [myf] = computePerformance1(x,y1s,y2s);
            xLast = x;
        end
        % Now compute objective function
        y = myf;
      
    end

  