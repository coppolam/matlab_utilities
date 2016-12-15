function printallfigureslatex( figHandles , folder, mode, fignumbers)
% Use: printallfigureslatex(get(0,'Children'), folder (optional), mode)
%
% Example: printallfigureslatex(get(0,'Children'), 'Figures/', 'paper_wide_half')
% Note that the folder must already exist! 
%
% Available modes:
% paper_wide_half
% paper_wide_third (default)
% paper_ultrawide_third (default)
% paper_square_half
% paper_square_fourth

if nargin < 2
    folder = '';
    mode = '';
    fignumbers = [];
end

% Standard settings so you don't have to remember what works
if strcmp(mode,'paper_wide_third')
    w = 8;
    h = 4;
    f = 24;
elseif strcmp(mode,'paper_ultrawide_third')
    w = 12;
    h = 4;
    f = 24;
elseif strcmp(mode, 'paper_wide_half')
    w = 8;
    h = 4;
    f = 18;
elseif strcmp(mode, 'paper_square_half')
    w = 8;
    h = 8;
    f = 18;
    
elseif strcmp(mode, 'paper_square_fourth')
    w = 8;
    h = 8;
    f = 30;
else
    error('No known mode to save the figures specified, please specify.')
%     w = 8;
%     h = 4;
%     f = 20;
end
%     keyboard

if isempty(fignumbers)
    for i = 1:numel(figHandles)
        printfiglatex(figHandles(i).Number,'figname',folder,w,h,f);
    end
else
    for i = 1:length(fignumbers)
        disp(['Saving figure ',num2str(fignumbers(i))]);
        printfiglatex(fignumbers(i),'figname',folder,w,h,f);
    end
end

disp('Done saving figures!')

end

