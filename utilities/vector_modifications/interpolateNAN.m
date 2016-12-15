function [ y ] = interpolateNAN( x )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
y = x;
if isnan(x(1))
    y(1) = x(2);
end

for i = 2:length(x)-1
    if isnan(x(i))
        y(i) = (x(i-1) + x(i+1))/2;
    end
end


if isnan(x(end))
    y(end) = x(end-1);
end