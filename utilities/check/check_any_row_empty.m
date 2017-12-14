function out = check_any_row_empty(m)
out = any ( sum( abs(m), 2) == 0 );
end

