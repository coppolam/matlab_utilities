function [ m ] = mean_all( varargin )
%mean_all Gets the mean of all vectors put in. If vectors are different sizes, then the longest vector is affected by the mean at its position.

vec = [];
m = varargin{1};
for i = 2:nargin

        if length(varargin{i}) < length(m)
            vec = [m, pad(varargin{i},length(m),1,m)];
        elseif length(varargin{i}) > length(m)
            vec = [pad(m,length(varargin{i}),1,varargin{i}), varargin{i}];
        end
        
        m = mean(vec,2);
        
end

end

