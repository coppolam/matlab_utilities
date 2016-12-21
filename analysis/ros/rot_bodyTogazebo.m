function [ xe, ye ] = rot_bodyTogazebo( xb, yb, psi )
%rot_bodyTogazebo Rotates from a plan body frame Forward(x)/Right(y)/Height(z) to the world frame used in ROS Gazebo.
%
% Use: [ xe, ye ] = rot_bodyTogazebo( xb, yb, psi ).
% xb   = value along x body direction (e.g. velocity x).
% yb   = value along y body direction (e.g. velocity y).
% psi  = current orientation w.r.t. gazebo X axis.

xe = + xb .* cos(-psi) - yb .* sin(-psi);
ye = - xb .* sin(-psi) - yb .* cos(-psi);


end