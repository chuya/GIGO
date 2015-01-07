function [scoreVector] = getScoreFromSurf(imgPath)
clc;
addSurfPaht();
fprintf('Get Local feature Result Program Start...\n');
functionname='getScoreFromSurf.m';
nowDir = 'subfunction\localfunction';
functiondir=which(functionname);
functiondir=functiondir(1:end-( length(functionname)+length('\')+length(nowDir) ));

testDataPath = imgPath;
allTopicFloderList = dir(testDataPath);
topicList ={};
for i = 3:numel(allTopicFloderList)
    topicList(i-2) = cellstr(allTopicFloderList(i).name);
end
finalScoreList = [];

for topicIndex = 1:length(topicList)
    fprintf('Check (%s) KeyDescriptor\n',char(topicList(topicIndex)));
    descriptorKeyPointPath = [functiondir 'subfunction\temp\tempLocal\prefeature\' char(topicList(topicIndex)) 'key100Descriptor'];
    allKeyPointList = dir(descriptorKeyPointPath);
%     allTestDataList = dir(testDataPath);
    keyPointNumber = numel(allKeyPointList); 
%     testDataNumber = numel(allTestDataList); 

    scoreList =[];
    desKeyPoint = [];
    for index=3:keyPointNumber
        path = [descriptorKeyPointPath '\' allKeyPointList(index).name];
        descriptorMatrix = dlmread(path);
        desKeyPoint = cat(2,desKeyPoint,descriptorMatrix);
    end
    % if length(desKeyPoint) == 100
    %     fprintf('Correct!\n');
    % end
    for tempTopicIndex = 1:length(topicList)
        allTestDataList = dir([testDataPath '\' char(topicList(topicIndex))]);
        testDataNumber = numel(allTestDataList);
        fprintf('#%s\n',char(topicList(topicIndex)));
        for index=3:testDataNumber
            fprintf('#%d Data is processing.\n',(index-2) );
            testImagePath = [testDataPath '\' char(topicList(topicIndex)) '\' allTestDataList(index).name];
            I1=imread(testImagePath);
            I1 = imresize(I1,[512 512]);
            Options.upright=true;
            Options.tresh=0.0001;
            Ipts1=OpenSurf(I1,Options);
            D1 = reshape([Ipts1.descriptor],64,[]);
            pointsNumber = length(D1);
            tempScoreList = linspace(0,0,keyPointNumber-2);
            for i = 1:pointsNumber
                distance=sum((desKeyPoint-repmat(D1(:,i),[1 length(desKeyPoint)])).^2,1);
                for ind = 1:100
                    if(distance(ind) < 0.1)
                        tempScoreList(ind) = tempScoreList(ind) + 1;
                    end
                end
            end
            tempScoreList = double(tempScoreList) / pointsNumber ;
%             scoreList((index-2)) = {tempScoreList} ;
            scoreList = cat(1,scoreList,tempScoreList);
        end
    end
    finalScoreList = cat(2,finalScoreList,scoreList);
    fprintf('Check it!\n');
end
scoreVector = finalScoreList;

end


function addSurfPaht()
functionname='getScoreFromSurf.m';
nowDir = 'subfunction\localfunction';
functiondir=which(functionname);
functiondir=functiondir(1:end-( length(functionname)+length('\')+length(nowDir) ));
% functiondir = ./GIGO
addpath([functiondir '\lib\OpenSURF_version1c']);
end