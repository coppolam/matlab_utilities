function out = countn( m, num, condition )
%countn counts how many of a number there are in a matrix
% Use: count = countn(matrix, number, condition)
% e.g. count = countn(matrix, 4, "<="
% Conditions: 
%               == (default), < , > , <= , >=

if strcmp(condition,'==')
    out = sum(m(:) == num);
elseif strcmp(condition,'<')
    out = sum(m(:) < num);
elseif strcmp(condition,'>')
    out = sum(m(:) > num);
elseif strcmp(condition,'>=')
    out = sum(m(:) >= num);
elseif strcmp(condition,'<=')
    out = sum(m(:) <= num);
else
    error('No valid condition specified');
end    

end

