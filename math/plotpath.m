function plotpath(x,mode,stpoint,endpoint,markersize,addmark)
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

if ~exist('addmark','var')
    addmark = [];
end

if ~exist('mode','var')
    mode = 'b';
end

if size(x,2) == 2
    
    plot(x(:,1),x(:,2),mode);
        hold on
        
    if strcmp(addmark,'addmark')
%         keyboard
        plot(x(1,1),x(1,2),...
            stpoint,'LineWidth',2,'MarkerSize',markersize);
        plot(x(end,1),x(end,2),...
            endpoint,'LineWidth',2,'MarkerSize',markersize);
        
%         for i = 1:size(x,1)
%             xt = [x(i,1) x(i,2)];
%             str = int2str(i);
%             text(xt(1),xt(2),str);
%         end
    end
    
    
elseif size(x,2) == 3
    
    plot3(x(:,1),x(:,2),x(:,3),mode);
    
    
    if strcmp(addmark,'addmark')
        
        hold on
        plot3(x(1,1),x(1,2),x(1,3),...
            stpoint,'LineWidth',2,'MarkerSize',markersize);
        plot3(x(end,1),x(end,2),x(end,3),...
            endpoint,'LineWidth',2,'MarkerSize',markersize);
        
%         for i = 1:size(x,1)
%             xt = [x(i,1) x(i,2) x(i,3)];
%             str = int2str(i);
%             text(xt(1),xt(2),xt(3),str);
%         end
    end
    
end

% set(gca,'Ydir','reverse');
% grid on
% grid minor;
axis equal;

end
