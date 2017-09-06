function [ selectedaction , ia] = ...
    SelectAction_Parametric(theta, actionspace, actionsize, bf, epsilon)
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
    selectedaction = actionspace(randperm(actionsize, size(actionspace,2)));
    ia = ismember(actionspace, selectedaction, 'rows');  
else % Greedy policy selects the action that maximizes Q
    Qn = bf' * theta;
    % Finds the max of Q and its position - Q is viewed as a 1D array
    [ ~ , ia ] = max(Qn(:));
    
    selectedaction = actionspace( ia , : );
end

end

