function A = areacalc(shape,varargin)
%areacalc calculates the area of a given shape and returns the area
%
% Inputs: "shape" (options are: 'circle', 'square', 'triangle', 'rectangle'), followed by the shape parameters
%
% The shape parameters needed for each shape are:
% If 'circle', specify radius
% If 'square', specify side length
% If 'triangle' or 'rectangle', specify base and height
%
% Developed by Mario Coppola, April 2016

errmsg = 'Wrong number of inputs compared to what is needed to calculate area';
if strcmp(shape,'circle')
	if (nargin ~= 2)
		error(errmsg);
	end
	A = pi.*varargin{1}.^2;

elseif strcmp(shape,'square') 
	if (nargin ~= 2)
		error(errmsg);
	end
	A = varargin{1}.^2;

elseif strcmp(shape,'triangle')
	if (nargin ~= 3)
		error(errmsg);
	end
	A = (b.*h)/2;

elseif strcmp(shape,'rectangle')
	if (nargin ~= 3)
		error(errmsg);
	end
	A = (b.*h);
else
	error('Wrong inputs to function, area not calculated')
end

end