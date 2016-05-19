function [yesttot,setmatnorm] = singestimate(y,setmat)
% Estimates the function results according to the Singleton model:
%   if x is A(i) then y(i) = b(i)
%
% Deveoped by Mario Coppola, Apr 2014

t = size(setmat);
nparts = t(2);

% Normalize the set
settot = sum(setmat,2);
setmatnorm = setmat./repmat(settot,[1 nparts]);
setmatnorm(isnan(setmatnorm)) = 0;

% Singleton estimate
best = setmatnorm\y;

yesttot = setmatnorm*best;