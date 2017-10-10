function [ action_idx ] = rl_selectaction(Q, state_idx, epsilon)
% SelectAction selects an action to pursue from the given discrete action
% space based on the e-greedy method

global Qfull

t = rand();
possibleactions = find(abs(Qfull(state_idx,:))>0);

if t < epsilon % Random
    if (length(possibleactions) > 1)
        action_idx = randsample(possibleactions, 1);
    else
        action_idx = possibleactions;
    end
else % Greedy
    [~, action_idx] = max(Q(state_idx,possibleactions));
    action_idx = possibleactions(action_idx);
end

end