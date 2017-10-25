function s = remove_empty_cells(s)
s = s(~cellfun('isempty', s));
end

