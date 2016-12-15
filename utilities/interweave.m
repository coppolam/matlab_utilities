function [ y ] = interweave( a, b )
%interweave Interweaves two vectors
keyboard
data = [makevertical(a), makevertical(b)];
y = reshape(data',numel(data),1);

end

