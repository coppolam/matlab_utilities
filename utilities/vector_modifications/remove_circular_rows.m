function s = remove_circular_rows(s)

for shift = 1:size(s,2)-1
    s = s(~any(tril(squeeze(all(bsxfun(@eq,s,permute(circshift(s,shift,2),[3 2 1])),2))),2),:);
end

end

