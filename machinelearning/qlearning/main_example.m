
%% Initiation

% State space values
dhlim  = [-1.5 1.5];
dhdisc = 9;  % Number of discrete items from 0 to lim

dvlim  = [-1.5 1.5];
dvdisc = 9;  % Number of discrete items from 0 to lim

tclim  = [-0.2,1.5];
tcdisc = 7;  % Number of discrete items overall

% Action space values
alim   = 1;
adisc  = 2;

% Set the reward limits 
rewardlimits(1) = GetStateValue([0.5 0.5 0]); % Failure limit
rewardlimits(2) = GetStateValue([1.5 0   0]); % Success limit

% Generate state spaces
[ dhspace, dhsize ] = GenerateDspace( dhlim, dhdisc);
[ dvspace, dvsize ] = GenerateDspace( dvlim, dvdisc);
[ tspace,  tsize  ] = GenerateDspace( tclim, tcdisc);

% Generate the action space
[ aspace  ] = GenerateDspace( alim,  adisc, 3);

space{1} = dhspace;
space{2} = dvspace;
space{3} = tspace;

statespace  = setprod(space{:});
aspace      = setprod(aspace(:,1),aspace(:,2),aspace(:,3));
asize       = length (aspace);

rewardspace = zeros (dhsize, dvsize, tsize);

for i = 1:dhsize
    for j = 1:dvsize
        for k = 1:tsize
            rewardspace(i,j,k) = GetStateValue([dhspace(i) dvspace(j) tspace(k)]);
        end
    end
end

failurestates = FailureSuccessStates('failure', rewardspace, rewardlimits, space{:} );
successstates = FailureSuccessStates('success', rewardspace, rewardlimits, space{:} );
middlestates  = FailureSuccessStates('middle' , rewardspace, rewardlimits, space{:} );

%% Plot the reward scheme and analyze it a bit

close all
Plot_RewardScheme([1 2 3], dhspace, dvspace, tspace, ...
    rewardspace, rewardlimits, failurestates, successstates )

% Sanity check
if size(middlestates,1) + size(failurestates,1) + size(successstates,1) ...
        ~= length(statespace)
    error('Something is wrong')
end

%% Learn

[Q, episodes] = rl_learn(statespace, actionspace, param);
