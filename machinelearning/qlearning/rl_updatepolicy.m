function [ Q, Z ] = rl_updatepolicy ( Q , Z, reward, bf, bfn, ia, iabest, param )
% UpdatePolicy Updates the linearized Q-function (i.e. the theta matrix)
% 
% Developed by Mario Coppola, February 2015
% E-mail: mariocoppola.92@gmail.com

isn_cell = num2cell(isn);
Qlr = Q(isn_cell{:},ian(1),ian(2));
param.alpha = param.alpha * 0.99;

Qcurr = Q(is_cell{:},ia(1),ia(2));

% Temporal difference
TDdelta     = ( reward + param.gamma .* Qmax - Qcurr );

% Accumulating eligibility traces
Z = param.gamma * param.lambda * Z;
Z(is_cell{:},ia(1),ia(2)) = 1;

%See https://www.elen.ucl.ac.be/Proceedings/esann/esannpdf/es2007-49.pdf
Q = Q + param.alpha * TDdelta * Z;

end
