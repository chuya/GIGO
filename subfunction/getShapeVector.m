function feature = getShapeVector(image)

tempImage = rgb2gray(image);
[row,column] = size(tempImage);
if row < column
    tempImage = imrotate(tempImage,-90);
end
feature = hierarchicalCentroid( tempImage , 6, 0)