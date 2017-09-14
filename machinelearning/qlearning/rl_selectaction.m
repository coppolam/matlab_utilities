function [ action_idx ] = ...
    rl_selectaction(Q, n_actions, state_idx, epsilon)
% SelectAction selects an action to pursue from the given discrete action
% space based on the e-greedy method
% 
% It operates on two modes:
% 'e_greedy' : implementation of the e-greedy policy, which can either
% select a random action or follow the greedy policy.
% 'greedy'   : always picks a greedy action
% 
% INPUTS  : method, theta, actionspace, actionsize, bf, epsilon
% 
% OUTPUTS : selectedaction (array with real values), ia (index of actions
% in sactionspace)
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

