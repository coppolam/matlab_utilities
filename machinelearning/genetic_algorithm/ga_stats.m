function [ bestfit, meanfit ] = ga_stats( ftns )

    bestfit = min(abs(ftns));
    meanfit = mean(ftns);

end

