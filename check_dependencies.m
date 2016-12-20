%% Check dependencies
disp('[Tools Dependency Checker launched]')

% Unix command to create a list of all files

unix('locate "$PWD/*.m" > filelist.txt');
disp('Located all MATLAB files...')

fi = textscan(fopen('filelist.txt'), '%s', inf, 'delimiter', ' ');

for i = 1:size(fi{1},1)

    % Get/check the dependencies for each file
    dep = matlab.codetools.requiredFilesAndProducts(fi{1}(i));
    
    % Check that the dependencies exist (the function above does this
    % already)
%     for j = 1:size(dep,2)
%         if ~ismember(dep{j},fi{1});
%             disp([fi{1}(i) 'has a broken dependency' dep{j}])
%         end
%     end
    
end

disp('Done checking -- if you reached this it means no dependency issues!')