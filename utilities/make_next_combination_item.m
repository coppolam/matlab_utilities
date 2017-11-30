function c_next = make_next_combination_item(c_item, n_max, forced_idx)

% Index to change
i = find(c_item<=n_max,1,'last');
if c_item(i)+1 > n_max || forced_idx~=0 % Reset row
    i = find(c_item<n_max,1,'last');
    if forced_idx~=0 && c_item(i)+1 <= n_max
        i = forced_idx;
    end
    c_item(i) = c_item(i)+1;
    c_item(i+1:end) = c_item(i);
else
    c_item(i) = c_item(i)+1;
end

c_next = c_item;

end