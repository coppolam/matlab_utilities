function [bf] = GetBFvector(s, statespace)
% IndexStateAction Maps the state to its index location
% Inputs:
%        [state vector, individual state space (in order from left!)]
% Output:
%        Indexed state vector with respect to the state spaces
% 
% Developed by Mario Coppola, February 2015
% E-mail: mariocoppola.92@gmail.com

% Initialize
p = zeros(size(statespace(:,1)));
v = 0.01;

% Calculate the Basis Function vector
for i = 1:size(statespace,2)
    p = p + (s(i)*ones(size(p))-statespace(:,i)).^2/(2*v);
end

% Get the exponential
bf = exp(-p);

end

