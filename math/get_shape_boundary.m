function [boundary_index_locations, agentlocations] = get_shape_boundary( state_global )

% Reset to (0,0)
agentlocations = state_global-state_global(1,:);

% Exceptions (lines)
if all(abs(sum(diff(agentlocations))) - (size(agentlocations,1)-1)==0) ||... % diagonal line
    any(all(diff(agentlocations,1)==0)) % vertical/horizontal line
    boundary_index_locations = 1:size(agentlocations,1);
else
    boundary_index_locations = boundary(agentlocations);
end

end