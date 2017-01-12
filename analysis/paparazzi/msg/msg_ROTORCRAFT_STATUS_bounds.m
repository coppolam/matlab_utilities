function [bounds] = msg_ROTORCRAFT_STATUS_bounds()

bounds.rotorcraft_status.time             = 1;
bounds.rotorcraft_status.ID               = 2;

bounds.rotorcraft_status.link_imu_nb_err  = 3;
bounds.rotorcraft_status.motor_nb_error   = 4;
bounds.rotorcraft_status.rc_status        = 5;

bounds.rotorcraft_status.frame_rate       = 6;
bounds.rotorcraft_status.gps_status       = 7;
bounds.rotorcraft_status.ap_mode          = 8;

bounds.rotorcraft_status.ap_in_flight     = 9;
bounds.rotorcraft_status.ap_motors_on     = 10;
bounds.rotorcraft_status.ap_h_mode        = 11;
bounds.rotorcraft_status.ap_v_mode        = 12;
bounds.rotorcraft_status.ap_vsupply       = 13;
bounds.rotorcraft_status.ap_cpu_time      = 14;

end