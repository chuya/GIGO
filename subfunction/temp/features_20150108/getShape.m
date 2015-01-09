function vectors = getShape(fileList, depth, isNewFeature)

vectors = [];
fileName = 'shapeVectors';

if exist(fileName, 'file') ~= 0 && isNewFeature == 0
    vectors = dlmread(fileName);
else
    for fileIndex = 1:numel(fileList)/2
        tempImage = rgb2gray(imread(fileList{fileIndex,1});
        [row,column] = size(tempImage);
        if row < column
            tempImage = rot90(tempImage);
        end
        vectors = cat(1, vectors, hierarchicalCentroid( tempImage , depth, 0)); %the third parameter determines to plot or not
    end

    vectors = (vectors + 1) / 2;    % normalize
    dlmwrite(fileName, vectors, 'delimiter', '\t');
end
% if flag == true || ~exist(ansFolderName, 'file')% not exists  % need to recompute mean and std 
%     [numOfVectors, numOfFeatures] = size(vectors);
%     mean = mean(vectors, 1);
%     std = std(vectors, 0, 1);
%     
%         
% end

% [rows, columns] = size(vectors)
% for i = 1:rows
%     for j = i+1:rows
%         disp([i j sum((vectors(i,:) - vectors(j,:)) .^ 2)]);
%     end
% end
