function [pout] = circlegen(p0,r,points)
%circlegen creates the x and y coordinate points for a circle
%
% Inputs: p0, r, points.
% where p0 = [x y], where x and y are the positions for the center of the circle
% r = radius
% points = number of points that draw the circle (default if unspecified = 1000)
% 
% Output: p = [x y], where x and y are vectors of all x and y points that form the circle
%
% Developed by Mario Coppola, November 2015

if nargin < 3
	points = 1000;
end

ang = linspace(0, 2*pi, points+1);

pout = zeros(points+1, 2);

pout(:,1) = r.*cos(ang)+p0(1);
pout(:,2) = r.*sin(ang)+p0(2);

end