function y = pad(x, n, xstart, m)
% Adds zero after the vector until a certain length is reached
%
% Developed by Mario Coppola, April 2015

y = x;

if size(x,1) == 1 % vertical
y = zeros(1,n);
elseif size(x,2) == 1 % horizontal
y = zeros(n,1);
end

if nargin > 3
    y = y + m;
end

y(xstart:(xstart+length(x)-1)) = x;
