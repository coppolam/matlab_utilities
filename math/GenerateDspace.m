function [space, spacesize, centerindex, spacediscretization] = ...
    GenerateDspace(spacelim,discretization,dim)
%Generate1Dspace Generates a discretized 1D space centered around 0 based
%on the limit provided and the discretization desired
%
% INPUTS:  spacelimit        - The maximum absolute value within the discretized space
%                               if spacelimit is a vector [min max]
%                                    the space is created along these
%                               if spacelimit is a scalar value
%                                    the space ranges from [-limit limit] with
%                                    n_elements = discretization*2 + 1;
%
%          discretization    - The number of elements between 0 and the maximum value
%
% OUTPUTS: spacediscretization - The step size
%          spacesize           - The length of the entire space vector
%          space               - The actual space vector from -spacelim to +spacelimit
%          centerindex         - The location of the 0 point, if present.
%                                Returns 0 if not present
%
%
% Developed by Mario Coppola, February 2015
% E-mail: mariocoppola.92@gmail.com

if nargin<3
    dim = 1;
end

if numel(spacelim)>=3
    error('The limits are not correctly defined')
elseif numel(spacelim)==2
    a = num2cell(spacelim);
    discretization = discretization+1;

else
    
    a = num2cell([-spacelim,spacelim]);
    discretization = discretization*2+1;
end

dspace              = linspace(a{:},discretization)';
spacesize           = length(dspace);
spacediscretization = abs(dspace(2)-dspace(1));

temp = find(dspace == 0);

if ~isempty(temp)
    centerindex = temp;
else centerindex = 0;
end

space = dspace;
for i = 1:dim-1
    t = dspace;
    space = cat(2,space,t);
end

end