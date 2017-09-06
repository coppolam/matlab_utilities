function [ Qout ] = GetQvalue ( bf, theta, ia)
%GetQValue Calculate Q for a given basis vector and Theta matrix, and
%return the value of the Q matrix at the given action index ia
%
% Developed by Mario Coppola, February 2015
% E-mail: mariocoppola.92@gmail.com

Q  = bf'*theta;

Qout = Q(ia);

end

