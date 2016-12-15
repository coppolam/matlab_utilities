function [ out ] = rangen( min, max , row, col )
%rangen Generates a random matrix of size row*col from a uniform distribution 
% within the specified limits. The distribution is uniform! You can just check this by
% running: hist(rangen(-4,4,100000))
%
%   Inputs: min, max, row, col
%   Output: The random number
%
% Based on example from
% mathworks.com/help/matlab/math/floating-point-numbers-within-specific-range.html
%
% Developed by Mario Coppola, February 2015

if nargin < 2
    error('Please specify a minimum and a maximum')
end

if nargin < 3
    %warning('Precision not specified, using 1000 as standard')
    row = 1; col = 1; 
end

out = (max-min).*rand(row,col) + min;

end