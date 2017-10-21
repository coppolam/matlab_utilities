function [ reward ] = reward_gridmaze( reward_prev, state_idx, n_steps )

statespace = setprod(-5:1:5, -5:1:5);
state      = statespace(state_idx, :);
reward     = sqrt(25+25)/(1+sqrt(state(1)^2+state(2)^2));

end

