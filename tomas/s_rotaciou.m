clc
close all
clear

%% Create question dialog box 
crtQuestBox();

%% Create dialog box to gather user input
answer = gatherInput();

file_1 = answer{1};
file_2 = answer{2};
file_out = answer{3};

ptCloud_1 = pcread(file_1);
ptCloud_2 = pcread(file_2);

clear file_1 file_2

%% Measure performance
tic 

%% removing black points (1)
[ model_1_loc, model_1_col, model_1_norm ] = removeBlackPoints(ptCloud_1.Location, ptCloud_1.Color, ptCloud_1.Normal);

ptCloud_1 = pointCloud(model_1_loc,'Color',model_1_col,'Normal',model_1_norm);

%% removing black points (2)
[ model_2_loc, model_2_col, model_2_norm ] = removeBlackPoints(ptCloud_2.Location, ptCloud_2.Color, ptCloud_2.Normal);

ptCloud_2 = pointCloud(model_2_loc,'Color',model_2_col,'Normal',model_2_norm);

%% run only if models dont't fit
%% dat do funkcie

%{
if strcmp(choice, 'Exit program')
    quit;
elseif strcmp(choice, 'No')
    figure(1);
    pcshow(model_1);

    f = msgbox('Hold "Alt" and choose same 4 points on both graphs in the same order. Then hit "Enter".');
    waitfor(f);
    clear f

    %% Initialize data cursor object
    %% prepisat do fukncie
    pause(5);
    cursorobj = datacursormode(figure(1));
    cursorobj.SnapToDataVertex = 'on'; % Snap to our plotted data, on by default

    while ~waitforbuttonpress 
        % waitforbuttonpress returns 0 with click, 1 with key press
        % Does not trigger on ctrl, shift, alt, caps lock, num lock, or scroll lock
        cursorobj.Enable = 'on'; % Turn on the data cursor, hold alt to select multiple points
    end
    cursorobj.Enable = 'off';

    mypoints1 = getCursorInfo(cursorobj);
    close figure 1;

    %%
    figure(2);
    pcshow(model_2);

    %% Initialize data cursor object
    %% dat do funkcie
    pause(5);
    cursorobj = datacursormode(figure(2));
    cursorobj.SnapToDataVertex = 'on'; % Snap to our plotted data, on by default

    while ~waitforbuttonpress 
        % waitforbuttonpress returns 0 with click, 1 with key press
        % Does not trigger on ctrl, shift, alt, caps lock, num lock, or scroll lock
        cursorobj.Enable = 'on'; % Turn on the data cursor, hold alt to select multiple points
    end
    cursorobj.Enable = 'off';

    mypoints2 = getCursorInfo(cursorobj);
    close figure 2;

    %% processing values
    scan_1_positions = [mypoints1(1).Position;
                        mypoints1(2).Position;
                        mypoints1(3).Position;
                        mypoints1(4).Position];
    scan_2_positions = [mypoints2(1).Position;
                        mypoints2(2).Position;
                        mypoints2(3).Position;
                        mypoints2(4).Position];
    difference_XYZ = scan_1_positions - scan_2_positions;
    %% selecting parts
    scan1_Location = model_1.Location;
    scan1_Color = model_1.Color;
    scan1_Normal = model_1.Normal;
    scan1_Intensity = model_1.Intensity;

    %% rotacia
    new_loc1 = scan_1_positions - scan_1_positions(1,:); % posunutie bodu 1 do pociatku
    new_loc2 = scan_2_positions - scan_2_positions(1,:); % posunutie bodu 1 do pociatku
    
    new_dif1 = sqrt(sum((new_loc1(:,[1,2]).^2),2));
    new_dif2 = sqrt(sum((new_loc2(:,[1,2]).^2),2));
    new_dif = new_loc1 - new_loc2;
    new_dif = sqrt(sum((new_dif(:,[1,2]).^2),2));
    angle = (new_dif1.^2 + new_dif2.^2 - new_dif.^2) ./ (2 * (new_dif1 .* new_dif2));
    angle(1) = [];
    radian = acos(angle);
    theta = sum(radian)/length(radian);
    
    scan1_Location = scan1_Location - scan_1_positions(1,:); % posunutie bodu 1 do pociatku
    
    X = scan1_Location(:,1)*cos(theta) - scan1_Location(:,2)*sin(theta);
    Y = scan1_Location(:,1)*sin(theta) + scan1_Location(:,2)*cos(theta);
    Z = scan1_Location(:,3);
    
    scan1_finalLoc = [X Y Z];
    %% posunutie
    scan1_finLocation = scan1_finalLoc + scan_2_positions(1,:);
    
    clear model_1

    model_1 = pointCloud(scan1_finLocation,'Color',scan1_Color,'Normal',scan1_Normal,'Intensity',scan1_Intensity);
    clear median scan1_Location scan1_Color scan1_Normal scan1_Intensity
end
%}


%% Draw each graph
figure(1)
pcshow(ptCloud_1);
hold on
figure(2)
pcshow(ptCloud_2);

%% Intersections
xLim = sort([ptCloud_1.XLimits ptCloud_2.XLimits]);
yLim = sort([ptCloud_1.YLimits ptCloud_2.YLimits]);
zLim = sort([ptCloud_1.ZLimits ptCloud_2.ZLimits]);

xLim([1, 4]) = [];
yLim([1, 4]) = [];
zLim([1, 4]) = [];

%% split model_1 into two point clouds
[model_1_overlappingPtCloud, model_1_nonOverlappingPtCloud] = splittingPointClouds(ptCloud_1, xLim, yLim, zLim);

%% split model_2 into two point clouds
[model_2_overlappingPtCloud, model_2_nonOverlappingPtCloud] = splittingPointClouds(ptCloud_2, xLim, yLim, zLim);

%% Merging overlapping pointClouds

overlapPtCloud = mergingOverlappingPtClouds(model_1_overlappingPtCloud, model_2_overlappingPtCloud);

%% final point cloud
mergedLoc = [model_1_nonOverlappingPtCloud.Location; overlapPtCloud.Location; model_2_nonOverlappingPtCloud.Location];
mergedCol = [model_1_nonOverlappingPtCloud.Color; overlapPtCloud.Color; model_2_nonOverlappingPtCloud.Color];
mergedNorm = [model_1_nonOverlappingPtCloud.Normal; overlapPtCloud.Normal; model_2_nonOverlappingPtCloud.Normal];

finalModel = pointCloud(mergedLoc,'Color',mergedCol,'Normal',mergedNorm);
pcwrite(finalModel,file_out);
clear model_1 model_2 model_1_loc model_1_col model_1_nor model_1_int model_2_loc model_2_col model_2_nor model_2_int model_1A_loc model_1A_col model_1A_nor model_2A_loc model_2A_col model_2A_nor
%%
%p = double(model_loc);
%save('model.mat','p');
%save('modelCol.mat','model_col');

figure(3)
pcshow(finalModel);
%% Run program function for triangulation
%[t]=MyCrustOpen(p);
%% plot the output triangulation
%figure(3)
%trisurf(t,p(:,1),p(:,2),p(:,3),'facecolor','c','edgecolor','b')%plot della superficie
toc