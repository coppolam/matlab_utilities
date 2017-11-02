function c_next = make_next_combination_item(c_item, n_max)

i = find(c_item<=n_max,1,'last');
if c_item(i)+1 > 4
    i = find(c_item<n_max,1,'last');
    c_item(i) = c_item(i)+1;
    c_item(i+1:end) = c_item(i);
else
    c_item(i) = c_item(i)+1;
end

c_next = c_item;

end
