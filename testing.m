function testing(img)
    addpath('subfunction', 'lib');
    
    feature1 =  getShapeVector(img);
    feature2 =  getGaborVector(img);
    feature3 =  getLocalTest(img,50);
    vectors = fuse(false, feature1, feature2, feature3);
    
end