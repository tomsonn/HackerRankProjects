function [ overlappingPtCloud, nonOverlappingPtCloud ] = splittingPointClouds( ptCloud, xLim, yLim, zLim )

x = ptCloud.Location(:,1);
y = ptCloud.Location(:,2);
z = ptCloud.Location(:,3);

idxOverlap = find((x >= xLim(1)) & (x <= xLim(2)) & (y >= yLim(1)) & (y <= yLim(2)) & (z >= zLim(1)) & (z <= zLim(2)));
              
overlapLoc = ptCloud.Location(idxOverlap,:);
overlapCol = ptCloud.Color(idxOverlap,:);
overlapNorm = ptCloud.Normal(idxOverlap,:);

nonOverlapLoc = ptCloud.Location;
nonOverlapCol = ptCloud.Color;
nonOverlapNorm = ptCloud.Normal;

nonOverlapLoc(idxOverlap,:) = [];
nonOverlapCol(idxOverlap,:) = [];
nonOverlapNorm(idxOverlap,:) = [];

overlappingPtCloud = pointCloud(overlapLoc, 'Color', overlapCol, 'Normal', overlapNorm);
nonOverlappingPtCloud = pointCloud(nonOverlapLoc, 'Color', nonOverlapCol, 'Normal', nonOverlapNorm);

end

