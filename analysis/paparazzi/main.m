clear all 
close all
run('../../SetupTools')
addpath (genpath(pwd));

%% Read data
clear uav msg datafile
datafile{1} = '16_12_03__15_48_35';

% Example messages to be extracted
msg{1}.name = 'ROTORCRAFT_FP';
msg{2}.name = 'GPS_INT';
msg{4}.name = 'ROTORCRAFT_STATUS';
msg{3}.name = 'OPTIC_FLOW_EST';
msg{5}.name = 'RAFILTERDATA';

msg = pprz_getmsgdata(msg, ['examplelog/',datafile{1}]);
uav = pprz_datatomat (msg, [201]);

disp('Done!');