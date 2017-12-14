function out = check_duplicate_row(m)

out = 0;
if size( unique(m,'rows'),1) ~= size( m, 1) 
    out = 1;
end

end

