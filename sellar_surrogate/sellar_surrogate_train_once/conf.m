
% pc = CONF()
%   pc: Structured Data Containing Problem Configurations

function pc = conf()


    pc.nvar = 8;                % Number of variables
    pc.lb = [0,0,0,0,0,0,0,0];           % Lower bounds
    pc.ub = [10,10,10,10,10,10,10,10];             % Upper bounds
    pc.fs_g = 0.6;             % Shrink factor for global sample range
    %pc.xtrue = [0];           % True soltuion in x (for comparison)
    %pc.ftrue = 0;               % True solution in f (for comparison)
end