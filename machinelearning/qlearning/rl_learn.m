function [ Q, episode ] = rl_learn(func, statespace, actionspace, param )
% Function to run a reinforcement learning algorithm
%
% Developed by Mario Coppola, February 2015
% E-mail: mariocoppola.92@gmail.com

nstates  = size(statespace,1);
nactions = size(actionspace,1);
episode   = 1;
goodcount = 0;

Q  = checkifparameterpresent(varargin,'learnmode',zeros(nstates,nactions),'array');
s0 = checkifparameterpresent(varargin,'initialstate',[],'array');

while 1
    
    if isempty(s0)
        s0 = rand(1:255);
    end
    
    Qold = Q;
    
    Q = Episode_Learn(func, s0, Q, param,  Ts);
   
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
    param.epsilon = param.epsilon * param.egreedy;    
    episode = episode + 1;
end

end

