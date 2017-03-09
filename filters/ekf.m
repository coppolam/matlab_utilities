function [x,P] = ekf(f,x,P,h,z,Q,R,dt)
% EKF   Extended Kalman Filter for nonlinear dynamic systems
% [x,P] = ekf(f,x,P,h,z,Q,R) returns state estimate, x and state covariance, P
% for nonlinear dynamic system:
%           x_k+1 = f(x_k) + w_k
%           z_k   = h(x_k) + v_k
%
% where w ~ N(0,Q) meaning w is gaussian noise with covariance Q
%       v ~ N(0,R) meaning v is gaussian noise with covariance R
%
% Inputs:   f: function handle for f(x)
%           x: "a priori" state estimate
%           P: "a priori" estimated state covariance
%           h: fanction handle for h(x)
%           z: current measurement
%           Q: process noise covariance
%           R: measurement noise covariance
%
% Output:   x: "a posteriori" state estimate
%           P: "a posteriori" state covariance
%
% By Yi Cao at Cranfield University, 02/01/2008
%
% Modified by Mario Coppola, October 2015

% Get the jacobian
% Non-linear update and linearization at current state

% Predict
[x_p, A] = getjacobian(f, x); % use latest state
[z_p, H] = getjacobian(h, x_p); % use predicted state

P   	    = A * P * A' + Q;

% Update
P12 = P * H';
K   = P12/(H * P12 + R);
x   = x_p + K * (z - z_p);
P   = (eye(numel(x)) - K * H) * P;

end


% Function that returns the jacobian
function [z,J]=getjacobian(fun,x)
% getjacobian Returns the function values and its Jacobian through complex step differentiation
% [z J] = getjacobian(f,x)
% z = f(x)
% J = f'(x)

% Evaluate the function with the current data
z = fun(x);

% Get some data initializing data
n = numel(x); % # of states
m = numel(z); % # of outputs
J = zeros(m,n); % Memory for output jacobian

% eps returns the distance from 1.0 to the next larger
% double-precision number; eps = 2^-52.
% So h is as close to an "infinitesimal step" as we can get
h = n * eps;

% For each state, do the following (go column by column)
for k  = 1:n
    
    % Derivative of states
    dx      = [ zeros(k-1,1); h; zeros(n-k,1)];
    
    % Put into Jacobian
    J(:,k)  = ( fun(x+dx) - z) / h;
    
end

end