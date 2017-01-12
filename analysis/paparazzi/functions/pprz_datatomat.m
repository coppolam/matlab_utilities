function [ uav ] = pprz_datatomat( msg, IDlist )

[ IDlist, nuavs, uav] = IDsetup(IDlist);

for i = 1:nuavs
    for j = 1:numel(msg)
        uav{i} = pprz_extractdata(uav{i}, msg{j}, IDlist(i));
    end
end

end

