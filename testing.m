function result = testing(img)
    addpath('subfunction', 'lib');
    I = imread(img);
    feature1 =  getShapeVector(I);
    feature2 =  getGaborVector(I);
    feature3 =  getLocalTest(img,50);
    vectors = fuse(false, feature1, feature2, feature3);
    result = calFinalResult(vectors );
    disp(result);
end