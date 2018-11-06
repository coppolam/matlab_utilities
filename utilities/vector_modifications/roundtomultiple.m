function x = roundtomultiple( x , m, mode)
%roundtomultiple, rounds the first number to the closest number that is a
%multiple of the second input. Both inputs should be scalar.
%
% e.g.   x_rounded = roundtomultiple(x, multiple)
%
% Vectors/Matrices are also accepted

if nargin < 3
    x = round(x./m).*m;
elseif strcmp(mode,'floor')
    x = floor(x./m).*m;
elseif strcmp(mode,'ceil')
    x = ceil(x./m).*m;
else
    error('Unknown rounding mode')
end

end

