function [ uav ] = pprz_extractdata( uav, msg, ID , varargin)

p   = findpointswithID(msg, ID);
uav = pprz_msgtostruct(msg, p, uav);

dt  = checkifparameterpresent(varargin,'clearmonotonic',0.0,'number');
if dt > 0
    uav = clearnonmonotonicmembers(uav,dt,'time'); % do about half of period % TODO: This could also be extracted automatically
end

end