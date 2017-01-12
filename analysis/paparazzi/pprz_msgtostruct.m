function [ var ] = pprz_msgtostruct( msg, horizontal_selection, var)
%msgtostruct Takes a message structure and writes it to variables according
%to the bounds in bounds_struct

bounds = feval(['msg_',msg.name,'_bounds']);

if nargin < 3
    var = 0;
end

if nargin < 3
    horizontal_selection = 1:size(msg{1}.content,1);
end

fname_t = fieldnames(bounds);
fname_l = fieldnames(bounds.(fname_t{1}));

for ff = 1:length(fname_l)
    var.(fname_t{1}).(fname_l{ff}) = ...
        double(cell2mat( msg.content (horizontal_selection,bounds.(fname_t{1}).(fname_l{ff})) )); 
    
    % Scale to SI if weird Paparazzi scaling is used
    cl = [1 1 msg.coef];
    var.(fname_t{1}).(fname_l{ff}) = var.(fname_t{1}).(fname_l{ff})*cl(ff);
    
end   

end