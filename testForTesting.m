function testForTesting()
%     topicList={'bottle' 'can' 'glass' 'pak'};

    fprintf('Test Start...\n');
functionname='testForTesting.m';

functiondir=which(functionname);
functiondir=functiondir(1:end-( length(functionname) ));
allTopicFloderList = dir([functiondir 'dataset']);
topicList ={};
for i = 3:numel(allTopicFloderList)
    topicList(i-2) = cellstr(allTopicFloderList(i).name);
end
    numList=linspace(0,0,size(topicList,2));
for topicIndex = 1:length(topicList)
    topicDir = [[functiondir 'dataset'] '\' char(topicList(topicIndex))];
    imageDir = dir(topicDir);
    for imageIndex =3:numel(imageDir)
        result = testingV2([topicDir '\' imageDir(imageIndex).name]);
        ind = ismember(topicList,result);
        numList(ind) = numList(ind)+1;
    end
end
numList
end