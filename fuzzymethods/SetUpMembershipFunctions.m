function [ setmat, lim ] = SetUpMembershipFunctions(x,trapnumber,type, normalize, wrap)
%SetUpMembershipFunctions Sets up trapezoidal membership function for use
%in fuzzy sets

if nargin < 5
    wrap = [];
end

sLims  = linspace(min(x),max(x),trapnumber+2);
lim    = cell(1,numel(sLims)-3);

% Create fuzzy set matrix
nparts = numel(lim);                   % Count limits
setmat = zeros(length(x),nparts);      % Initiate set matrix

if strcmp(type,'trapezoidal')
    % Set up limits
    j = 1;
    for i = 1:nparts+2
        if i < nparts + 1
            lim{i} = [sLims(i) sLims(i+1) sLims(i+2) sLims(i+3)];
        end
        
        if i >= nparts + 1
            if strcmp(wrap,'wrap')
                lim{i} = [sLims(i) sLims(i+1) sLims(j), sLims(j+1)];
                j = j+1;
            else
                lim{i} = [];
            end
        end
    end
    
elseif strcmp(type,'triangular')
    % Set up limits
    
        j = 1;
    for i = 1:nparts+2
        if i < nparts + 1
            lim{i} = [sLims(i) sLims(i+1)  sLims(i+1) sLims(i+2)];
        end
        
        if i >= nparts + 1
            if strcmp(wrap,'wrap')
                lim{i} = [sLims(i) sLims(i+1) sLims(i+1), sLims(j)];
                j = j+1;
            else
                lim{i} = [];
            end
        end
    end
    
else
    error('Please specify a type as the third argument (trapezoidal or triangular');
    
end


if isempty(lim{nparts + 1}) && isempty(lim{nparts+2})
    m = nparts;
else
    m = nparts + 2;
end

for i = 1:m
    setmat(:,i) = fuzzytrap(x,lim{i});
end

% Normalize
if nargin > 3 && strcmp(normalize,'normalize')
    setmat = NormalizeSet( setmat );
end

end

