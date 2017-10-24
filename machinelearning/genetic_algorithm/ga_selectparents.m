function [ firstParents,secondParents ] = ga_selectparents( ftns, alg, pop )

    [~,parentIndices] = sort(ftns);
    parentIndices = parentIndices(1:alg.elite*pop.size);
    parentsize = size(parentIndices,2);
    
    firstParents  = pop.members(parentIndices(1:parentsize/2),:);     % First half
    secondParents = pop.members(parentIndices(parentsize/2+1:end),:); % Second half

end

