function [ ptCloud ] = mergingOverlappingPtClouds( model_1_ptCloud, model_2_ptCloud )

if length(model_1_ptCloud.Location) > length(model_2_ptCloud.Location)
    biggerPtCloud = copy(model_1_ptCloud);
    smallerPtCloud = copy(model_2_ptCloud);
else
    biggerPtCloud = copy(model_2_ptCloud);
    smallerPtCloud = copy(model_1_ptCloud);
end 

smallerLoc = smallerPtCloud.Location;
smallerCol = smallerPtCloud.Color;
smallerNorm = smallerPtCloud.Normal;

biggerLoc = biggerPtCloud.Location;
biggerCol = biggerPtCloud.Color;
biggerNorm = biggerPtCloud.Normal;

indices = zeros(1, length(smallerLoc));

for i = 1:length(smallerPtCloud.Location)
    [index, distance] = findNearestNeighbors(biggerPtCloud, smallerLoc(i,:), 1);
    
    smallerLoc(i,:) = (smallerLoc(i,:) + biggerLoc(index,:))./2;
    smallerCol(i,:) = (smallerCol(i,:) + biggerCol(index,:))./2;
    smallerNorm(i,:) = (smallerNorm(i,:) + biggerNorm(index,:))./2;
    
    indices(i) = index;
end

sort(indices);

for i = 1:length(indices)
    if indices(i) == 0
        indices(i) = [];
    else 
        biggerLoc(indices(i),:) = [-1 -1 -1];
    end 
end

numberOfDeletion = 0;

for i = 1:length(biggerLoc) + numberOfDeletion
    if biggerLoc(i - numberOfDeletion,1) == -1
        biggerLoc(i - numberOfDeletion,:) = [];
        biggerCol(i - numberOfDeletion,:) = [];
        biggerNorm(i - numberOfDeletion,:) = [];
        numberOfDeletion = numberOfDeletion + 1;
    end
end

ptCloud = pointCloud([smallerLoc; biggerLoc], 'Color', [smallerCol; biggerCol], 'Normal', [smallerNorm; biggerNorm]);
end

