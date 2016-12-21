function check_samesize( var1, var2, dim1, dim2)
%check_samesize Checks the size of two variables and returns an error that tells
%you the variable names to fix
%
% Developed by Mario Coppola, October 2015

if nargin == 2
    if any(size(var1) ~= size(var2))
        if ~isempty(inputname(1)) && ~isempty(inputname(2))
            error(['The check found that the variables "' inputname(1)...
                '" and "' inputname(2) '" are of different sizes.']);
        else
            error('The check found that the variables are of different sizes than desired.');
        end
    end
end

if nargin == 3
    error('Please specify dimensions of both variables for the check to work.')
end

if nargin == 4
    if any(size(var1,dim1) ~= size(var2,dim2))
        if ~isempty(inputname(1)) && ~isempty(inputname(2))
            error(['The check found that the variables "' inputname(1) ....
                '" and "' inputname(2) '" are of different sizes than desired.']);
        else
            error('The check found that the variables are of different sizes than desired.');
        end
    end
    
end