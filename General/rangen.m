function [ out ] = rangen( min, max , precision)
%rangen Generates a random number from a uniform distribution within the specified
%limits and with the specified precision (standard is 1000 elements within the
%interval)
%   Inputs: [min max precision]
%   Output: The random number
%
% Based on example from
% mathworks.com/help/matlab/math/floating-point-numbers-within-specific-range.html
% mathworks.com/help/matlab/math/floating-point-numbers-within-specific-range.html
%
% Developed by Mario Coppola, February 2015

if nargin < 2
    error('Please specify a minimum and a maximum')
end

if nargin < 3
    %warning('Precision not specified, using 1000 as standard')
    precision = 1000;
end

out = (max-min).*rand(precision,1) + min;

end