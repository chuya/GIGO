function preProcess_surf(imgPath)
fprintf('Local feature preProcess Start...\n');
% Using outside lib OpenSURF
% Add lib path to use it
functionname='preProcess_surf.m';
nowDir = 'subfunction\localfunction';
functiondir=which(functionname);
functiondir=functiondir(1:end-( length(functionname)+length('\')+length(nowDir) ));
% functiondir = ./GIGO
addpath([functiondir '\lib\OpenSURF_version1c']);
dataSetPath = imgPath;
% dataSetPath = [functiondir 'dataSet\' imgPath];
allTopicFloderList = dir(dataSetPath);
savePath = [functiondir 'subfunction\temp\tempLocal\prefeature'];
checkOwnDir(savePath);
topicList ={};
for i = 3:numel(allTopicFloderList)
    topicList(i-2) = cellstr(allTopicFloderList(i).name);
end
% if length(topicList) == 1
%     fprintf('Correct\n');
% end
for i = 1:length(topicList)
    nowTopic = char(topicList(i));
    prefeatureSaveDir = [savePath '\' nowTopic];
    checkOwnDir(prefeatureSaveDir);
    imageDir = [imgPath '\' nowTopic];
    imageList = dir(imageDir);
    imageNumber = numel(imageList);
    for imgIndex = 3:imageNumber
        imagePath = [imageDir '\' imageList(imgIndex).name];
        I1=imread(imagePath);
        I1 = imresize(I1,[512 512]);
        Options.upright=true;
        Options.tresh=0.0001;
        Ipts1=OpenSurf(I1,Options);
        D1 = reshape([Ipts1.descriptor],64,[]);
        imageName = imageList(imgIndex).name(1:end-4);
        descriptorSavePath = [prefeatureSaveDir '\' imageName '-descriptor.txt'];
        dlmwrite(descriptorSavePath,D1);
        fprintf('T:(%s) Progress Bar %d/%d \n',nowTopic,imgIndex,imageNumber);
    end
end
% savePath = [savePath '\' imgPath];
% checkOwnDir(savePath);
% imageNumber = numel(allFolderList);
% for imgIndex = 3:imageNumber
%     imagePath = [dataSetPath '\' allFolderList(imgIndex).name];
%     I1=imread(imagePath);
%     I1 = imresize(I1,[512 512]);
%     Options.upright=true;
%     Options.tresh=0.0001;
%     Ipts1=OpenSurf(I1,Options);
%     D1 = reshape([Ipts1.descriptor],64,[]);
%     imageName = allFolderList(imgIndex).name(1:end-4);
%     descriptorSavePath = [savePath '\' imageName '-descriptor.txt'];
%     dlmwrite(descriptorSavePath,D1);
%     fprintf('Progress Bar %d/%d \n',imgIndex,imageNumber);
% end


fprintf('Program( preProcess_surf ) finished...\n');
end

function checkOwnDir(path)

    if ( exist(path) < 1 )|| ( isdir(path) ~= 1 )
        mkdir(path);
    end
end