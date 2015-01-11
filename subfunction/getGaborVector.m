function feature = getGaborVector(image)

[targetGabor, ~] = gaborconvolve(rgb2gray(image), 4, 6, 3, 1.7, 0.65, 1.3, 0);

matrixSize = size(targetGabor(1));
feature = [];

blockSize = matrixSize(1)*matrixSize(2);

for gaborIndex = 1:numel(targetGabor)
    eachGabor = abs(targetGabor{gaborIndex});
    feature = cat(2, feature, mean2(eachGabor), std2(eachGabor));
end
feature = feature / blockSize;