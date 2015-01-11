function [topicList,weightsList]=getWeights(featureSize)
fprintf('Find Feature Weights...\n');
folderPath = 'weights';
functionname='getWeights.m';
% nowDir = 'subfunction';
functiondir=which(functionname);
functiondir=functiondir(1:end-( length(functionname) ));
% datasetPath = [functiondir 'dataset'];
folderPath = [functiondir folderPath];
name1 ='typeA';val1='';
name2 = 'typeB';val2='';
name3 = 'weights';val3=[];
weightsList = struct(name1,val1,name2,val2,name3,val3);

topicDir = dir(folderPath);
topicList = {};

topicNum = numel(topicDir);
weigthsListNum = 0 ;
topicListNumber = 0;
for i =3:topicNum
        topicName = topicDir(i).name;
        topicName = strsplit(topicName,'_');
        weigthsListNum = weigthsListNum + 1;
        weightsList(weigthsListNum).typeA = char(topicName(1));
        weightsList(weigthsListNum).typeB = char(topicName(2));
        topicListNumber = topicListNumber + 1;
        topicList(topicListNumber) = topicName(1);
        topicListNumber = topicListNumber + 1;
        topicList(topicListNumber) = topicName(2);
end
for i = 1:weigthsListNum
    fid = fopen([folderPath '\' weightsList(i).typeA '_' weightsList(i).typeB]);
    tline = fgetl(fid);
    weightsList(i).weights = linspace(0,0,featureSize);
    while ischar(tline)
        myLine = strsplit(tline,'\t');
        featureNo = (char(myLine(1)));
        featureNo = str2double(featureNo(2:end));
        featureW = str2double( char(myLine(2)) );
        weightsList(i).weights(featureNo) = featureW;
        tline = fgetl(fid);
    end
end
fprintf('Find Feature Weights finished...\n');
end