function [ Q, Z ] = UpdatePolicy ( Q , Z, reward, bf, bfn, ia, iabest, param )
% UpdatePolicy Updates the linearized Q-function (i.e. the theta matrix)
% 
% Developed by Mario Coppola, February 2015
% E-mail: mariocoppola.92@gmail.com

% Get the estimated Q values
Qcurr = GetQvalue ( bf , Q, ia);
Qmax  = GetQvalue ( bfn, Q, iabest);

% Get the basis function vector and replicate it over theta (for addition)
bfmat       = zeros(size(Q));
bfmat(:,ia) = bf;

% Temporal difference
TDdelta     = ( reward + param.gamma .* Qmax - Qcurr );

% Accumulating eligibility traces
Z = bfmat + param.gamma * param.lambda * Z;

%See https://www.elen.ucl.ac.be/Proceedings/esann/esannpdf/es2007-49.pdf
Q = Q + param.alpha * TDdelta * Z;

end
