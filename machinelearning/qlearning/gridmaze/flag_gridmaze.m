function [ flag ] = flag_gridmaze( reward )
	
	flag = 0;

    if (reward < 1)
        flag = -1;
    elseif (reward > 7)
        flag = 1;
    end

end