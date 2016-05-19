function [trapezoid] = fuzzytrap(x,lim)
% Funtion to create a vector containing the membership grades of a fuzzy
% set. The spacing and length of the vector are the same as for x.
% The set can be a trapezoid or a singleton, with inputs specified by a
% horizontal vector listing the 4 pivot points of the trapezoid
%   lim = [p1 p2 p3 p4]
% In case of singleton fuzzy input set, then
%   lim = [p p p p]
%
% Developed by Mario Coppola, April 2014

mulim = [0 1];

if nargin < 2
    error('Please define the limits of the trapezoid')
end

% Set up grid
trapezoid = zeros(length(x),1);

% Checking and acting in case input is a singleton
if isequal(lim(1),lim(2),lim(3),lim(4)) == 1
    
    pos = find(x >= lim(1),1,'first');
    trapezoid(pos) = 1;
    
else
    [poslb] = find(x<=lim(1),1,'last');
    [poslt] = find(x<=lim(2),1,'last');
    [posrt] = find(x<=lim(3),1,'last');
    [posrb] = find(x<=lim(4),1,'last');
    
    if poslt > poslb
    trapezoid((poslb:poslt)) = ...
        [mulim(1): mulim(2)/length(trapezoid(poslb:poslt-1)):mulim(2)]';
    end
    
    if posrt > poslt
    trapezoid((poslt:posrt)) = ...
        [mulim(2)*ones(length(trapezoid(poslt:posrt)),1)];
    end
    
    if posrb > posrt
    trapezoid((posrt:posrb)) = ...
        [mulim(2): -mulim(2)/length(trapezoid(posrt:posrb-1)):mulim(1)]';
    end
    
    % special cases for the wrap around function
    if posrt < poslt
        posrtt1 = length(x);
        trapezoid((poslt:posrtt1)) = ...
            [mulim(2)*ones(length(trapezoid(poslt:posrtt1)),1)];
    end
    
    if posrt < poslt
        posltt = 1;
        trapezoid((posltt:posrt-1)) = ...
            [mulim(2)*ones(length(trapezoid(posltt:posrt-1)),1)];
    end
    
    if posrb < posrt && posrb ~= 1
        posrtt2 = 1;
        trapezoid((posrtt2:posrb)) = ...
            [mulim(2): -mulim(2)/length(trapezoid(posrtt2:posrb-1)):mulim(1)]';
    end
    
    if posrb == 1
        posrb3 = length(x);
        trapezoid((posrt:posrb3)) = ...
            [mulim(2): -mulim(2)/length(trapezoid(posrt:posrb3-1)):mulim(1)]';
    end
end

