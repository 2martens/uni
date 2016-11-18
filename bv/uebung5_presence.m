text = imread('text.png');
%figure, imshow(text);
[L, components] = bwlabel(text, 8);
cc = bwconncomp(text);
pixelIDs = cc.PixelIdxList;
[bin, index] = max(cellfun(@numel, pixelIDs));
text(pixelIDs{index}) = 0;
%figure, imshow(text);

%----------
img = imread('coins.png');
filter = ones(3, 3) / 9;
filter2 = ones(5, 5) / 25;
imgbox = imboxfilt(img);
img2 = imfilter(img, filter);
img3 = imfilter(img, filter2);

%----------
cameraman = imread('cameraman.tif');
pad1 = padarray(cameraman, [50 50]);
pad2 = padarray(cameraman, [50 50], 'circular');
pad3 = padarray(cameraman, [50 50], 'replicate');
pad4 = padarray(cameraman, [50 50], 'symmetric');
figure('Name', 'start'), imshow(cameraman);
figure('Name', 'nullen'), imshow(pad1);
figure('Name', 'circular'), imshow(pad2);
figure('Name', 'replicate'), imshow(pad3);
figure('Name', 'symmetric'), imshow(pad4);
boxfilter = ones(3, 3) / 9;
boxfiltered = imfilter(cameraman, boxfilter, 'replicate');
figure('Name', 'boxfiltered'), imshow(boxfiltered);
boxgaussfilter = ones(5, 5)/25;
boxgaussfiltered1 = imfilter(cameraman, boxgaussfilter, 'replicate');
gaussfiltered = imgaussfilt(cameraman, 1);
figure('Name', 'gaussfiltered'), imshow(gaussfiltered);
figure('Name', 'boxgaussfiltered'), imshow(boxgaussfiltered1);
