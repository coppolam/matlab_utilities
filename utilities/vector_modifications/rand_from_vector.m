function [selected] = rand_from_vector(vector, n_elements)

if nargin < 2
    n_elements = 1;
end

if length(vector) > 1
    selected = randsample(vector, n_elements);
else
    selected = vector;
end

end

