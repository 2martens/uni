% 4.
coins = imread('coins.png');
edge_01 = edge(coins, 'Canny', 0.1);
edge_02 = edge(coins, 'Canny', 0.2);
edge_05 = edge(coins, 'Canny', 0.5);
edge_075 = edge(coins, 'Canny', 0.75);
edge_08 = edge(coins, 'Canny', 0.8);
subplot(1, 5, 1);
imshow(edge_01);
subplot(1, 5, 2);
imshow(edge_02);
subplot(1, 5, 3);
imshow(edge_05);
subplot(1, 5, 4);
imshow(edge_075);
subplot(1, 5, 5);
imshow(edge_08);

% With the threshold 0.5 only the outer edges of the
% coins are still detected. With higher thresholds some
% coins disappear completely while 0.1 shows almost every
% line - including those on the coins.

% 5.
