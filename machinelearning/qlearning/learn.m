function [ Q, episode ] = rl_learn( param )
% Function to run a reinforcement learning algorithm
%
% Developed by Mario Coppola, February 2015
% E-mail: mariocoppola.92@gmail.com

% Learning or Improving?
% With learning we start from 0 (default)
% with improving we build on old Theta matrices

verbose   = checkifparameterpresent(varargin,'verbose','Off','string');
learnmode = checkifparameterpresent(varargin,'learnmode','learn','string');
s0        = checkifparameterpresent(varargin,'InitialState',-1,'number');

if strcmp(learnmode, 'learn') || (~exist('theta','var'))
    disp('Learning...')
    % Re-initialize theta
    Q = zeros(length(statespace),length(aspace)); 
    
elseif strcmp(learnmode, 'improve') && (exist('theta','var'))
    disp('Improving...')

else error('Specify a valid learning mode')

end

% Initiating some variables
episode             = 1;
successesininterval = 0;
totalsuccesses      = 0;
sprofstore          = 0;
aprofstore          = 0;
goodcount           = 0;
a                   = 0;
st                  = zeros(5000,1);
R                   = zeros(5000,1);
r_out               = 0;



Ts             = 0.2;  % Discretization time-step, this is sufficient for action selection

% Continue trying forever until the break function runs when converged
while 1
    
    thetaold = Q;
    
    % Run one episode
    Q = Episode_Learn(modelmode, initialmeasure, ...
        Q, param, ...
        rewardlimits, ...
        aspace, asize, ...
        statespace,...
        Ts);
    
    thetanew = Q;
    adiff = max(abs(thetaold-thetanew));
           
    % Based on book by Bobuska (Ch.3, P.68)
    % Looking for a case where the maximum change in theta is small
    % We look for 10 consecutive times just to avoid falling for anomalies
    if max(adiff) < 0.01
        goodcount = goodcount + 1;
        if goodcount > 10
            break % A sub-optimal solution has been reached!
        end    
    else goodcount = 0; % Restart counter
    
    end
    
    param.epsilon = param.epsilon * param.egreedy;
    episode = episode + 1;
    
end


disp(' ');
disp(['Done, episode #', num2str(episode)]);

end

