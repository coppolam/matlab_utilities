function [ Q, Z ] = rl_updatepolicy ( Q , Z, reward, state_idx, action_idx, ...
                                            state_idx_n, action_idx_learn, param )
% UpdatePolicy Updates the Q-function
Q_current  = Q(state_idx,action_idx);

if isempty(action_idx_learn)
    Q_learning = 0;
else
    Q_learning = Q( state_idx_n, action_idx_learn );
end
TDdelta = reward + param.gamma .* Q_learning - Q_current;
Z(state_idx, action_idx) = Z(state_idx, action_idx) + 1;
Q = Q + param.alpha * TDdelta * Z;

if any(isnan(Q))
    warning('Q went NaN')
    keyboard
end
    
end