function [ correct ] = CheckSign( act, est )
%CheckSign Outputs a vector with 1 if the signs of a vector are the same
%and 0 if they are not
%
% Developed by Mario Coppola, October 2015

correct = sign(act) .* sign(est);
correct = correct > 0;

end

