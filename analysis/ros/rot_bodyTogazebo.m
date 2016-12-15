function [ xe, ye ] = bodytoENUearth( xb, yb, psi )

xe = + xb .* cos(-psi) - yb .* sin(-psi);
ye = - xb .* sin(-psi) - yb .* cos(-psi);


end

