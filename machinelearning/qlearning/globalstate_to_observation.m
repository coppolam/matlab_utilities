function [state_local] = globalstate_to_observation(rl, state_global)
if ~isempty(rl.observation)
    state_local = rl.observation (state_global);
else
    state_local = state_global_n;
end
end