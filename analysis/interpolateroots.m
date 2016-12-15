function [ roots, indeces ] = interpolateroots( x, y, mode )
%mode n2p = negative to positive crossovers
%mode p2n = positive to negative crossovers
%mode all = all crossovers
if nargin < 3
    mode = 'all';
end

roots = zeros(1,10);
indeces = roots;

% Clean up y just in case
y = interpolateNAN(y);
count = 1;

% Scan from left, so check first element
if y(1) > 0
    % positive first? just flip it and look at it the opposite way
    y = -y;
end

if y(1) < 0
    %negative first
    l = (y<0);
    for i = 2:length(l)
        if round(abs(l(i)-l(i-1)),1)==1
            %foundcrossover y = mx+c
            m = (y(i)-y(i-1))/(x(i)-x(i-1));
            c = -m*x(i)+y(i);
           
            if strcmp(mode, 'n2p')
                if m>0
                    % crossover at y = 0 --> x = -c/m
                    roots(count) = -c/m;
                    indeces(count) = i;
                    count = count+1;
                end
            elseif strcmp(mode, 'p2n')
                if m<0
                    % crossover at y = 0 --> x = -c/m
                    roots(count) = -c/m;
                    indeces(count) = i;
                    count = count+1;
                end
            elseif strcmp(mode, 'all')
                % crossover at y = 0 --> x = -c/m
                roots(count) = -c/m;
                indeces(count) = i;
                count = count+1;
            end
            
        end
    end
end

roots = roots(1:count-1);
indeces = indeces(1:count-1);

end

