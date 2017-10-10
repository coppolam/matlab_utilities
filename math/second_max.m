function [ y ] = second_max( x )
keyboard
 y = max(x(x<max(x,[],2)));
end