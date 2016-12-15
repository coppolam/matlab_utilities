clear all 
close all

addpath (genpath(pwd));
clc

%% Read data

datafile    = '16_12_03__15_48_35';
IDlist = [201 202]; % Put here the ID of all MAVs that were flying

% Write here the messages you want to read
msg{1}.name = 'RAFILTERDATA';
msg{2}.name = 'ROTORCRAFT_FP';
msg{3}.name = 'ROTORCRAFT_STATUS';
msg{4}.name = 'OPTIC_FLOW_EST';
msg{5}.name = 'GPS_INT';

msg = pprz_getmsgdata(msg, ['examplelog/',datafile]);

%% Separate the logs from the different MAVs based on the IDs
nuavs  = length(IDlist);

ml     = 1:nuavs;

rfd         = msg_RAFILTERDATA_bounds();
[fp,fpscal] = msg_ROTORCRAFT_FP_bounds();
rIDs        = createallIDXcombinations( nuavs, 'relativefirst' );

for m = 1:numel(datafile) % for each datafile (in this case only one)
    uav = cell(nuavs,nuavs);    
    uavof = cell(nuavs,nuavs);
    uavgps = cell(nuavs,nuavs);

    for idn = 1:length(rIDs)
        
        i = rIDs(idn,1);
        j = rIDs(idn,2);
        
        if i ~= j

            IDs_own = cell2mat(msg{1}.content(:,rfd.ID   ));
            IDs_oth = cell2mat(msg{1}.  content(:,rfd.IDoth));
            pown   = find(IDs_own == IDlist(i));
            poth   = find(IDs_oth == IDlist(j));
            p      = intersect(pown,poth);
            
            uav{i,j} = pprz_msgtostruct(msg{1}, msg_RAFILTERDATA_bounds, p, uav{i,j});
            uav{i,j} = clearnonmonotonicmembers(uav{i,j});
              
            time = uav{1,2}.time;
            
            uav{i,j}.x = interp1( uav{i,j}.time ,uav{i,j}.x, time, 'linear','extrap');

        else
            
            % GET REAL DATA           
            p = findpointswithID(msg{2},IDlist(i));
            
            uav{i,i} = pprz_msgtostruct(msg{2}, msg_ROTORCRAFT_FP_bounds, p, uav{i,i});

            uav{i,i}.gt(:,1:2) = uav{i,i}.gt(:,1:2).*fpscal.position;
            uav{i,i}.gt(:,3:4) = uav{i,i}.gt(:,3:4).*fpscal.velocity;
            uav{i,i}.gt(:,  5) = uav{i,i}.gt(:,  5).*fpscal.attitude;
            uav{i,i}.gt(:,  6) = uav{i,i}.gt(:,  6).*fpscal.position;
            uav{i,i}.z (:,1)   = uav{i,i}.z (:,1)  .*fpscal.position;
           
            uav{i,i} = clearnonmonotonicmembers(uav{i,i},0.1,'time'); % do about half of period % TODO: This could also be extracted automatically
            uav{i,i}.gt = interp1( uav{i,i}.time ,uav{i,i}.gt, time, 'linear','extrap');
            
        end
        
    end
    
end

for m = 1:numel(datafile)
    
    for idn = 1:length(rIDs)
        
        i = rIDs(idn,1);
        j = rIDs(idn,2);
        
        if i ~= j
            % Construct the reference (perfect) output of the EKF
            uav{i,j}.realx(:,1:2) = uav{j,j}.gt(:,[2 1]) - uav{i,i}.gt(:,[2 1]);
            uav{i,j}.realx(:,3:4) = uav{i,i}.gt(:,[4 3]);
            uav{i,j}.realx(:,5:6) = uav{j,j}.gt(:,[4 3]);
            uav{i,j}.realx(:,  7) = uav{j,j}.gt(:,6) - uav{i,i}.gt(:,6);
        end
        
    end
    
end


%% Analysis of a flight
%with this you can extract all the points in which the mav was a in a given
%mode. If this happened more than once then you can select which time you'd
%like to extract with the variable flight.

flight = 1;

[startpoints, endpoints] = getnavstartpoints(time, msg{3},'guided');
[ sp, ep ]               = selectflight( startpoints, endpoints, flight );

if ep >= length(uav{t}.time)
    ep = length(uav{t}.time)-sp;
end

mavsize   = 0.5;
as        = 2.0;

x_glob = cell(nuavs,nuavs-1);
z_glob = cell(nuavs,nuavs-1);
ccx    = cell(nuavs,nuavs-1);
ccy    = cell(nuavs,nuavs-1);

% Arena bounds (for figure)

% newfigure(1);
% asv = [-as -as; -as as; as as; as -as; -as -as];

% for k = 1:(ep-sp)
%     k
% figure(1)
% plot(asv(:,1), asv(:,2), 'k--');
% hold on
newfigure(345)
for i=1:length(IDlist) 
    plotpath(uav{i,i}.gt(:,1:2),[colorlist{i},'.'])
end
% ts = ['Time = ', num2str(time(sp+k))] ;
% text(0, as+0.4,ts);
xlim([-(as+1) as+1]);
ylim([-(as+1) as+1]);
% % legend('Arena','MAV1','MAV2','MAV3','location','EastOutside')
% hold off
% % pause
% end

% xlabel('East $\rightarrow$ [m]')
% ylabel('North $\rightarrow$ [m]') 
