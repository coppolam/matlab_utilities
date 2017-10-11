function [ action_idx, possibleactions ] = rl_selectaction(Q, state_idx, epsilon)
% SelectAction selects an action to pursue from the given discrete action
% space based on the e-greedy method

global Q_reference

t = rand();
possibleactions = find(abs(Q_reference(state_idx,:))>0);

if t < epsilon % Random
    action_idx = rand_from_vector(possibleactions);
else % Greedy
    [~, action_idx] = max(Q(state_idx,possibleactions));
    action_idx = possibleactions(action_idx);
end

end