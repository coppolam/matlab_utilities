function [authority,hubs,i]=hits(A,x0,tol)
% HITS computes the HITS authority vector x and hub vector y
% for an n-by-n adjacency matrix A with starting vector
% x0 (a row vector). Uses power method on A’*A.
%
% EXAMPLE: [x,y,time,numiter]=hits(A,x0,100,1e-8);
%
% INPUT:
%    A = adjacency matrix (n-by-n sparse matrix)
%    x0 = starting vector (row vector)
%    epsilon = convergence tolerance (scalar, e.g. 1e-8)
%
% OUTPUT:
%     x = HITS authority vector
%     y = HITS hub vector
%
% Adapted from Langville et al., Google's PageRank and beyond, 2006
%
% Mario Coppola, 2018

n = size(A,1);

% Tolerance default
if nargin < 2
    tol = 1e-8;
end

% The starting vector is usually set to the uniform vector
if nargin < 3
    x0 = 1/n*ones(1,n);
end

% Do iteration
i = 0;
residual = 1;
authority = x0;
while residual >= tol
    prevx = authority;
    i = i+1;
    authority = authority*A';
    authority = authority*A;
    authority = authority/sum(authority);
    residual = norm(authority-prevx,1);
end
hubs = authority*A';
hubs = hubs/sum(hubs);

end