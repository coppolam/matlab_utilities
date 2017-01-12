%% TODO: Make into a general function

nuavs  = length(IDlist);

ml     = 1:nuavs;
uav    = cell(1,numel(datafile));

rfd         = msg_RAFILTERDATA_bounds();
[fp,fpscal] = msg_ROTORCRAFT_FP_bounds();
rIDs        = createallIDXcombinations( nuavs, 'relativefirst' );

for m = 1:numel(datafile)
    uav = cell(nuavs,nuavs);
    
    for idn = 1:length(rIDs);
        
        i = rIDs(idn,1);
        j = rIDs(idn,2);
        
        if i ~= j

            IDs_own = cell2mat(msg{1}.content(:,rfd.ID   ));
            IDs_oth = cell2mat(msg{1}.content(:,rfd.IDoth));
            pown   = find(IDs_own == IDlist(i));
            poth   = find(IDs_oth == IDlist(j));
            p      = intersect(pown,poth);
            
            uav{i,j} = msgtostruct(msg{1}, msg_RAFILTERDATA_bounds, p, uav{i,j});
            uav{i,j} = clearnonmonotonicmembers(uav{i,j});
              
            time = uav{1,2}.time;
            
            for k = 1:length(uav{i,j}.x)
%             	uav{i,j}.x = movingaveragefilter( k, 1, uav{i,j}.x', [1 2 5 6])';
            end
            
        else
            
            % GET REAL DATA           
            p = findpointswithID(msg{2},IDlist(i));
            uav{i,i} = msgtostruct(msg{2}, msg_ROTORCRAFT_FP_bounds, p, uav{i,i});
          
            uav{i,i}.gt(:,1:2) = uav{i,i}.gt(:,1:2).*fpscal.position;
            uav{i,i}.gt(:,3:4) = uav{i,i}.gt(:,3:4).*fpscal.velocity;
            uav{i,i}.gt(:,  5) = uav{i,i}.gt(:,  5).*fpscal.attitude;
            uav{i,i}.gt(:,  6) = uav{i,i}.gt(:,  6).*fpscal.position;
            
            uav{i,i} = clearnonmonotonicmembers(uav{i,i});
            
            uav{i,i}.gt = interp1( uav{i,i}.time ,uav{i,i}.gt, time, 'linear','extrap');
            
        end
        
    end
    
end

for m = 1:numel(datafile)
    
    for idn = 1:length(rIDs);
        
        i = rIDs(idn,1);
        j = rIDs(idn,2);
        
        if i ~= j
            % Construct the reference (perfect) output of the EKF
            uav{i,j}.realx(:,1:2) = uav{j,j}.gt(:,[2 1]) - uav{i,i}.gt(:,[2 1]);
            uav{i,j}.realx(:,3:4) = uav{i,i}.gt(:,[4 3]);
            uav{i,j}.realx(:,5:6) = uav{j,j}.gt(:,[4 3]);
            uav{i,j}.realx(:,  7) = deg2rad(uav{i,i}.gt(:,5));
            uav{i,j}.realx(:,  8) = deg2rad(uav{j,j}.gt(:,5));
            uav{i,j}.realx(:,  9) = (-uav{j,j}.gt(:,6)) - (-uav{i,i}.gt(:,6));
        end
        
    end
    
end
