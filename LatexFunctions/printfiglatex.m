function printfiglatex(handle,filename,folder,w, h, fontsize,outtype)
% Saves figures in eps format to be used with Latex, and under the size
% specified. It needs checkFileName.m to run!.
%
% Developed by Mario Coppola, October 2015


% Check that at least the minimum requirements are given
if nargin < 2
    error('Specify the figure handle and the output file name')
end

% Get a name
if strcmp(filename,'figname')
    filename = get(handle,'Name');
    % If the figure is not named, then use its number
    if isempty(filename)
        filename = 'fignumber';
    end
end

if strcmp(filename,'fignumber')
    filename = num2str(handle);
end

% Default size values if unsupplied
if ~exist('w','var')
    w               = 8;
end
if ~exist('h','var')
    h               = 8;
end
if ~exist('fontsize','var')
    fontsize        = 20;
end
if ~exist('outtype','var')
    outtype = '-depsc2'; % File format for latex
end
if ~exist('folder','var')
    outtype = ''; % File format for latex
end

% Set up the full save path
filename = [folder,filename];
ha = get(handle,'children');
ha_axes = get(handle,'CurrentAxes');

ha_legend = findobj('Tag','legend');
set(ha_legend,'Interpreter','Latex');

set(ha, 'defaulttextinterpreter', 'latex')
set(ha_axes, 'TickLabelInterpreter', 'latex');

% Get axes for font size manipulation
set(handle, 'PaperPositionMode', 'manual');
set(handle, 'PaperUnits', 'inches');
set(handle, 'PaperPosition',[0 0 w h]); % last 2 are width/height.
set(ha, 'fontsize', fontsize);

filename = checkFileName(filename); % Check if filename is Latex ready

print(handle,outtype,filename) % Prints the figure

end