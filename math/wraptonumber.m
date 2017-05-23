function [ x ] = wraptonumber( x , n )
%wraptonumber wraps a number x (input 1) around a fixed limit n (input 2)
%
% Developed by Mario Coppola, May 2017

while any(x > n)
    overflowpositions = x > n;
    x = x - overflowpositions * n;
end

end

