function out = union_all(varargin)
%union_all Computes the union on several inputs at once (standard matlab
%only handles two inputs.

out = union(varargin{1},varargin{2});

for i = 3:nargin
    out = union(out, varargin{i});
end

end

