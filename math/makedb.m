function [ y ] = makedb( x )
%makedb Makes power into dB, but only multiplies by 10 (no need to take squared
%root)

y = 10*log10(x);

end

