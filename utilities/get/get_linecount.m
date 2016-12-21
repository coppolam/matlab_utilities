function n = get_linecount(fid)
%get_linecount counts the amount of lines in a text file
% Use: 		[number of lines (scalar)] = linecount (fid)
%
% Mario Coppola, April 2016 

n = 0;
tline = fgetl(fid);
while ischar(tline)
	tline = fgetl(fid);
n = n+1;

end