function vectors = getGabor(fileList, isNewFeature)

vectors = [];
fileName = 'gaborVectors';

if exist(fileName, 'file') ~= 0 && isNewFeature == 0
    vectors = dlmread(fileName);

else
    for fileIndex = 1:numel(fileList)/2
        [targetGabor, ~] = gaborconvolve(rgb2gray(imread(fileList{fileIndex,1})), 4, 6, 3, 1.7, 0.65, 1.3, 0);

        matrixSize = size(targetGabor(1));
        feature = [];

        blockSize = matrixSize(1)*matrixSize(2);

        for gaborIndex = 1:numel(targetGabor)
            eachGabor = abs(targetGabor{gaborIndex});
            feature = cat(2, feature, mean2(eachGabor), std2(eachGabor));
        end

        feature = feature / blockSize;
        vectors = cat(1, vectors, feature);
    end

    dlmwrite(fileName, vectors, 'delimiter', '\t');
    
end


