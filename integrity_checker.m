%% Load tools
SetupTools

%% Create list of all files (UNIX ONLY)
% Unix command to create a list of all files
unix('sudo updatedb');
unix('rm filelist.txt');
unix('locate "$PWD/*.m" > filelist.txt');

disp('Located all MATLAB files...');

%% Check dependencies
disp('[Tools Dependency Checker launched]');
disp('Run this until you get no error messages.')

fi = textscan(fopen('filelist.txt'), '%s', inf, 'delimiter', ' ');

for i = 1:size(fi{1},1)

    % Get/check the dependencies for each file
    % This function will return an error if the required files are not
    % found
    disp(['Checking:' fi{1}(i)])
    matlab.codetools.requiredFilesAndProducts(fi{1}(i));
    disp('                   ...no dependency issues found.')
    
end

clear fi

disp('Done checking. If this point is reached then no dependency issues are found.')
disp('[Tools Dependency Checker closed]')

%% Check duplicates

disp('   ');
disp('[Tools Duplicates Checker launched]');

fi = textscan(fopen('filelist.txt'), '%s', inf, 'delimiter', ' ');

for i = 1:size(fi{1},1)
    [start_filename] = strfind(fi{1}(i),'/');
    currentfile = fi{1}(i);
    currentfilestr = currentfile{1}(max(start_filename{end}+1):end);
    fnd = strfind(fi{1}(:),currentfilestr);
    emptyIndex = cellfun(@isempty,fnd);       % Find indices of empty cells
    fnd(emptyIndex) = {0};                    % Fill empty cells with 0
    [mylogicalarray,mylogicalpos] = find(cell2mat(fnd)>1);  %# Convert the cell array

    if length(mylogicalarray) > 1
        disp(['(Potential) duplicates found for: ', currentfilestr]);
        disp(fi{1}(mylogicalarray))
    end
end

clear fi

disp('[Tools Duplicates Checker closed]')
disp('   ');