function [Q, rl, reward, n_steps ] = rl_episode (rl, state_global, Q )
% Episode: Perform one episode/trial of the task
global L;
global Qfull;

n_steps = 0;
Z = zeros(size(Q));
state_global_n = state_global;
reward = 0;
alpha_temp = rl.param.alpha;
stop_flag = 0;
state_start = state_global;

coefficients = 5;
d_des   = [ 1 1 1 1 sqrt(2) sqrt(2) sqrt(2) sqrt(2)];
phi_des = [ 0 0 0 0 3*pi/4 3*pi/4 -3*pi/4 -3*pi/4];
[ ~, a_des, b_des ] = shapecoefficients( d_des,  phi_des , coefficients);

while stop_flag == 0 %&& n_steps < 100
    n_steps = n_steps + 1;
    happy = zeros(size(state_global,1),1);
    state_idx_local = model_local ( state_global );
    
    for i = 1:rl.param.n_agents
        reward_local = rl.reward( 0, state_idx_local(i), 0, L );
        happy(i) = flag_global ( reward_local );
    end
    
    [r,~] = find(Qfull(state_idx_local,:) ~= 0);
    agents_that_can_move = unique(r);
    agents_that_can_move(happy(agents_that_can_move)>0) = [];
    movagent = rand_from_vector(agents_that_can_move,1);
    
    action_idx = rl_selectaction ( Q, state_idx_local(movagent), rl.param.epsilon );
    state_global_n(movagent,:) =  model_global( state_global(movagent,:) , action_idx);
    state_idx_local_n = model_local ( state_global_n );

    reward = 100/(5*(1+1*shapefitness_grid( state_global, a_des, b_des))) - ...
    100/(5*(1+1*shapefitness_grid( state_global_n, a_des, b_des)));
    %reward = reward/n_steps;
    
    for i = 1:rl.param.n_agents
        reward_local = rl.reward( 0, state_idx_local_n(i), 0, L );
        happy(i) = flag_global ( reward_local );
    end
    
    if all(happy)
        stop_flag = 1;
        reward = 1000;
    end
    
    action_idx_learn = rl_selectaction ( Q, state_idx_local_n(movagent), 0);
    if ~isempty(action_idx_learn)
        [ Q, Z ] = rl_updatepolicy ( Q, Z, reward, state_idx_local(movagent), action_idx, ...
            state_idx_local_n(movagent), action_idx_learn, rl.param );
        Z = rl.param.gamma * rl.param.lambda * Z;
    end
%     rl.param.alpha = 1/(n_steps+1);

%     plot_formation(rl, state_start,state_global_n, a_des, b_des);
    state_global = state_global_n;
    
end

rl.param.alpha   = alpha_temp;
rl.param.epsilon = rl.param.epsilon * rl.param.egreedy;

end
