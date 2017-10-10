function [ state_idx ] = rl_starting_state( state_idx_0, n_states, n_agents )

if n_agents > 1
    state_idx = randperm(length(state_idx_0),n_agents);
    return
end

if state_idx_0 == 1
    state_idx = randi(n_states);
elseif length(state_idx_0) > 1
    state_idx = state_idx_0(randi( [1 length(state_idx_0)] ) );
else
    state_idx = state_idx_0;
end

end