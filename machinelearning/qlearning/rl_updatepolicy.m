function [ Q, Z ] = rl_updatepolicy ( Q , Z, reward, state_idx, action_idx, ...
                                            state_idx_n, action_idx_learn, param )
% UpdatePolicy Updates the Q-function
%
% Developed by Mario Coppola, February 2015
% E-mail: mariocoppola.92@gmail.com
Q_current  = Q( state_idx,   action_idx       );
Q_learning = Q( state_idx_n, action_idx_learn );

% Temporal Difference
TDdelta    = reward + param.gamma .* Q_learning - Q_current ;
Z(state_idx, action_idx) = Z(state_idx, action_idx) + 1;

% See https://www.elen.ucl.ac.be/Proceedings/esann/esannpdf/es2007-49.pdf
% param.alpha = param.alpha * 0.99;
Q = Q + param.alpha * TDdelta * Z;

if any(isnan(Q))
    warning('Q went NaN')
    keyboard
end
    
end