function [ Q, rl, stats ] = rl_learn( rl, varargin )
% Function to run a reinforcement learning algorithm

stats.n_episodes = 0;
conv_count   = 0;
stop_flag    = 0;

Q           = checkifparameterpresent(varargin,'Q',zeros(rl.n_states,rl.n_actions),'array');
state_idx_0 = checkifparameterpresent(varargin,'initialstate',1,'array');

newfigure(4);

while stop_flag == 0
    stats.n_episodes = stats.n_episodes + 1;
    
    [Qn, rl, reward, n_steps] = rl_episode( rl, state_idx_0, Q );
    [stop_flag, Q, conv_count] = stoppingcriteria( n_episodes, conv_count, Q, Qn );
    
    stats.rewards(stats.n_episodes) = reward;
    stats.epsilon(stats.n_episodes) = rl.param.epsilon;
    stats.n_steps(stats.n_episodes) = n_steps;
    
    disp(['Episode ', num2str(stats.n_episodes), ...
        '    Reward on exit = ', num2str(reward),...
        '    Number of steps = ', num2str(n_steps)])
end

newfigure(3);
figure(3)
plot(1:length(stats.reward_store), stats.rewards,'b'); hold on
plot(1:length(stats.epsstore), stats.epsilon*100,'r'); hold on
plot(1:length(stats.nstepsstore), stats.n_steps,'k');
xlabel('Episodes')
ylabel('Stats')
drawnow;

end