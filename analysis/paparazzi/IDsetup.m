function [ IDlist, nuavs, ml, rIDs ] = IDsetup( IDlist )
% Put here the ID of all MAVs that were flying or that you care about

nuavs  = length(IDlist);
ml     = 1:nuavs;
rIDs   = createallIDXcombinations( nuavs, 'relativefirst' );

end

