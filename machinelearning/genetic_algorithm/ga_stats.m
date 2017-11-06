function [ bestfit, meanfit, elite ] = ga_stats( ftns )
    
    [bestfit,elite] = min(abs(ftns));
    meanfit = mean(ftns);

end

