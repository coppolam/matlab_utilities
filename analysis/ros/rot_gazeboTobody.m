function [ xe, ye ] = ENUearthToNEDbody( xb, yb, psi )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

xe = + xb .* cos(psi) - yb .* sin(psi);
ye = - xb .* sin(psi) - yb .* cos(psi);


end

