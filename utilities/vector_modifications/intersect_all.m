function out = intersect_all(varargin)
%intersect_all Computes the intersect on several inputs at once (standard matlab
%only handles two inputs.

out = intersect(varargin{1},varargin{2});

for i = 3:nargin
    out = intersect(out, varargin{i});
end

end

