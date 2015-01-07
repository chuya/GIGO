function [vectors] = getLocal(imgs,preProcessFlag,isNewFeature)
    fileName = 'localVectors';

    if exist(fileName, 'file') ~= 0 && isNewFeature == 0
        vectors = dlmread(fileName);

    else
        % add localfunction path , some function put on here.
        fprintf('Get Local feature Program Start...\n');
        functionname='getLocal.m';
        nowDir = 'subfunction';
        functiondir=which(functionname);
        functiondir=functiondir(1:end-( length(functionname)+length('\')+length(nowDir) ));
        addpath([functiondir '\' nowDir '\localfunction']);
        % if flag == 0, represent dataset doesn't change, so no need to do
        % preProcess again
        if(preProcessFlag == 0)
            %  get local feature score
            %  arg:imgs is dataset path where save image.
            %  return:vectors is n*m vectors about local feature. n is number
            %  of image, m is key points number (default = 100)
            vectors = getScoreFromSurf(imgs);
        % if flag == 1, represent dataset change, do preProcess again
        elseif(preProcessFlag ==1)
            %  preProcess for get local descriptor from all image, so it will cost some time. 
            %  arg:imgs is dataset path where save image.       
            preProcess_surf(imgs);
            %  get all topic key points about local descriptor       
            dataSetPath = imgPath;
            allTopicFloderList = dir(dataSetPath);
            for i = 3:numel(allTopicFloderList)
                findKeyDescriptor(allTopicFloderList(i).name);
            end
            vectors = getScoreFromSurf(imgs);
        end
        dlmwrite(fileName, vectors, 'delimiter', '\t');
    end
    fprintf('Get Local feature Program finished...\n');
end