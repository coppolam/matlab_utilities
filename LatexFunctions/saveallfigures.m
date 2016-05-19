% Script to save all currently open figures

figHandles = get(0,'Children')
for i = 1:numel(figHandles)
    printfiglatex(figHandles(i).Number,'figname','Figures/',16,8,16)
end
