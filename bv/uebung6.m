% 1.
indian = imread('indian.jpg');
indian_med_filtered1 = medfilt2(indian, [3 3]);
indian_med_filtered2 = medfilt2(indian, [2 2]);
figure (1), imshow(indian);
figure (2), imshow(indian_med_filtered1);
figure (3), imshow(indian_med_filtered2);

% 2.
vertical = rgb2gray(imread('verticallines.png'));
diagonal = rgb2gray(imread('diagonallines.png'));

vertical_med = medfilt2(vertical);
diagonal_med = medfilt2(diagonal);
v_med_plus_d_med = vertical_med + diagonal_med;
vplusd = vertical + diagonal;
vplusd_med = medfilt2(vplusd);

figure (4), imshow(diagonal);
figure (5), imshow(vertical);
figure (6), imshow(vplusd_med);
figure (7), imshow(v_med_plus_d_med);

% 3. 
swans = imread('swans_gray.jpg');
swans_gauss = imgaussfilt(swans, 3);
swans_1 = swans - swans_gauss;
swans_size = size(swans_1);
swans_lev1 = impyramid(swans_1, 'reduce');
swans_2 = swans_lev1 - imgaussfilt(swans_lev1, 3);
swans_lev1_size = size(swans_2);
swans_lev2 = impyramid(swans_2, 'reduce');
swans_3 = swans_lev2 - imgaussfilt(swans_lev2, 3);
swans_lev2_size = size(swans_3);
swans_lev3 = impyramid(swans_3, 'reduce');
swans_4 = swans_lev3 - imgaussfilt(swans_lev3, 3);
swans_lev3_size = size(swans_4);

figure (8), imshow(swans);
figure (9), imshow(swans_1);
figure (10), imshow(swans_2);
figure (11), imshow(swans_3);
figure (12), imshow(swans_4);
