function wekaformat(data,tags)
    savePath = './temp/wekaformat/';
    checkOwnDir(savePath);
    filename = [savePath 'wekaData.arff'];
    fileID = fopen(filename,'w');
    fprintf(fileID,'@relation GIGO\n\n');
    [dataSize,featureSize] = size(data);
    for i = 1:featureSize
        attributeName = ['f' int2str(i)];
        fprintf(fileID,'@attribute %s numeric\n',attributeName);
    end
    tag = tags(:,2);
    tag = unique(tag);
    topicNumber = length(tag);
    topicName = [];
    for i= 1:topicNumber
        topicName = [topicName char(tag(i)) ','];
    end
    topicName = ['{' topicName(1:end-1) '}'];
    fprintf(fileID,'@attribute tag %s\n\n',topicName);
    fprintf(fileID,'@data\n');
    
    for dataIndex = 1:dataSize
        line =[];
        for featureIndex = 1:featureSize
            line = [line num2str(data(dataIndex,featureIndex)) ','];
        end
        line = [line char(tags(dataIndex,2))];
        fprintf(fileID,'%s\n',line);
    end
    
    fclose(fileID);
end
function checkOwnDir(path)

    if ( exist(path) < 1 )|| ( isdir(path) ~= 1 )
        mkdir(path);
    end
end