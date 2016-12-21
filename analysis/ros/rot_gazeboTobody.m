function [ xe, ye ] = rot_gazeboTobody( xb, yb, psi )
%rot_gazeboTobody Rotates from the world frame used in ROS Gazebo to a standard body frame Forward(x)-Right(y)-Down(z).
%
% Use: [ xe, ye ] = rot_bodyTogazebo( xe, ye, psi ).
% xe   = value along x gazebo world direction (e.g. velocity x).
% ye   = value along y gazebo world direction (e.g. velocity y).
% psi  = current orientation of body w.r.t. gazebo X axis.

xe = + xb .* cos(psi) - yb .* sin(psi);
ye = - xb .* sin(psi) - yb .* cos(psi);


end

