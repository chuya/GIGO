function [vectors] = getLocalTest(img,keyPointNumber)
    keyPointString = num2str(keyPointNumber);
    functionname='getLocalTest.m';
    nowDir = 'subfunction';
    functiondir=which(functionname);
    functiondir=functiondir(1:end-( length(functionname)+length('\')+length(nowDir) ));
    addpath([functiondir '\' nowDir '\localfunction']);
    vectors = getScoreFromSurfTest(img,keyPointString);
end