function [ varargout ] = flipudall( varargin )
%flipudall flips all the inputs upside down. Number of inputs must match
%the number of outputs.

if nargin ~= nargout
    error('Make sure number of function inputs matches number of function outputs')
end

varargout = varargin;

for i = 1:nargin
    varargout{i} = flipud(varargin{i});
end

end

