function [Q, rl, reward, n_steps ] = rl_episode (rl, state_global, Q )
% Episode: Perform one episode/trial of the task
Z = zeros(size(Q));
n_steps = 0;
state_global_n = state_global;
alpha_temp = rl.param.alpha;

% coefficients = 5;
% d_des   = [ 1 1 1 1 sqrt(2) sqrt(2) sqrt(2) sqrt(2)];
% phi_des = [ 0 0 0 0 3*pi/4 3*pi/4 -3*pi/4 -3*pi/4];
% [ ~, a_des, b_des ] = shapecoefficients( d_des,  phi_des , coefficients);

stop_flag = 0;
while stop_flag == 0
    n_steps = n_steps + 1;
    
    state_local = globalstate_to_observation (rl, state_global);
    selected_agent = select_moving_agent(state_local);
    action_idx = rl_selectaction (Q, state_local(selected_agent), rl.param.epsilon );
    state_global_n(selected_agent,:) = rl.model (state_global(selected_agent,:), action_idx);
    state_local_n = globalstate_to_observation(rl, state_global_n);
    
%     reward = 100/(5*(1+1*shapefitness_grid( state_global, a_des, b_des))) - ...
%     100/(5*(1+1*shapefitness_grid( state_global_n, a_des, b_des)));

    [happy] = local_evaluation(rl,state_local_n);
    
    reward = -1;
    if all(happy)
        stop_flag = 1;
        reward = 1000/n_steps;
    end
    
    action_idx_learn = rl_selectaction ( Q, state_local_n(selected_agent), 0);
    if ~isempty(action_idx_learn)
        [ Q, Z ] = rl_updatepolicy ( Q, Z, reward, state_local(selected_agent), action_idx, ...
            state_local_n(selected_agent), action_idx_learn, rl.param );
        Z = rl.param.gamma * rl.param.lambda * Z;
    end
    rl.param.alpha = 1/(n_steps+1);

%     plot_formation(rl, state_global_n, a_des, b_des);
    state_global = state_global_n;
    
end

rl.param.alpha   = alpha_temp;
rl.param.epsilon = rl.param.epsilon * rl.param.egreedy;

end
