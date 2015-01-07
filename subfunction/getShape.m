function vectors = getShape(fileList, depth)
vectors = [];
for fileIndex = 1:numel(fileList)/2
    vectors = cat(1, vectors, hierarchicalCentroid( rgb2gray(imread(fileList{fileIndex,1})), depth, 0)); %the third parameter determines to plot or not
end

vectors = (vectors + 1) / 2;    % normalize
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
dlmwrite('shapeVectors', vectors, 'delimiter', '\t');