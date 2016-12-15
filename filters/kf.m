function [x, P] = kf(F,x,P,H,z,Q,R)
%kf Kalman filter implementation
%
% Mario Coppola, October 2015

% Predict
x_p = F*x;
z_p = H*x_p;
P   = F * P * F' + Q;

% Update
P12 = P * H';
K   = P12/(H * P12 + R);
x   = x_p + K * (z - z_p);
P   = (eye(numel(x)) - K * H) * P;

end

