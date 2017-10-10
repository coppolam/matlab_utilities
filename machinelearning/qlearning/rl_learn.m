function [ Q, rl, n_episodes ] = rl_learn( rl, varargin )
% Function to run a reinforcement learning algorithm

n_episodes   = 0;
conv_count   = 0;
stop_flag    = 0;

Q           = checkifparameterpresent(varargin,'Q',zeros(rl.n_states,rl.n_actions),'array');
state_idx_0 = checkifparameterpresent(varargin,'initialstate',1,'array');

newfigure(4);

while stop_flag == 0
    n_episodes = n_episodes + 1;
    
    [Qn, rl, reward, n_steps] = rl_episode( rl, state_idx_0, Q );
    [stop_flag, Q, conv_count] = stoppingcriteria( n_episodes, conv_count, Q, Qn );
    
    reward_store(n_episodes) = reward;
    epsstore(n_episodes) = rl.param.epsilon;
    nstepsstore(n_episodes) = n_steps;
    
    disp(['Episode ', num2str(n_episodes), ...
        ' reward = ', num2str(reward),...
        ' nsteps = ', num2str(n_steps)])
end

newfigure(3);
figure(3)
plot(1:length(reward_store), reward_store,'b'); hold on
plot(1:length(epsstore), epsstore*100,'r'); hold on
plot(1:length(nstepsstore), nstepsstore,'k');
xlabel('Episodes')
ylabel('Reward')
drawnow;

end