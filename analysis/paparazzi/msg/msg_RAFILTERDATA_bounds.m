function [bounds] = msg_RAFILTERDATA_bounds()

% 6,7: x, y
% 8,9: vx, vy
% 10,11: vx_other, vy_other
% 12, 13: psi_own, psi_other
% 14: z

bounds.rafilterdata.time  = 1;
bounds.rafilterdata.ID    = 2;
bounds.rafilterdata.IDoth = 3;
bounds.rafilterdata.rssi  = 4;
bounds.rafilterdata.sstr  = 5;
bounds.rafilterdata.x     = 6:14;
bounds.rafilterdata.vcmd  = 15:16;

% Convert from NED to ENU (flip x y and reverse z)
bounds.rafilterdata.x_glob = [7 6, 9 8, 11 10];

end