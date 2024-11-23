%% PREPARATION
function [z]=smbo_2() 
rng(100);

% User parameter
export_plot = false;        % Export plot file
visualization_on = true;    % Set to true to turn on visualization 

% Surrogate model-based optimization options
maxiter = 90;               % Maximum number of iterations allowed
n_smp = 50;                  % Number of samples for each iteration
m.sampling = 'LHS';         % Sampling method: LHS, FF, Random, User
m.surrogate = 'TPS-RBF';    % Surrogate modeling method: TPS-RBF, User
opt = optimoptions('ga');   % Genetic algorithm is used for minimization
opt.Display = 'none';       % No display after GA run
opt.UseVectorized = true;   % Vectorized evaluation on the surrogate model

% Gradient-based optimization options (for comparison)
optfmincon = optimoptions('fmincon');
optfmincon.Display = 'none';
optfmincon.FiniteDifferenceType = 'central';
optfmincon.OptimalityTolerance = 1e-9;
optfmincon.StepTolerance = 1e-9;

% Save current (parent) directory and problem (sub) directory paths
%currentpath = pwd;
%probpath = fullfile(currentpath,prob);

% Get obj-fn handle from the problem path
%cd(probpath);               % Enter the problem directory
%objfn = str2func('obj');    % Obtain function handle for objective function
conffn = str2func('conf');  % Obtain function handle for configurations
%cd(currentpath);            % Return to the root directory

% Problem configurations (number of variables, lower & upper bounds)
pc = feval(conffn);

% Assumption of solution (initial value) for sample distribution
xrange = (pc.ub - pc.lb)/2; % Half of the design space for each dimension
                            % These bounds are for specifying the design
                            % and modeling domain.
x0 = pc.lb + xrange;        % Midpoint between lower and upper bounds
xopt = x0;                  % First guess is equivalent to the init value

% Retrieve true solution for comparison
%xtrue = pc.xtrue;           % True solution x (design var)
%ftrue = pc.ftrue;           % True solution f(x) (objective function var)

objfn = @(xopt)obj2(xopt);
confn1 = @(xopt)con2(xopt);

%% SURROGATE MODELING-BASED OPTIMIZATION

%if visualization_on
 %   outputfn_00;            % Command window output for printing header
  %  plotfn_00;              % Plot preparation
  %  plotfn_10;              % Plot true solution
%end
  switch(m.sampling)
        case 'LHS'          % Latin hypercube sampling
            xsmp01 = lhsdesign(n_smp, pc.nvar);
        case 'FF'           % Full factorial sampling
            xsmp01 = (fullfact(round(sqrt(n_smp))*ones(1,pc.nvar)) ...
                - 1)/(round(sqrt(n_smp)) - 1);
        case 'Random'       % Random sampling
            xsmp01 = rand(n_smp, pc.nvar);
        case 'User'         % User-defined sampling method
            % Please write your own sampling method here:
            % xsmp01 = ...
    end

% Adaptive surrogate model refinement loop
k = 1;                      % Iteration number
while (k <= maxiter)
    % ==== DESIGN SPACE SAMPLING ====
    % Generate samples in the range [0,1] (scaled space)
  
    
    % Scale sample points to original design space range
    xs_g = 2*(xsmp01 - 0.5);    % Scale samples from [0,1] to [-1,1]
    xs_g = repmat(xopt,n_smp,1) + xs_g.*repmat(xrange,n_smp,1);
                                % Scale from [-1,1] to [lb,ub]
    % Ensure that samples lie within bounds
    for i = 1:pc.nvar       % Loop over each design variable
        xsampcol = xs_g(:,i);
        xsampcol(xsampcol>pc.ub(i)) = pc.ub(i); % Upper bound enforcement
        xsampcol(xsampcol<pc.lb(i)) = pc.lb(i); % Lower bound enforcement
        xs_g(:,i) = xsampcol; clear xsampcol;
    end
    % Save samples
    x_sample{k} = xs_g; 
    
    % ==== HIGH FIDELITY MODEL EVALUATION ====
    % Execute original objective function calculation for each sample point
    f_hf{k} = zeros(n_smp,1);
    for i = 1:n_smp     % If objfn is computationally expensive, this is 
                        % the most computationally intensive step.
        f_hf{k}(i) = feval(objfn,x_sample{k}(i,:));
    end
    
    % ==== SURROGATE MODELING-BASED OPTIMIZATION ====
    % Compile design points (past and current samples) along with high
    % fidelity function results:
    xs_g = x_sample{1};     % For first iteration, we only have sample pts
    fsmp = f_hf{1};         % and its high fidelity function results
    store{1}=x_sample{1};
    if (k>1)
        for i = 2:k
            xs_g = [xs_g; x_sample{i}; xopt_history{i-1}];
            store{i}= xs_g;
            fsmp = [fsmp; f_hf{i}; f_hf_opt_history{i-1}];

        end
    end
     %%constraint surrogate
      f_hf_con1{k} = zeros(n_smp,1); %  for one iteration the size of f is 30*1
    for i = 1:n_smp     % If objfn is computationally expensive, this is 
                        % the most computationally intensive step.
        f_hf_con1{k}(i) = feval(confn1,x_sample{k}(i,:));
    end
    
    % ==== SURROGATE MODELING-BASED OPTIMIZATION ====
    % Compile design points (past and current samples) along with high
    % fidelity function results:
    xs_g_con1 = x_sample{1};     % For first iteration, we only have sample pts
    fsmp_con1 = f_hf_con1{1};         % and its high fidelity function results
    if (k>1)
        for i = 2:k
            xs_g_con1 = [xs_g_con1; x_sample{i}; xopt_history{i-1}];
            fsmp_con1 = [fsmp_con1; f_hf_con1{i}; f_hf_opt_con1_history{i-1}];
        end
    end
    %%
         % Surrogate model construction and optimization run
    switch(m.surrogate)
        case 'TPS-RBF'      % Radial-Basis Function (Thin-Plate Spline)
            % Construct an RBF model using thin plate spline function
            [weight,center] = tps_rbf_construct(xs_g,fsmp);
            [weight1,center1] = tps_rbf_construct( xs_g_con1, fsmp_con1);
           
            % Run GA-based optimization using the surrogate model
            [xopt,fopt] = ga(@(x)tps_rbf_objfn(x,weight,center),pc.nvar,...
                [],[],[],[],pc.lb,pc.ub,@(x)tps_rbf_confn(x,weight1,center1),opt);
        case 'User'         % User-defined surrogate modeling method
            % Please write your own surrogate modeling-based optimization
            % method here:
            % [xopt,fopt] = ...
    end
    
    % Evaluate the high fidelity function to evaluate error at the
    % predicted optimum (model validation, only at solution):
     f_hf_opt = objfn(xopt);
    f_hf_opt_con1 = confn1(xopt);
       
    % Save the high fidelity function result at the predicted optimum
    xopt_history{k} = xopt;
    optimal{k}=xopt;
    f_hf_opt_history{k} = f_hf_opt;
    f_hf_opt_con1_history{k} = f_hf_opt_con1;
     %  if visualization_on
   %     outputfn_10;        % Command window output per each iteration
    %    plotfn_20;          % Plot per each iteration
     %   plotfn_exp10;       % Export plot
    %end
    save('store_surrogate_data.mat', 'store', '-v7.3');
    save('store_optimal_data.mat', 'optimal', '-v7.3');


    % Calculations for next iteration
    xrange = pc.fs_g * xrange;  % Reduce sampling range with a factor < 1
    k = k + 1;                  % Increment iteration number
end


reconfiguredCell = [];
opt_sol_con=[];

% Loop through the first three cells in 'store'
for i = 1:maxiter
    % Concatenate columns 3 to 6 from each cell vertically
    x_table=store{i};
    x_table_input=x_table(:,4:8);

    no_row=size(x_table_input,1);
    opt_sol=repmat(optimal{i},no_row,1);

    reconfiguredCell = [reconfiguredCell; store{i}(:, 4:8)];
    opt_sol_con=[opt_sol_con;opt_sol];

end
model_frst_optimal_soln_sub2=fitrgp(reconfiguredCell, opt_sol_con(:,1));
model_second_optimal_soln_sub2=fitrgp(reconfiguredCell, opt_sol_con(:,2));
model_third_optimal_soln_sub2=fitrgp(reconfiguredCell, opt_sol_con(:,3));
save('gprModel_sub21.mat', 'model_frst_optimal_soln_sub2');
save('gprModel_sub22.mat', 'model_second_optimal_soln_sub2');
save('gprModel_sub23.mat', 'model_third_optimal_soln_sub2');
z=[xopt,fopt];
end

