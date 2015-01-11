function findKeyDescriptor(topic)

fprintf('Find Local KeyDescriptor Points Start...\n');
functionname='findKeyDescriptor.m';
nowDir = 'subfunction\localfunction';
functiondir=which(functionname);
functiondir=functiondir(1:end-( length(functionname)+length('\')+length(nowDir) ));
% find our fetch feature from preProcess function.
descriptorPath = [functiondir 'subfunction\temp\tempLocal\prefeature\' topic];

allFolderList = dir(descriptorPath);
imageNumber = numel(allFolderList);
field1 = 'descriptor';  value1 = [];
field2 = 'imgCompare';  value2 = {};
field3 = 'imgDesNo';  value3 = [];
% field4 = 'numberMatch'; value4 = 0;
classStruct = struct(field1,value1,field2,value2,field3,value3);
                                                                                                                                                                    % number1=0;
                                                                                                                                                                    % number2=0;
                                                                                                                                                                    % number0=0;
                                                                                                                                                                    % number3=0;

% var to save already select descriptor on Image I
alreadySelected ={};
selectedTag = [];
% already selecte number
selectIndex = 0;
% var to save now class tag
nowClass = 1;
numberMatch = [];
errIndex = 0 ;
% pair difference
% difference_list = [];
% targetDifferenceImageID1 = [];
% targetDifferenceDescriptorID1 = [];
% targetDifferenceImageID2 = [];
% targetDifferenceDescriptorID2 = [];
differenceSelectedIndex = 0 ;
for imgIndex = 3:imageNumber
%   get one image(top image) for our system
    path = [descriptorPath '\' allFolderList(imgIndex).name];
    descriptorMatrix = dlmread(path);
%     compare other image Descriptor , find best match
    for targetImageIndex = 3:imageNumber
        if(imgIndex == targetImageIndex)
            continue
        end
%       get one image for target image for our system
            path = [descriptorPath '\' allFolderList(targetImageIndex).name];
            targetDescriptorMatrix = dlmread(path);
            for i=1:length(descriptorMatrix)
%               get descriptor from top image
                distance=sum((targetDescriptorMatrix-repmat(descriptorMatrix(:,i),[1 length(targetDescriptorMatrix)])).^2,1);
                                                                                                                                %                 if( min(distance) > 0.3 )
                                                                                                                                %                     number3 = number3 + 1;
                                                                                                                                %                 elseif ( min(distance) > 0.2 && min(distance) < 0.3)
                                                                                                                                %                         number2 = number2 + 1;
                                                                                                                                %                 elseif ( min(distance) > 0.1 && min(distance) < 0.2)
                                                                                                                                %                      number1 = number1 + 1;
                                                                                                                                %                 else
                                                                                                                                %                     number0 = number0 + 1;
                                                                                                                                %                 end
%                 [err,pos] = min(distance);
                nowTarget = [int2str(imgIndex) '-' int2str(i)];
                for dIndex = 1:length(distance)
                    if(distance(dIndex) < 0.1)
                        if( sum(ismember(alreadySelected,nowTarget)) < 1 )
                            differenceSelectedIndex = differenceSelectedIndex+1;
                            alreadySelected(differenceSelectedIndex) = cellstr(nowTarget);
                            classStruct(differenceSelectedIndex).descriptor = descriptorMatrix(:,i);
                            classStruct(differenceSelectedIndex).imgCompare(1) = cellstr([int2str(targetImageIndex) '-' int2str(dIndex)]);
                            numberMatch(differenceSelectedIndex) = 1;
                        else
                            ind = ismember(alreadySelected,nowTarget);
                            numberMatch(ind) =  numberMatch(ind) + 1;
%                             L = length(classStruct(ind).imgCompare);
                            classStruct(ind).imgCompare(numberMatch(ind)) = cellstr([int2str(targetImageIndex) '-' int2str(dIndex)]);
         
                        end
                    end
                end
%                 fprintf('Progress %d - %d (%d \n',targetImageIndex,i,nowClass);
            end
    end
    fprintf('Progress Bar %d/%d \n',imgIndex,imageNumber);
end
[number, matchIndex]=sort(numberMatch,'descend');
descriptorSavePath = [descriptorPath 'key50Descriptor\'];
checkOwnDir(descriptorSavePath);
maxKeyPoint = 50;
nowGetKeyPoint = 0 ;
nowMatchIndex = 1;
alreadyPick={};
realkeyPoint={};

while (nowGetKeyPoint < maxKeyPoint)&& (nowMatchIndex <= length(matchIndex))
    nowInd = matchIndex(nowMatchIndex);
    if( sum(ismember(alreadyPick,alreadySelected(nowInd))) < 1 )
        imgCompare = classStruct(nowInd).imgCompare;
        N = sum(ismember(alreadyPick,imgCompare));


        if( N/number(nowMatchIndex) < 0.5 )
            alreadyPick=[alreadyPick alreadySelected(nowInd) imgCompare];
            realkeyPoint=[realkeyPoint alreadySelected(nowInd)];
            alreadyPick = unique(alreadyPick);
            nowGetKeyPoint = nowGetKeyPoint + 1;
        end
        
    end
    nowMatchIndex = nowMatchIndex + 1;
end
for i=1:nowGetKeyPoint
%     
    tempName = realkeyPoint(i);
    ind = ismember(alreadySelected,tempName);
    finalDes = classStruct(ind).descriptor;
    descriptorKeySavePath = [descriptorSavePath 'key-' int2str(i) '.txt'];
    dlmwrite(descriptorKeySavePath,finalDes);
%     fprintf('#%d -> %s \n',i,char(tempName));
end
fprintf('Find Local KeyDescriptor Points Finished...\n');
end



function checkOwnDir(path)

    if ( exist(path) < 1 )|| ( isdir(path) ~= 1 )
        mkdir(path);
    end
end