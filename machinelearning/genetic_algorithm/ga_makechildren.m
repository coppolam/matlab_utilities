function [ kids ] = ga_makechildren( firstParents, secondParents,pop )

%     firstKids  = reshape(  bi2de(or(de2bi(firstParents,8),de2bi(secondParents,8))),size(firstParents,1),size(firstParents,2));
%reshape(  bi2de(xor(de2bi(firstParents,8),de2bi(secondParents,8))),size(firstParents,1),size(firstParents,2));
% firstKids = reshape(  bi2de(or(de2bi(firstParents,8),de2bi(secondParents,8))),size(firstParents,1),size(firstParents,2));

i = round(pop.agents/2);
firstKids  = [secondParents(:,1:i),firstParents(:,i+1:pop.agents)];
secondKids = [firstParents(:,1:i),secondParents(:,i+1:pop.agents)];

kids = [firstKids;secondKids];

end

