function [ Q, rl, stats ] = rl_learn( rl, varargin )
% Function to run a reinforcement learning algorithm

stats.n_episodes = 0;
conv_count = 0;
stop_flag = 0;

Q              = checkifparameterpresent(varargin,'Q',zeros(rl.n_states,rl.n_actions),'array');
state_global_0 = checkifparameterpresent(varargin,'initialstate',1,'array');
visualize      = checkifparameterpresent(varargin,'visualize',0,'array');
verbose        = checkifparameterpresent(varargin,'verbose',0,'array');
randomized     = checkifparameterpresent(varargin,'randomized',1,'array');
learn          = checkifparameterpresent(varargin,'learn',1,'array');

if visualize
    newfigure(3);
    newfigure(4);
end

while stop_flag == 0
    stats.n_episodes = stats.n_episodes + 1;
    
    [Qn, rl, reward, n_steps] = rl_episode(rl, state_global_0, Q, ...
        'learn', learn,'visualize', visualize);
    
    if ~randomized
        rl.param.epsilon = rl.param.epsilon * rl.param.egreedy;
    end
    
    stats.rewards(stats.n_episodes) = reward;
    stats.epsilon(stats.n_episodes) = rl.param.epsilon;
    stats.n_steps(stats.n_episodes) = n_steps;
    stats.sum_happy{stats.n_episodes} = sum_happy;
    
    if verbose
    disp(['Episode ', num2str(stats.n_episodes), ...
        '    Reward on exit = ', num2str(reward),...
        '    Number of steps = ', num2str(n_steps)])
    end
    
    if visualize
        figure(3)
        plot(1:length(stats.rewards), stats.rewards,'b'); hold on
        plot(1:length(stats.epsilon), stats.epsilon*100,'r'); hold on
        plot(1:length(stats.n_steps), stats.n_steps,'k');
        xlabel('Episodes')
        ylabel('Stats')
        drawnow;
    end
    
    [stop_flag, Q, conv_count] = stoppingcriteria( stats.n_episodes, conv_count, Q, Qn );

end

end