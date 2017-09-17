function [ Q, n_episodes ] = rl_learn( rl, n_states, n_actions, varargin )
% Function to run a reinforcement learning algorithm
%
% Developed by Mario Coppola, February 2015
% E-mail: mariocoppola.92@gmail.com

n_episodes  = 1;
goodcount   = 0;

Q           = checkifparameterpresent(varargin,'Q',...
                    zeros(n_states,n_actions),'array');
state_idx_0 = checkifparameterpresent(varargin,'initialstate',...
                    randi(n_states),'array');

while 1
    
    Qold = Q;
    Q    = rl_episode(rl.model, rl.reward, state_idx_0, Q, rl.param, n_actions);
   
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