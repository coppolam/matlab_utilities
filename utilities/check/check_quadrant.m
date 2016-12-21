function [ quadrant ] = check_quadrant(x_act, x_est, y_act, y_est)
%check_quadrant Checks if the function in the right quadrant. Output 1 if
%correct and -1 if wrong
%
% Developed by Mario Coppola, October 2015

xsign = CheckSign(x_act,x_est);
ysign = CheckSign(y_act,y_est);

quadrant = xsign.*ysign;

end

