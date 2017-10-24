function [ kids ] = ga_mutatechildren( kids, alg )
    
    for i = numel(kids(:))
        r = 0 + (1-0).*rand(1,1);
        if r < alg.mutation
            kids(i) = randi([1,255],1);
        end
    end

end