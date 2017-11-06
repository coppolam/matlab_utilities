function [ parents_p1,parents_p2 ] = ga_selectparents( fitness, param, population )

    [~,parentIndices] = sort(fitness);
    parentIndices = parentIndices(1:roundtomultiple(param.elite*param.population_size,1));

    parents_p1 = population(parentIndices,1:4); % First half
    parents_p2 = population(parentIndices,5:8); % Second half
end
