function [ Q, n_episodes ] = rl_learn( rl, statespace, actionspace, varargin )
% Function to run a reinforcement learning algorithm
%
% Developed by Mario Coppola, February 2015
% E-mail: mariocoppola.92@gmail.com

n_states   = size(statespace,1);
n_actions  = size(actionspace,1);
n_episodes = 1;
goodcount  = 0;

Q  = checkifparameterpresent(varargin,'learnmode',zeros(n_states,n_actions),'array');
s0 = checkifparameterpresent(varargin,'initialstate',[],'array');

% Run Reinforcement learning episode
while 1
    % Random jnitial state
    if isempty(s0)
        s0 = rand(1:255);
    end
    
    Qold = Q;
    Q = rl_episode(rl.model, s0, Q, rl.param, actionspace);
   
    % Based on book by Bobuska (Ch.3, P.68)
    % Looking for a case where the maximum change in theta is small
    % We look for 10 consecutive times just to avoid falling for anomalies
    adiff = max(abs(Qold-Q));
    if (max(adiff) < 0.01)
        goodcount = goodcount + 1;
        if goodcount > 10
            break; % A sub-optimal solution has been reached!
        end
    else
        goodcount = 0; % Restart counter
    end
    
    % The e-greedy policy reduces the exploration parameter at each new iteration
    rl.param.epsilon = rl.param.epsilon * rl.param.egreedy;    
    n_episodes = n_episodes + 1;
end

end

