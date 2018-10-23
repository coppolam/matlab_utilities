function [pr,i] = pagerank(H,alpha,v,D,E)
% PageRank computes the PageRank vector for an n-by-n Markov
% matrix H with starting vector pi0 (a row vector),
% scaling parameter alpha (scalar), and teleportation
% vector v (a row vector). Uses power method.
%
% EXAMPLE:[pr,iterations]=pagerank(H,alpha,1e-8,v);
%
% INPUT:
%   H     = row-normalized hyperlink matrix (n-by-n sparse matrix)
%   alpha = follow probability, scalar scaling parameter in PageRank model (scalar), 
%   v     = teleportation vector (1-by-n row vector)
%   D     = 
%   E     = 
%
% OUTPUT:
%   pr = PageRank vector
%   i  = iteration
%
% Adapted from Langville et al., Google's PageRank and beyond, 2006
%
% Mario Coppola, 2018

% The starting vector is usually set to the uniform vector,
n = size(H,1);
pr_0 = 1/n * ones(1,n);

% Make sure H is normalized
H = H./sum(H,2);
H(isnan(H)) = 0;

% Tolerance
tol = 1e-8; % convergence tolerance (scalar, e.g. 1e-8)

% Personalization vector default
if nargin < 3
    v = 1/n * ones(n,1);
end

% Get "a" vector, where a(i)=1, if row i is dangling node and 0
rowsumvector = ones(1,n)*H';
nonzerorows  = find(rowsumvector);
zerorows     = setdiff(1:n,nonzerorows);
l            = length(zerorows);
a            = sparse(zerorows,ones(l,1),ones(l,1),n,1);

% Iterative procedure
i = 0;
pr = pr_0;
residual = 1;
while residual >= tol
    pr_previous = pr;
    i = i+1;
    % The following two are equivalent. One is the one from the book
    % the other one is just organized such that the random and follow items
    % are more clearly separated into terms 1 and 2.
    
    % Simplified expression from book
    % pr = alpha * pr * H + ( alpha * (pr*a) + 1 - alpha) * v';
    
    % Divide two terms
    if nargin <= 3
        D  = a*v';        % Dangling node teleportation matrix
        E  = ones(1,n)*v; % Teleportation matrix
        keyboard
    end
    pr = pr * (alpha .* (H + D) + (1 - alpha) .* E);
    
    residual = norm ( pr - pr_previous, 1 );
end

end