function Q = rl_episode(state_update_func, Q, state_idx, param, statespace, actionspace)
% Episode: Perform one episode/trial of the task

Z    = zeros(size(Q));  % Eligibility traces matrix. Reset every episode.
flag = 0; % Null assumption

% The loop runs as long as the situation is neither failure nor success
while abs(flag)~=1
    
    action_idx     = rl_selectaction   ( Q, n_actions, state_idx, param.epsilon );
    
    state_idx_n    = state_update_func ( state_idx, action_idx, statespace, actionspace );
    
    [reward, flag] = state_reward_func ( );
    
    action_idx_learn = rl_selectaction ( Q, n_actions, state_idx, param.epsilon );

    [ Q, Z ]       = rl_updatepolicy   ( Q , Z, reward, state_idx, state_index_learn, ...
                                            action_idx, action_idx_learn, param );
    
    state_idx = state_idx_n;
    
end

