function [bounds,factor] = msg_ROTORCRAFT_FP_bounds()
% Position scaling 0.0039063
% Velocity scaling 0.0000019
% Attitude scaling 0.0139882

bounds.rotorcraft_fp.time   = 1;
bounds.rotorcraft_fp.ID     = 2;
bounds.rotorcraft_fp.pos_xy = 3:4;
bounds.rotorcraft_fp.vel_xy = 6:7;
bounds.rotorcraft_fp.psi    = 11;
bounds.rotorcraft_fp.z      = 5;
bounds.rotorcraft_fp.pos    = 3:5;
bounds.rotorcraft_fp.vel    = 6:8;
bounds.rotorcraft_fp.att    = 9:11;
bounds.rotorcraft_fp.gt     = [3,4,6,7,11,5];

end