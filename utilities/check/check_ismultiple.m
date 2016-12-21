function o = check_ismultiple(i0, i1)
%check_ismultiple Checks that the first input is a multiple of the second input
% returns 0 if not multiple, 1 if multiple
o = ( i1 * round(double(i0)/i1) == i0 );

end