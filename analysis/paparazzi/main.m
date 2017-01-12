clear all 
close all
addpath (genpath(pwd));

%% Read data
clear msg datafile
datafile{1} = '16_12_03__15_48_35';

% Write here the messages you want to read
% msg{2}.name = 'RAFILTERDATA'; msg{1}.own = 0;
msg{1}.name = 'ROTORCRAFT_FP';
msg{2}.name = 'GPS_INT';
% msg{3}.name = 'ROTORCRAFT_STATUS';
% msg{4}.name = 'OPTIC_FLOW_EST';
 
msg = pprz_getmsgdata(msg, ['examplelog/',datafile{1}]);

%% Separate the logs from the different MAVs based on the IDs
clear uav
[ IDlist, nuavs, ml, rIDs, uav] = IDsetup([201,202]);
rfd  = msg_RAFILTERDATA_bounds();
[fp] = msg_ROTORCRAFT_FP_bounds();

% define primary time vector

% go over all messages listed
% extract info needed

for m = 1:numel(datafile) % for each datafile (in this case only one)

    for idn = 1:length(rIDs)
        
        i = rIDs(idn,1);
        j = rIDs(idn,2);
        
        
%         if msg{i}.own == 0
        if i ~= j
%             
%             IDs_own = cell2mat(msg{1}.content(:,rfd.ID   ));
%             IDs_oth = cell2mat(msg{1}.  content(:,rfd.IDoth));
%             pown   = find(IDs_own == IDlist(i));
%             poth   = find(IDs_oth == IDlist(j));
%             p      = intersect(pown,poth);
%             
%             uav{i,j} = pprz_msgtostruct(msg{1}, msg_RAFILTERDATA_bounds, p, uav{i,j});
%             uav{i,j} = clearnonmonotonicmembers(uav{i,j});
%               
%             time = uav{1,2}.time;
%             
%             uav{i,j}.x = interp1( uav{i,j}.time ,uav{i,j}.x, time, 'linear','extrap');
% TODO: Make a way so that the bounds function is extracted from the
% message name

%             uav{i,j} = pprz_extractdata(uav{i,j}, msg{1}, msg_ROTORCRAFT_FP_bounds, IDlist(i));

        else
%             if msg{i}.own = 1
            uav{i,i} = pprz_extractdata(uav{i,i}, msg{2}, IDlist(i));
            
%             uav{i,i}.gt = interp1( uav{i,i}.time ,uav{i,i}.gt, time, 'linear','extrap');
            
        end
        
    end
    
end
disp('done')
% 
% for m = 1:numel(datafile)
%     
%     for idn = 1:length(rIDs)
%         
%         i = rIDs(idn,1);
%         j = rIDs(idn,2);
%         
%         if i ~= j
%             % Construct the reference (perfect) output of the EKF
%             uav{i,j}.realx(:,1:2) = uav{j,j}.gt(:,[2 1]) - uav{i,i}.gt(:,[2 1]);
%             uav{i,j}.realx(:,3:4) = uav{i,i}.gt(:,[4 3]);
%             uav{i,j}.realx(:,5:6) = uav{j,j}.gt(:,[4 3]);
%             uav{i,j}.realx(:,  7) = uav{j,j}.gt(:,6) - uav{i,i}.gt(:,6);
%         end
%         
%     end
%     
% end


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
