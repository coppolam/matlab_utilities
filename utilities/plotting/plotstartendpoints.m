function plotstartendpoints(x,stpoint,endpoint,markersize)
%PlotPath Plots the path followed in a world reference frame.
% Works for both 2D and 3D vectors.
%
% Developed by Mario Coppola, October 2015

if ~exist('stpoint','var') || isempty(stpoint) == 1
    stpoint = 'go';
end

if ~exist('endpoint','var') || isempty(endpoint) == 1
    endpoint = 'ro';
end

if ~exist('markersize','var') || isempty(markersize) == 1
    markersize = 10;
end


if size(x,2) == 2
    
    hold on
    plot(x(1,1),x(1,2),...
        stpoint,'LineWidth',2,'MarkerSize',markersize);
    plot(x(end,1),x(end,2),...
        endpoint,'LineWidth',2,'MarkerSize',markersize);
    
    
elseif size(x,2) == 3
    
    hold on
    plot3(x(1,1),x(1,2),x(1,3),...
        stpoint,'LineWidth',2,'MarkerSize',markersize);
    plot3(x(end,1),x(end,2),x(end,3),...
        endpoint,'LineWidth',2,'MarkerSize',markersize);
    
end

end
