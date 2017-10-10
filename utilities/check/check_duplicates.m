function [anyDuplicates] = check_duplicates(x)

anyDuplicates = ~all(diff(sort(x(x ~= 0))));

end

