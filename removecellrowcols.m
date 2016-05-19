function cell_list = removecellrowcols(cell_list,rowcols,mode)
% Adapted by Mario Coppola from the work by: Jose Crespo Barrios
% ---------------
% EXPLANATION: removes the non desired rows/columns from a cell.
% For example, if we have a [3x3] cell, and introduce:
%
% cellA = fun_removecellrowcols(cellA,2,'rows')
% the output will be a [2x3] cell, in which the middle row has been removed
% If introduced instead:
%
% cellA = fun_removecellrowcols(cellA,[1,2],'cols')
% then the dimensions of cellA will be [3x1] in which 1st and 2nd columns
% have been removed.
% ---------------
% - cell_list:  the cell variable we desire to process
% - rowcols:    vector of rows/cols to be removed from the cell variable
% - mode:       'rows' or 'cols'

% Make sure that rowcols is a column vector
if size(rowcols,2) > 1
    rowcols = rowcols';
end

if strcmp(mode,'rows')
    
    ncols = size(cell_list,2);
    
    for auxrows = 1:length(rowcols)
        row          = rowcols(auxrows,1);
        cell_list(row,:) = cell(1, ncols);
    end
    
    cell_list = reshape( cell_list(~cellfun('isempty',cell_list)), [], ncols);
    
elseif strcmp(mode,'cols')
    
    nrows = size(cell_list,1);
    
    for auxrows = 1: length(rowcols)
        col          = rowcols(auxrows,1);
        cell_list(:,col) = cell(nrows, 1);
    end
    
    cell_list = reshape( cell_list (~cellfun('isempty',cell_list)), nrows, []);
    
else
    error('Specify if rows or columns should be removed')
end