function [Q] = Episode_Learn( Q, s0, param, statespace, actionspace)
% Episode: Perform one episode/trial of the task

Z = zeros(size(Q));  % Eligibility traces matrix
% Select the first action!
[act, act_index] = selectaction('e_greedy', Q, actionspace, s0, param.epsilon);

% The loop runs as long as the situation is neither failure nor success
while abs(flag)~=1
    
    % Get the indexes of the discretized state
    bfn  = GetBFvector( sn , statespace);
    
    % Get the reward and raise a flag
    [rn, flag] = RewardFunc(sn, rewardlims);
    
    % Select the next action (used for SARSA learning + next step)
    [act, act_index_n] = selectaction('e_greedy', Q, actionspace, s0, param.epsilon);

    %Select best action (needed if using Q-learning)
    % [~, act_index] = SelectAction_Parametric('greedy', theta, ...
    %        actionspace, actionsize, bf, param.epsilon);

    % New state -- >  This should be an input to the Q matrix
    
    % param.alpha = 1/(k1+1);
    % alpha is not changed since the scheme is constant

    % Update the Q policy --- Learn!
    % Use ian for SARSA and iabest for Q-learning (reccomended: SARSA)
    [Q, Z] = UpdatePolicy ( Q , Z, rn, state_index, state_index_n, act_index, act_index_n, param );
    
    % Prepare for the next step
    act_index = act_index_n;
    state_index = state_index_n;
    s0 = sn;
    k  = k+1;
end
