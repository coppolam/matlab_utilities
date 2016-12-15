function [ rvelvec ] = RotateAll(velvec, ang)
% RotateAll Applies the 2D rotation matrix to elements of a matrix of vectors
%
% Developed by Mario Coppola, October 2015

rvelvec = velvec;

for i = 1 : size (velvec,1)
    rvelvec(i,:) = R_2D(ang(i)) * velvec(i,:)';
end

end