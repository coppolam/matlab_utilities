function [] = drawgrid(fign,N,min,max)

if nargin < 1
    error('Please give a figure number at least')
end

if nargin>1 && nargin < 4
    error('Indicate size fully')
end

x = linspace(min,max,N+1);
y = linspace(min,max,N+1);

figure(fign)

% Horizontal grid
for k = 1:length(y)
    figure(1)
    line([x(1) x(end)], [y(k) y(k)])
end

% Vertical grid
for k = 1:length(y)
    figure(1)
    line([x(k) x(k)], [y(1) y(end)])
end
hold on

axis square