function Q = rl_episode (state_update_func, state_reward_func, ...
                            state_idx, Q, param, n_actions)
% Episode: Perform one episode/trial of the task

Z    = zeros(size(Q));  % Eligibility traces matrix. Reset every episode.
flag = 0;               % Null Assumption (1 = success, -1 = failure)

while abs(flag)~=1
    
    action_idx   = rl_selectaction   ( Q, n_actions, state_idx, param.epsilon );
    state_idx_n  = state_update_func ( state_idx, action_idx );
    reward       = state_reward_func ( state_idx, action_idx ); %% todo_add flag
    action_idx_learn = rl_selectaction   ( Q, n_actions, state_idx, param.epsilon );

    [ Q, Z ]         = rl_updatepolicy   ( Q , Z, reward, state_idx, action_idx, ...
                                            state_idx_n, action_idx_learn, param );
    
    state_idx = state_idx_n;
    
end