function feature = textureFeatureExtraction(targetName, targetRoute, isNewFeature)
folderName = 'gabor/';
if exist(folderName, 'file') == 0 % not exists
    mkdir(folderName);
end
if exist(strcat(folderName, targetName), 'file') ~= 0 && isNewFeature == 0
    feature = dlmread(strcat(folderName, targetName));
%     feature = feature / sqrt(feature * feature');
%     dlmwrite(strcat(folderName, targetName), feature, 'delimiter', '\t');
else
    [targetGabor, ~] = gaborconvolve(rgb2gray(imread(targetRoute)), 4, 6, 3, 1.7, 0.65, 1.3, 0);

    matrixSize = size(targetGabor(1));
    feature = [];

    blockSize = matrixSize(1)*matrixSize(2);

    for gaborIndex = 1:numel(targetGabor)
        eachGabor = abs(targetGabor{gaborIndex});
        feature = cat(2, feature, mean2(eachGabor), std2(eachGabor));
    end
    
    feature = feature / blockSize;
    dlmwrite(strcat(folderName, targetName), feature, 'delimiter', '\t');
end