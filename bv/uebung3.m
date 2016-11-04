% histogram distances
rice = imread('rice.png');
cam = imread('cameraman.tif');
rice_sp = imnoise(rice, 'salt & pepper', 0.02);
rice_g = imnoise(rice, 'gaussian');
[h1,] = imhist(rice);
[h2,] = imhist(cam);
[h3,] = imhist(rice_sp);
[h4,] = imhist(rice_g);
dist_rice_camera = pdist2(h1', h2');
dist_rice_rice_sp = pdist2(h1', h3');
dist_rice_rice_g = pdist2(h1', h4');
distman_rice_camera = pdist2(h1', h2', 'cityblock');
distman_rice_rice_sp = pdist2(h1', h3', 'cityblock');
distman_rice_rice_g = pdist2(h1', h4', 'cityblock');
% colour spaces
peppers = imread('peppers.png');
peppers_gray = rgb2gray(peppers);
peppers_hsv = rgb2hsv(peppers);
peppers_lab = rgb2lab(peppers);
%figure (1), imhist(peppers(:, :, 1));
%figure (2), imhist(peppers(:, :, 2));
%figure (3), imhist(peppers(:, :, 3));
%figure (4), imshow(peppers_hsv);
%figure (5), imshow(peppers_lab);
%figure (6), imshow(peppers);
% binary images
coins = imread('coins.png');
coins_bw = coins;
for i = 1 : numel(coins_bw)
    if coins_bw(i) < 90
        coins_bw(i) = 0;
    else
        coins_bw(i) = 1;
    end
end
coins_bw_l = logical(coins_bw);
level = graythresh(coins);
coins_bw_mat = imbinarize(coins, level);
figure (1), imhist(coins);
figure (2), imshow(coins_bw_l);
figure (3), imshow(coins_bw_mat);
