function [Q, rl, reward, n_steps, state_action_history ] = rl_episode (rl, state_global, Q, varargin)
% Episode: Perform one episode/trial of the task

visualize = checkifparameterpresent(varargin,'visualize',0,'array');
verbose   = checkifparameterpresent(varargin,'verbose',0,'array');
learn     = checkifparameterpresent(varargin,'learn',1,'array');
record    = checkifparameterpresent(varargin,'record',0,'array');
maxsteps  = checkifparameterpresent(varargin,'maxsteps',Inf,'array');
find_deadlocks  = checkifparameterpresent(varargin,'find_deadlocks',0,'array');

if learn
    Z = zeros(size(Q));
    alpha_temp = rl.param.alpha;
end

n_steps = 0;
state_global_n = state_global;
selected_agent_last_step = 0;
stop_flag = 0;

if record || find_deadlocks || nargout > 4
    selected_agent_state_history  = [];
    selected_agent_action_history = [];
    local_state_store             = [];
end

while stop_flag == 0 && n_steps < maxsteps
    
    n_steps = n_steps + 1;
    
    state_local = globalstate_to_observation (rl, state_global);
    [selected_agent, agents_that_can_move] = select_moving_agent(state_local, selected_agent_last_step);
    
    if isempty(agents_that_can_move)
        reward = -100;
        stop_flag = 1;
        break;
    end
    
%     for i = 1:numel(agents_that_can_move)
        action_idx = rl_selectaction (Q, state_local(selected_agent), rl.param.epsilon );
        state_global_n(selected_agent,:) = rl.model (state_global(selected_agent,:), action_idx);
%     end
    
    if  size(unique(state_global_n, 'rows', 'first'),1) < size(state_global_n,1)
        reward = -100;
        flag = -1;
        break;
    end

    state_local_n = globalstate_to_observation(rl, state_global_n)
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

    
    state_global = state_global_n;
    
    if record || find_deadlocks || nargout > 4
        selected_agent_state_history  = [selected_agent_state_history,  state_local(selected_agent)];
        selected_agent_action_history = [selected_agent_action_history, action_idx];
        
        if find_deadlocks
            % Shape is repeated
            local_state_store = [local_state_store; state_local'];
            for i = 1:size(local_state_store,1)
                if isequal(local_state_store(i,:),state_local_n')
                    reward = -100;
                end
            end
            
            if selected_agent_last_step == selected_agent && ...
                    local_state_store(end,selected_agent) == state_local_n(selected_agent)
                reward = -100;
            end
            
            if reward < -99
                stop_flag = 1;
            end
        end
    end
    
    selected_agent_last_step = selected_agent;
    

end

if record || nargout > 3
    state_action_history = [selected_agent_state_history; selected_agent_action_history]';
end

if verbose
    disp(['    Episode ended with ',num2str(n_steps), ...
        ' steps and exit reward = ',num2str(reward)])
    
    if reward > 0
        disp('Hurray')
    end
end

if learn
    rl.param.alpha = alpha_temp;
end

end
