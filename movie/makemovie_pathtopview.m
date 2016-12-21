function makemovie_pathtopview(x, y, time, varargin )
%makemovie_slidingplot Makes a movie that moves along the image that can be
%very nice for videos.
% It requires a minimum of 3 inputs: (n, x, y)
%   where
%   x = x vector(s). If more than one, then use cells.
%   y = y vector(s). If more than one, then use cells.
%   time = time vector defining at which time point the x,y coordinates
%   were recorded
%
%   Basic example of usage, try it out!
%
%       clear x y time
%
%       x{1} = linspace(-1,1,100);
%       y{1} = sin(1:100);% 
%       time{1} = 1:100;
%       x{2} = linspace(0,2,1000);
%       y{2} = sin(1:1000); 
%       time{2} = 1:0.1:100;
%       makemovie_pathtopview(x,y,time)
%
%
% Parameters:
%   'FileName':     Name of AVI file (default='matlab_movie')
%   'Title':        Plot title / AVI file title (default='')
%   'XLabel':       X axis label (default='')
%   'YLabel':       Y axis label (default='')
%   'Legend':       Cell array containing all legend entries, 
%                   which should be equal to number of lines being plotted (default={})
%   'LegendLoc':    Location of legend (default='northeast')
%   'Grid':         Add a grid, as long as this is not empty it will be
%                   adding a minor grid and minor as well (default='')
%   'XTickSize':    Tick Size on the X-axis (default=1)
%   'YTickSize':    Tick Size on the X-axis (default=1)
%   'Color':        Color of the line (default=[0 0 1], blue)
%   'YLims':        Y axis limits (default takes absolute maximum based on y vector)
%   'WidthHeight':  Width and Height of the plot in pixels (default=[1920 1080])
%   'TextSize':     Size of all text on the plot
%                   (default=32, this goes along well with the full HD format)
%
% TODO 1: Add ability to write time in a text somewhere in the figure
% TODO 2: include a trail of last few values
% TODO 3: Add possibility to draw borders
% TODO 4: (bonus) Add possibility to use figure instead of point. Like a
% root image instead of just a ball indicating its current position
%
% Developed by Mario Coppola
% December 2016

% Input parameters
filename   = checkifparameterpresent(varargin,'FileName','matlab_movie','string');
plottitle  = checkifparameterpresent(varargin,'Title','','string');
labelxaxis = checkifparameterpresent(varargin,'XLabel','','string');
labelyaxis = checkifparameterpresent(varargin,'YLabel','','string');

lgnd       = checkifparameterpresent(varargin,'Legend',{},'cell');
lgndloc    = checkifparameterpresent(varargin,'LegendLoc','northeast','string');
% arenasize  = checkifparameterpresent(varargin,'Arenasize',[],'array');

xticksize  = checkifparameterpresent(varargin,'XTickSize',1,'number');
yticksize  = checkifparameterpresent(varargin,'YTickSize',1,'number');
grdon      = checkifparameterpresent(varargin,'Grid','','string');

if iscell(x)
    n1 = numel(x);
    if iscell(y)
        n2 = numel(y);
    end
    if round(n1) ~= round(n2)
        error('You must have the same number of x and y lines')
    else
        n = n1;
    end
else
    n = 1;
end

c          = checkifparameterpresent(varargin,'Color',repmat([0 0 1],n,1),'array');
% check that color vector has enough members
if size(c,1) ~= round(n)
    error('Please define enough colors for all lines')
end

if iscell(x)
    xhigh  = ceil(abs(max(cell2mat(y))));
else
    xhigh  = ceil(abs(max(y(:))));
end

if iscell(y)
    yhigh  = ceil(abs(max(cell2mat(y))));
else
    yhigh  = ceil(abs(max(y(:))));
end

xbounds    = checkifparameterpresent(varargin,'YLims',[-xhigh xhigh],'array');
ybounds    = checkifparameterpresent(varargin,'YLims',[-yhigh yhigh],'array');

plotsize   = checkifparameterpresent(varargin,'WidthHeight',[1920 1080],'array');
fontsize   = checkifparameterpresent(varargin,'TextSize',32,'array');

vidObj = VideoWriter(filename,'Motion JPEG AVI');
vidObj.Quality = 100; % Maximum quality, because why not?

% Plotting
handle = randi([0,100000]);
newfigure(handle); %figure with random number
ha = gcf;
ha.Visible = 'off'; % Make figure not visible

xtickvec = xbounds(1):xticksize:xbounds(2);
ytickvec = ybounds(1):yticksize:ybounds(2);

open(vidObj);

disp('Rendering your video. This may take some time.')

if iscell(time)
    t = sort(cell2mat(time));
else
    t = time;
end

for i = 1:length(t)
    
    % Plotting a line
    if iscell(x) && iscell(y)
        for q = 1:n
            j = find(time{q}<t(i),1,'last');
            plot(x{q}(1:j),y{q}(1:j),'color',c(q,:)); hold on;
        end
        
        for q = 1:n
            % And plotting the value at the current point in time
            j = find(time{q}<t(i),1,'last');
            plot(x{q}(j),y{q}(j),'.','color',c(q,:),'LineWidth',2,'MarkerSize',20)
        end
    else
        j = find(time<t(i),1,'last');
        plot(x(1:j),y(1:j),'color',c(1,:)); hold on;
        plot(x(j),y(j),'.','color',c(1,:),'LineWidth',2,'MarkerSize',20); hold on; 
    end
    
    % X-window trimming
    xlim([xbounds(1) xbounds(2)]);
    ylim([ybounds(1) ybounds(2)]);
    
    % Fixing the ticks
    ax = gca;
    ax.XTick = xtickvec;
    ax.YTick = ytickvec;
    
    % Text
    if ~isempty(plottitle)
        title(plottitle)
    end
        
    if ~isempty(labelxaxis)
        xlabel(labelxaxis)
    end
    
    if ~isempty(labelyaxis)
        ylabel(labelyaxis)
    end
      
    if ~isempty(lgnd)
        legend(lgnd{:},'Location',lgndloc)
    end
    
    if ~isempty(grdon)
        grid on
        grid minor
    end
    
    % Make plot pretty
    settexttolatex;
    set(handle, 'PaperPositionMode', 'manual');
    set(handle, 'PaperUnits', 'inches');
    set(handle, 'position',[0 0 plotsize(1) plotsize(2)]);
    set(ha_axes, 'fontsize', fontsize);
    set(ha_legend, 'fontsize', fontsize);
    set(ha_text, 'fontsize', fontsize);

    hold off
    
    savecurrentvideoframe;
end

close(vidObj);

disp('Done rendering your video!')

end

