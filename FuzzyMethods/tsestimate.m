function [yesttot,setmatnorm] = tsestimate(x,y,setmat,type)
% Estimates the function y=f(x) results according to the Takagi-Sugeno model:
%   if x is A(i) then y(i) = a(i) x+ b(i)
% by specifing type = 's', it is possible to condition it to estimate using
% singletons.
%
% Deveoped by Mario Coppola, Apr 2014

if nargin<4
    warning('No type specified, performing standard TS estimate with ax+b')
end

if strcmp(type,'s')
    [yesttot,setmatnorm] = singestimate(y,setmat);

elseif strcmp(type,'t')
    t = size(setmat);
    nparts = t(2);
    
    % Normalize the set
    settot = sum(setmat,2);
    setmatnorm = setmat./repmat(settot,[1 nparts]);
    setmatnorm(isnan(setmatnorm)) = 0;

    % TS estimate
    
    Xe      = [x, ones(length(x),1)];
    Xdash   = zeros(length(x),nparts);
    
    for i = 1:nparts
        Xdashnext = diag(setmatnorm(:,i))*Xe;
        Xdash(:,(2*i-1):(2*i)) = Xdashnext;
    end
    
    theta = Xdash\y;
    
    av = theta(1:2:end);
    bv = theta(2:2:end);
    
    yest = setmatnorm.*(x*av'+repmat(bv',[length(x),1]));
    
    yesttot = sum(yest,2);

end

