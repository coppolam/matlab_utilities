function [ data ] = adjusttime( data , members , trial, tol, timefieldname)
% adjusttime Adjusts the time vectors of different data recorded from
% different MAVs over a trial run for analysis.
%
% The function works for all fields that are of the MAV itself (e.g. ground-truth) or of one
% with respect to the other (e.g. relative measurements). It gives
% preference to the time vector of the first robot
% 
% General use:
% data_structure = adjusttime( data_structure , members , trial, tol, timefieldname)
%
% Default values:
% Default trial = 1
% Default tolerance 'tol' = 0.01 (Assumption that the rate of logging is > 100 Hz)
% Default timefieldname = 'time'
%
%
% Mario Coppola, May 2016

ml = 1:members;

if (members < 2)
%    warning('Adjusting time... but there is no point since you only have 1 member. Function is quitting.');
    return
end

if nargin < 3
    trial = 1;
end

if nargin < 4
    tol = 0.01;
end

if nargin < 5
    timefieldname = 'time';
end

% Make sure the time vectors are good to go
for i = 1:members
    ol = ml;
    ol(i) = [];
    
    del   = (diff(data{i,i,trial}.time)<tol);
    if round(sum(del),5) > 0
        fname = fieldnames(data{i,i,trial});
        for ff = 1:length(fname)
            data{i,i,trial}.(fname{ff})(del,:) = [];
        end

        for jj = 1:length(ol)
            j = ol(jj);
            fname = fieldnames(data{i,j,trial});
            for ff = 1:length(fname)
                data{i,j,trial}.(fname{ff})(del,:) = [];
            end
        end

    end
end

% Now interpolate if need be (members > 1)
for i = 1:members
    ol = ml;
    ol(i) = [];
    
    for jj = 1:length(ol)
        j = ol(jj);
        % Construct the reference (perfect) output of the EKF
        if (j > 1) % Do not interpolate itself
            fname = fieldnames(data{j,i,trial});
            for ff = 1:length(fname)
                data{j,i,trial}.(fname{ff}) = interp1(data{j,j,trial}.time, data{j,i,trial}.(fname{ff}), data{1,1,trial}.time,'linear','extrap');
            end
        end
    end
    
    if (i > 1) % Do not interpolate itself
        fname = fieldnames(data{i,i,trial});
        for ff = 1:length(fname)
            if ~strcmp(fname{ff},timefieldname)
                data{i,i,trial}.(fname{ff}) = interp1(data{i,i,trial}.time, data{i,i,trial}.(fname{ff}), data{1,1,trial}.time,'linear','extrap');
            end
        end
    end
    
end

end