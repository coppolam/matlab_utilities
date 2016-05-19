function [ indeces, bounds, bounds_size, vec] = ...
    SortandGroupData( vector, absmax, interval, angleconversion)
%SortandGroupData Groups data points within the specified intervals,
%basically quantizing a variable for the sake of simplicity in analysis.
%If the data features angles in radians, but you want to specify the absmax
%and the interval in degrees, then use the string "deg2rag" as the fourth
%input to this function. Similarly, if you are dealing with degrees but
%wish to specify the bounds in radians, then use the string "rad2deg".

% Generate vector of all inclinations according to sorting values above
%
% Developed by Mario Coppola, October 2015

if numel(absmax) == 2
    df = absmax(2)-absmax(1);
elseif numel(absmax) == 1
    df = absmax;
else
    error('The second argument cannot be a vector of more than 2 values')
end

[bounds, bounds_size] = GenerateDspace(absmax, df/interval);

if nargin > 3
    if strcmp(angleconversion,'deg2rad')
        bounds = deg2rad(bounds); % Convert to degrees
    elseif strcmp(angleconversion,'rad2deg')
        bounds = rad2deg(bounds); % Convert to degrees
    else
        error('Conversion not known. See help menu of function.')
    end
end

indeces = cell(1,bounds_size-1);
vec = zeros(size(vector));

% Get all relevant data point indeces for desired intervals
for i = 1: (bounds_size - 1)
    dmin = bounds(i);
    dmax = bounds(i+1);
    
    ind_min  = find(vector >= dmin);
    ind_max  = find(vector < dmax);
    indeces{i} = intersect(ind_min,ind_max);
end

for j = 1:numel(vec)
    for i = 1:(bounds_size - 1)
        dmin = bounds(i);
        dmax = bounds(i+1);
        if (vector(j) >= dmin) && (vector(j) < dmax)
            vec(j) = i;
        end
    end
end

kempty=[];
for k = 1:bounds_size-1
    if isempty(indeces{k})
        kempty = [kempty k];
    end
end
kempty         = unique(kempty);
bounds(kempty) = [];

bounds(end) = bounds(end-1) + abs(bounds(2)-bounds(1))
indeces     = removecellrowcols(indeces,kempty,'cols');
bounds_size = bounds_size - length(kempty);

if bounds_size ~= length(bounds)
    error('Wrong truncation')
end

end