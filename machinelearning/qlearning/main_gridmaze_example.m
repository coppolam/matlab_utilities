cd /home/mario/phdwork/matlab/reinforcement_learning
run('../tools/SetupTools.m')
addpath(genpath(pwd));

%% Parameters
clc
clear

rl.param.alpha   = 0.99; % Learning parameter
rl.param.gamma   = 0.9; % Discount rate (how knowledge gain increase over steps)
rl.param.epsilon = 1.0; % Initial e-greedy paramater (=1 to start with full exploration)
rl.param.lambda  = 0.9; % Eligibility trace parameter
rl.param.egreedy = 0.99; % Reduction of egreedy parameter at each new episode

rl.model  = @model_gridmaze;
rl.reward = @reward_gridmaze;
rl.flag   = @flag_gridmaze;

rl.n_states  = 121;
rl.n_actions = 4;
rl.param.n_agents = 1;

%% Learn
Q = rl_learn( rl, 'initialstate', [30]);

%% Test
newfigure(44)
flag = 0;
reward = 0;
state_idx = 50;
step = 1;
statespace  = setprod(-5:1:5, -5:1:5);
state_idx_store = [];

while flag == 0 && step < 100
    action_idx  = rl_selectaction ( Q, rl.n_actions, state_idx, 0 );
    state_idx_n = rl.model( state_idx, action_idx );
    reward      = rl.reward ( reward, state_idx, step );
    flag        = rl.flag ( reward );
    state_idx_store = [state_idx_store, state_idx];
    state_idx = state_idx_n;
    step = step+1;
end
plot(statespace(state_idx_store(1),1),statespace(state_idx_store(1),2),'g.');
hold on
plot(statespace(state_idx_store,1),statespace(state_idx_store,2));
plot(statespace(state_idx_store(end),1),statespace(state_idx_store(end),2),'r.');
xlim([-5 5])
ylim([-5 5])
hold off