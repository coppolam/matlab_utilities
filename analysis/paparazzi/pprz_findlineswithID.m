function p = pprz_findlineswithID( msg_struct, IDsofinterest )
%pprz_findlineswithID finds out which lines in a paparazzi *.data log contain a certain aircraft ID. This is used to extract data only on one MAV when multiple ones are being logged. ID in Paparazzi logs is always on the second line

IDs = cell2mat(msg_struct.content(:,2));
p   = find(IDs == IDsofinterest);
       
end

