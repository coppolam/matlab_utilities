function [runtimeID] = set_runtime_ID()

rng shuffle

prompt    = '\n\nDo you desire a runtime ID? \n(Click <Enter> for a random one) \n  >> ';
runtimeID = str2double(input(prompt,'s'));
if isempty(runtimeID)
    runtimeID  = randi(10000);
    fprintf('\nMy random runtime ID is %d',runtimeID);
end


end