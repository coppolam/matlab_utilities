function [ lam ] = wavelength( freq , c )
%wavelength Calculates the wavelength of a signal given a certain
%frequency according to lam = c/freq;
%
% Inputs: freq (frequency of wave), c (speed of wave, default = 3*10^8 if unspecified)
%
% Output: wavelength
%
% Developed by Mario Coppola, November 2015

if nargin < 2
    c = 3E8;
end

lam = c/freq;

end

