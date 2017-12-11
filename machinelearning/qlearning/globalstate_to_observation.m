function [state_local] = globalstate_to_observation(param, state_global)
if ~isempty(param.observation)
    state_local = param.observation (state_global);
else
    state_local = state_global_n;
end
end