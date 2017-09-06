function [ states ] = FailureSuccessStates(modecurr, rewardmesh, rewardlimits, varargin )
% FailureSuccessStates Identifies the category of a state based on its
% value within the rewardlimits (failure, middle, success)

% Developed by Mario Coppola, February 2015
% E-mail: mariocoppola.92@gmail.com

if strcmp(modecurr,'failure')
    ind = find(rewardmesh < rewardlimits(1));
elseif strcmp(modecurr,'success')
    ind = find(rewardmesh > rewardlimits(2));
elseif strcmp(modecurr,'middle')
    ind = find(rewardmesh >= rewardlimits(1) &...
                rewardmesh <= rewardlimits(2));
else
    error('Please specify a valid mode (failure or success)');
end

[i,j,k,l,m,n,o] = ind2sub(size(rewardmesh),ind);

statesindex = [i,j,k,l,m,n,o];
statesindex = statesindex(:,1:ndims(rewardmesh));

states = ones(size(statesindex));
pos = 1;

for i = 1:nargin-3
    statespace = varargin{i};
    endpos = pos+size(statespace,2)-1;
    states(:,pos:endpos) = statespace(statesindex(:,pos:endpos));
    pos = endpos + 1;
end

end

