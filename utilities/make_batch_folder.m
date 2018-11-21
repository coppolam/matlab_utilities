function [datafolder] = make_batch_folder(datafolder)

prompt       = '\n\nBatch Name (leave empty to use current folder) ?\n  >> ';
batch_name   = input(prompt,'s');
datafolder   = [datafolder,batch_name,'/'];
if ~exist(datafolder,'dir')
    mkdir(datafolder);
end

end
