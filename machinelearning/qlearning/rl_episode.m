function [Q, reward, flag] = rl_episode (state_update_func, state_reward_func,... 
                            reward_succesfailure_func,...
                            state_idx, Q, param, n_actions)
% Episode: Perform one episode/trial of the task

Z      = zeros(size(Q));
step   = 1;
reward = 0;
flag   = 0;

action_idx = rl_selectaction ( Q, n_actions, state_idx, param.epsilon );

while flag == 0
    
    state_idx_n = state_update_func ( state_idx, action_idx );
    reward      = state_reward_func ( reward, state_idx, step );
    flag        = reward_succesfailure_func ( reward );
    
    action_idx_learn = rl_selectaction ( Q, n_actions, state_idx_n, param.epsilon );
    [ Q, Z ] = rl_updatepolicy ( Q, Z, reward, state_idx, action_idx, ...
                                   state_idx_n, action_idx_learn, param );
     
    state_idx  = state_idx_n;
    action_idx = action_idx_learn;
    
    step = step + 1;
    
end