function [ x ] = keepbounded(x, minmax )
%keepbounded Function to keep a value bounded between a minimum and a
%maximum value
%
% Use: [x_adjusted] = keepbounded(x_unadjusted, [min max])
%
% Mario Coppola, January 2016

ind = x < min(minmax);
x(ind) = min(minmax);

ind = x > max(minmax);
x(ind) = max(minmax);

end

