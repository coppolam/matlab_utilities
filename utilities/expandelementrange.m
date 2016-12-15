function [ y ] = expandelementrange( x, v , delta)

if nargin < 3
    delta = 1.0;
end

nback = v(1);
nforw = v(2);
y = zeros(1,length(x)*(nback+nforw+1));
x_orig = x;

for i = 0:nback
    y(i+1:nforw+nback+1:end)   = x_orig - (nback-(i*delta));
end

for i = nback+1:nback+nforw
    y(i+1:nforw+nback+1:end)   = x_orig + (i-(nback)*delta);
end
    

end
