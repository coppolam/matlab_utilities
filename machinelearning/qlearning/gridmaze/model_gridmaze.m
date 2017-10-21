function [ state_idx ] = model_gridmaze( state_idx, action_idx )

actionspace = [0 1 ; 1 0; -1 0; 0 -1];
statespace  = setprod(-5:1:5, -5:1:5);

state = statespace(state_idx, :) + actionspace(action_idx,:);

state(state<-5) = -5;
state(state> 5) =  5;

state_idx = find(ismember(statespace,state,'rows'),1);

end