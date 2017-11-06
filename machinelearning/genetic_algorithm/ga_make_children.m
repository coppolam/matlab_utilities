function [ kids ] = ga_make_children( parents_p1, parents_p2 )

% firstKids  = reshape(  bi2de(or(de2bi(firstParents,8),de2bi(secondParents,8))),size(firstParents,1),size(firstParents,2));
% reshape(  bi2de(xor(de2bi(firstParents,8),de2bi(secondParents,8))),size(firstParents,1),size(firstParents,2));
% firstKids = reshape(  bi2de(or(de2bi(firstParents,8),de2bi(secondParents,8))),size(firstParents,1),size(firstParents,2));

random_reshuffle_idx =randperm(size(parents_p2,1));
kids = [parents_p1, parents_p2(random_reshuffle_idx,:)];
end
