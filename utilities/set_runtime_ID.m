function [runtimeID] = set_runtime_ID()

rng shuffle
runtimeID  = randi(10000);
fprintf('\nMy runtime ID is %d',runtimeID);

end