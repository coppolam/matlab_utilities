function [bounds] = msg_OPTIC_FLOW_EST_bounds()

bounds.optic_flow_est.time   = 1;
bounds.optic_flow_est.ID     = 2; % these two are always there

bounds.optic_flow_est.velxy = 10:11;

end