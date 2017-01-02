% 1.
I_1 = rgb2gray(imread('laptop-1.JPG'));
I_1_lighted = rgb2gray(imread('laptop-1l.JPG'));
I_1_1 = rgb2gray(imread('laptop-1-1.JPG'));
I_2 = rgb2gray(imread('laptop-2.JPG'));
I_2_lighted = rgb2gray(imread('laptop-2l.JPG'));

points_1 = detectHarrisFeatures(I_1);
points_1_lighted = detectHarrisFeatures(I_1_lighted);
points_1_1 = detectHarrisFeatures(I_1_1);
points_2 = detectHarrisFeatures(I_2);
points_2_lighted = detectHarrisFeatures(I_2_lighted);

[features1,valid_points1] = extractFeatures(I_1, points_1);
[features2,valid_points2] = extractFeatures(I_1_lighted, points_1_lighted);
[features3,valid_points3] = extractFeatures(I_1_1, points_1_1);
[features4,valid_points4] = extractFeatures(I_2, points_2);
[features5,valid_points5] = extractFeatures(I_2_lighted, points_2_lighted);

% compare almost identical images (same spot)
indexPairs1 = matchFeatures(features1, features3);
matchedPoints1_1 = valid_points1(indexPairs1(:,1),:);
matchedPoints1_3 = valid_points3(indexPairs1(:,2),:);
figure; showMatchedFeatures(I_1, I_1_1, matchedPoints1_1, matchedPoints1_3);

% compare two different viewpoints, same lighting conditions
indexPairs2 = matchFeatures(features1, features4);
matchedPoints2_1 = valid_points1(indexPairs2(:,1),:);
matchedPoints2_4 = valid_points4(indexPairs2(:,2),:);
figure; showMatchedFeatures(I_1, I_2, matchedPoints2_1, matchedPoints2_4);

% compare same viewpoint, different lighting
indexPairs3 = matchFeatures(features1, features2);
matchedPoints3_1 = valid_points1(indexPairs3(:,1),:);
matchedPoints3_2 = valid_points2(indexPairs3(:,2),:);
figure; showMatchedFeatures(I_1, I_1_lighted, matchedPoints3_1, matchedPoints3_2);

% compare different viewpoints, different lighting
indexPairs4 = matchFeatures(features1, features5);
matchedPoints4_1 = valid_points1(indexPairs4(:,1),:);
matchedPoints4_5 = valid_points5(indexPairs4(:,2),:);
figure; showMatchedFeatures(I_1, I_2_lighted, matchedPoints4_1, matchedPoints4_5);