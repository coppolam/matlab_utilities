function makemovie_slidingplot(x, y, varargin )
%makemovie_slidingplot Makes a movie that moves along the image that can be
%very nice for videos.
% It requires a minimum of 3 inputs: (n, x, y)
%   where
%   x = x vector(s). If more than one, then use cells.
%   y = y vector(s). If more than one, then use cells.
%
%   Basic example of usage, try it out!
%
%       x{1} = 0:0.01:10;
%       y{1} = sin(x{1});
%       x{2} = 0:0.05:9;
%       y{2} = sin(2*x{2});
%       makemovie_slidingplot(x,y)
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
%   'XTickSize':    Tick Size on the X-axis (default=2)
%   'Downhill':     How much of the curve lagging behind you see (default=8)
%   'Uphill':       How much empty space upfront you see (default=3)
%   'Rate':         Rate at which the x-axis moves along (default=0.1)
%   'Color':        Color of the line (default=[0 0 1], blue)
%   'YLims':        Y axis limits (default takes absolute maximum based on y vector)
%   'WidthHeight':  Width and Height of the plot in pixels (default=[1920 1080])
%   'TextSize':     Size of all text on the plot
%                   (default=32, this goes along well with the full HD format)
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

xticksize  = checkifparameterpresent(varargin,'XTickSize',2,'number');
downhill   = checkifparameterpresent(varargin,'Downhill',8,'number');
uphill     = checkifparameterpresent(varargin,'Uphill',3,'number');
rate       = checkifparameterpresent(varargin,'Rate',0.1,'number');
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
end

c          = checkifparameterpresent(varargin,'Color',repmat([0 0 1],n,1),'array');
% check that color vector has enough members
if size(c,1) ~= round(n)
    error('Please define enough colors for all lines')
end

if n > 1
    yhigh  = ceil(abs(max(cell2mat(y))));
else
    yhigh  = ceil(abs(max(y(:))));
end

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

ur = uphill/rate;
wsize = downhill + uphill; % total scrolling window size
wr = wsize/rate;

if n>1
xtickvec = roundtomultiple(min(cell2mat(x)),xticksize):xticksize:roundtomultiple(max(cell2mat(x)),xticksize)+wsize;
wvec = roundtomultiple(min(cell2mat(x)),rate):rate:roundtomultiple(max(cell2mat(x)),rate)+wsize+1;
else
xtickvec = roundtomultiple(min(x(:)),xticksize):xticksize:roundtomultiple(max(x(:)),xticksize)+wsize;
wvec = roundtomultiple(min(x(:)),rate):rate:roundtomultiple(max(x(:)),rate)+wsize+1;
end
ytickvec = ybounds(1):1:ybounds(2);

open(vidObj);

disp('Rendering your video. This may take some time.')

for i = 1:length(wvec)-wr
    
    % Plotting a line
    if n > 1
        for q = 1:n
            j = find(x{q}(:)<(i-1)*rate,1,'last');
            plot(x{q}(1:j),y{q}(1:j),'color',c(q,:)); hold on;
        end
        
        for q = 1:n
            j = find(x{q}(:)<(i-1)*rate,1,'last');
            % And plotting the value at the current point in time
            plot(x{q}(j),y{q}(j),'.','color',c(q,:),'LineWidth',2,'MarkerSize',20)
        end
    else
        j = find(x(:)<(i-1)*rate,1,'last');
        plot(x(1:j),y(1:j),'color',c(1,:)); hold on;
        plot(x(j),y(j),'.','color',c(1,:),'LineWidth',2,'MarkerSize',20); hold on; 
    end
    
    % X-window trimming
    if i>ceil(wr)-ur % moving along
        xlow = wvec(i)-downhill;%x(j-ceil(dr));
        xhigh = wvec(i+wr)-downhill;  %;x(j+ceil(ur));
    else % start (still)
        xlow = 0;
        xhigh = ceil(wsize);
    end
    xlim([xlow xhigh]);
    ylim([ybounds(1) ybounds(2)]);
    
    % Fixing the ticks
    ax = gca;
    ax.XTick = roundtovector(xlow:xticksize:xhigh,xtickvec);
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

