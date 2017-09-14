function [ action_idx ] = ...
    rl_selectaction(Q, n_actions, state_idx, epsilon)
% SelectAction selects an action to pursue from the given discrete action
% space based on the e-greedy method
%
% Developed by Mario Coppola, February 2015
% E-mail: mariocoppola.92@gmail.com

t = rand();

if t < epsilon  % Selects a random action
    action_idx = randi(n_actions);
    
else % Greedy policy selects the action that maximizes Q
    [~, action_idx] = max(Q(state_idx,:));
end

end

