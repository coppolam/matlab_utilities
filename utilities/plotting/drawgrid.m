function drawgrid(handle,N,min,max,color)
%drawgrid draws an evenly spaced out grid on the plot (square) between the specified limits
% TODO: Make it so x and y do not have to be the same but can be independent

if nargin < 1
    error('Please give a figure number at least')
end

if nargin>1 && nargin < 4
    error('Indicate size fully')
end

if nargin<5
	color = [0 0 0];
end

x = linspace(min,max,N+1);
y = linspace(min,max,N+1);

figure(handle)
hold on

% Horizontal grid
for k = 1:length(y)
    line([x(1) x(end)], [y(k) y(k)],'color',[color])
end

% Vertical grid
for k = 1:length(y)
    line([x(k) x(k)], [y(1) y(end)],'color',color)
end

xlim([x(1) x(end)])
ylim([x(1) x(end)])
