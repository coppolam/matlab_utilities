function [ varargout ] = append_all( varargin )
%appendall appends all vectors listed,  avoids writing the same thing many times. The first half ot the input vectors are appended as to their matching in the second half
% 	e.g. To achieve y1 = [x1; x2] and y2 = [x3, x4]
%
%    		[y1, y2] = append_all(x1, x3, x2, x4);
%
% Enjoy the cleaner code!
% Developed by Mario Coppola, December 2015

if nargin ~= nargout*2
    error('This function should have twice as many inputs as it has outputs')
end

varargout = varargin;

for i = 1:nargout
        varargout{i} = [varargin{i}; varargin{i+nargin/2}];    
end


end