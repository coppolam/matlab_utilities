clear all 
close all
run('../../SetupTools')
addpath (genpath(pwd));

%% Read data
clear uav msg datafile
datafile{1} = 'examplelog/17_09_19__09_54_53';

% Example messages to be extracted
msg{1}.name = 'ROTORCRAFT_FP';
% msg{2}.name = 'GPS_INT';
% msg{4}.name = 'ROTORCRAFT_STATUS';
msg{2}.name = 'OPTIC_FLOW_EST';
% msg{5}.name = 'RAFILTERDATA';

msg = pprz_getmsgdata(msg, [datafile{1}]);
uav = pprz_datatomat (msg, [1]);

disp('Done!');