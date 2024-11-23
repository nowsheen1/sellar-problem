function [c,ceq] = constraints_Sys_new(x)
        if ~isequal(x,xLast) % Check if computation is necessary
            [myf,myc,myceq] = computePerformance(x);
            xLast = x;
        end
        % Now compute constraint function
        c = myc; % In this case, the computation is trivial
        ceq = myceq;
    end
