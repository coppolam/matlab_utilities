function [vectorsmatch] = check_match(x,seq)

vectorsmatch = ~any(xor(x,seq));

end