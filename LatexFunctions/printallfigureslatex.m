function printallfigureslatex( figHandles , folder, mode)
% Use: printallfigureslatex(get(0,'Children'), folder (optional))

if nargin < 2
    folder = '';
end

% Standard settings so you don't have to remember what works
if strcmp(mode,'paper_wide_third')
    w = 8;
    h = 4;
    f = 20;
elseif strcmp(mode, 'paper_wide_half')
    w = 8;
    h = 4;
    f = 14;
end
    
for i = 1:numel(figHandles)
    printfiglatex(figHandles(i).Number,'figname',folder,w,h,f)
end

end

