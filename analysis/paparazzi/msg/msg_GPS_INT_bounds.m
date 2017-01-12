function [bounds] = msg_GPS_INT_bounds()

bounds.gps_int.time   = 1;
bounds.gps_int.ID     = 2;
bounds.gps_int.vel_xyz = [8:10]+2;

end