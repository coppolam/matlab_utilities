function [ rewardlimits] = FailureAndSuccessRewards(rewardmesh, top, bottom)
% FailureAndSuccessRewards determines failure and success rewards

% Instead of a defining a list of failures and successes, it is best to
% categorized by determining all the states where the total reward is
% so low that we consider it a failure or a success.
% Then all we have to define is a failure threshhold and extract the states
% that bring to that failure

% Developed by Mario Coppola, February 2015
% E-mail: mariocoppola.92@gmail.com

if nargin < 3
    error('Please specify a minimum and maximum threshold!')
end

n = 0.01; % percent intervals
parts = 1/n*100;
top_threshold    = top/n; % [percent] MUST BE INTEGER!
bottom_threshold = bottom/n; % [percent] MUST BE INTEGER!

top_threshold = round(top_threshold);
bottom_threshold = round(bottom_threshold);

top_limit = parts-top_threshold; 
bottom_limit = bottom_threshold;

% Find minimum for calibration of failures
[minimumreward, ~] = min(rewardmesh(:)); % use this for tuning
[maximumreward, ~] = max(rewardmesh(:)); % use this for tuning

% Divide the rewardspace in "completion parts"
rew = linspace(minimumreward,maximumreward,parts);
rewardlimits = [rew(bottom_limit) rew(top_limit)];


end

