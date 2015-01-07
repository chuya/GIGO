folderRoot = 'dataset'; 
newShape = 0;
newGabor = 0;

addpath('subfunction', 'lib');
folders = dir(folderRoot);
% typeList = {};
fileList = {};


for folderIndex = 3:numel(folders)  
    typeName = folders(folderIndex).name;
%     typeList{end+1} = typeName;
    typeRoute = strcat(pwd,'\',folderRoot,'\',typeName);
    files = dir(typeRoute);
    for fileIndex = 3:numel(files)
        eachFileName = files(fileIndex).name;
        fileList{end+1,1} = strcat(typeRoute,'\',eachFileName);
        fileList{end,2} = typeName;
    end
end

shapeVectors = getShape(fileList, 6, newShape);
gaborVectors = getGabor(fileList, newGabor);

vectors = fuse(shapeVectors, gaborVectors);



