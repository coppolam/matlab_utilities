function [ Q, n_episodes ] = rl_learn( rl, n_states, n_actions, varargin )
% Function to run a reinforcement learning algorithm
%
% Developed by Mario Coppola, February 2015
% E-mail: mariocoppola.92@gmail.com

n_episodes  = 1;
goodcount   = 0;

Q           = checkifparameterpresent(varargin,'Q',...
                     0*ones(n_states,n_actions),'array');
state_idx_0 = checkifparameterpresent(varargin,'initialstate',...
                    [],'array');
           
reward_store = [];

while goodcount < 100 && n_episodes < 5000
    
    [ state_idx ] = rl_starting_state( state_idx_0, n_states );
    
    Qold = Q;
    [Q, reward, flag] = rl_episode(rl.model, rl.reward, rl.flag, state_idx, Q, rl.param, n_actions);
   
    % Based on book by Bobuska (Ch.3, P.68)
    % Looking for a case where the maximum change in theta is small
    % We look for 10 consecutive times just to avoid falling for anomalies
    adiff = max(abs(Qold-Q));
    if (max(adiff) < 0.001)
        goodcount = goodcount + 1;
    else
        goodcount = 0;
    end
    
    % The e-greedy policy reduces the exploration parameter at each new iteration
    rl.param.epsilon = rl.param.epsilon * rl.param.egreedy;    
    reward_store = [reward_store, reward];
    n_episodes = n_episodes + 1;
    

    plot(1:n_episodes-1,reward_store)
    drawnow
end

end