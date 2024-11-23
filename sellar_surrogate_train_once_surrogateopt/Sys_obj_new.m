function y = Sys_obj_new(x)
        if ~isequal(x,xLast) % Check if computation is necessary
            [myf,myc,myceq] = computePerformance(x);
            xLast = x;
        end
        % Now compute objective function
        y = myf;
    end

   