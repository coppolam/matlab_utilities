function c_next = make_next_combination_item(c)

i = find(c<=4,1,'last');
if c(i)+1 > 4
    i = find(c<4,1,'last');
    c(i) = c(i)+1;
    c(i+1:end) = c(i);
else
    c(i) = c(i)+1;
end

c_next = c;

end

