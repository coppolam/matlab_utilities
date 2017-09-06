function [ reward, flag ] = RewardFunc( s, rewardlims)
% RewardFunc extrapolates the reward at the indexed location from the
% and, if relevant, gives a success or failure flag
%
% Developed by Mario Coppola, February 2015
% E-mail: mariocoppola.92@gmail.com

reward = GetStateValue(s);

% Indicate whether we succeded or failed
if nargin > 1
    if reward > rewardlims(2)       % Success!
        flag    = 1;
    elseif reward < rewardlims(1)   % Failure!
        flag    = -1;
    else
        flag    = 0;                % Neither
    end

end

end