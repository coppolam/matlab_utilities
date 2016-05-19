function [ setmatnorm ] = NormalizeSet( setmat )
%NormalizeSet Normalizes the functions of a fuzzy set such that everything
%always adds up to 1.

t = size(setmat);
nparts = t(2);
settot = sum(setmat,2);
setmatnorm = setmat./repmat(settot,[1 nparts]);
setmatnorm(isnan(setmatnorm)) = 0;

end

