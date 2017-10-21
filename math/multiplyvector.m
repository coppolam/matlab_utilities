function [result] = multiplyvector(vector,varargin)

ignore_zeros = checkifparameterpresent(varargin,'ignore_zeros',0,'array');

if ignore_zeros
    vector(vector==0)=[];
end

for i = 2:length(vector)
    vector(i) = vector(i-1)*vector(i);
end

result = vector(end);

end