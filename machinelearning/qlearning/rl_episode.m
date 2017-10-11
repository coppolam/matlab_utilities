function [Q, rl, reward, n_steps ] = rl_episode (rl, state_global, Q, varargin)
% Episode: Perform one episode/trial of the task

visualize = checkifparameterpresent(varargin,'visualize',0,'array');
verbose   = checkifparameterpresent(varargin,'verbose',0,'array');
learn     = checkifparameterpresent(varargin,'learn',1,'array');

selected_agent_last_step = 0;
if learn
Z = zeros(size(Q));
end
n_steps = 0;
state_global_n = state_global;
alpha_temp = rl.param.alpha;
state_local_last = zeros(size(state_global));

stop_flag = 0;
while stop_flag == 0 && n_steps < 100
    n_steps = n_steps + 1;
    
    state_local = globalstate_to_observation (rl, state_global);
    selected_agent = select_moving_agent(state_local, selected_agent_last_step);
    action_idx = rl_selectaction (Q, state_local(selected_agent), rl.param.epsilon );
    state_global_n(selected_agent,:) = rl.model (state_global(selected_agent,:), action_idx);
    state_local_n = globalstate_to_observation(rl, state_global_n);
    
    happy = local_evaluation(rl,state_local_n);
    reward = -1;
    
    if all(happy)
        stop_flag = 1;
        reward = 1000/n_steps;
    end
        
    if learn
        action_idx_learn = rl_selectaction ( Q, state_local_n(selected_agent), 0);
        [ Q, Z ] = rl_updatepolicy ( Q, Z, reward, state_local(selected_agent), action_idx, ...
            state_local_n(selected_agent), action_idx_learn, rl.param );
        Z = rl.param.gamma * rl.param.lambda * Z;
        rl.param.alpha = 1/(n_steps+1);
    end
    
    if visualize
        plot_formation(state_global_n);
    end
    
    state_local_last(selected_agent) = state_local_n(selected_agent);
    action_idx_last(selected_agent) = action_idx;
    state_global = state_global_n;
    selected_agent_last_step = selected_agent;
end

if verbose
    disp(['     Episode ended with ',num2str(n_steps),' steps and exit reward ',num2str(reward)])
end
rl.param.alpha   = alpha_temp;
rl.param.epsilon = rl.param.epsilon * rl.param.egreedy;

end
