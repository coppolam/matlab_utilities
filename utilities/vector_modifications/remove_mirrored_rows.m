function s = remove_mirrored_rows(s)
% thanks to user Divakar on stackoverflow
% https://stackoverflow.com/questions/34909847/matlab-detect-and-remove-mirror-imaged-pairs-in-2-column-matrix

s = s(~any(tril(squeeze(all(bsxfun(@eq,s,permute(fliplr(s),[3 2 1])),2))),2),:);

end

