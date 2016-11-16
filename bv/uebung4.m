% 2.
fingerprint = imread('fingerprint.png');
rec = strel('rectangle', [2 2]);
lin = strel('line', 4, 0);
opened = imopen(fingerprint, rec);
opened2 = imopen(opened, lin);
figure (1), imshow(fingerprint);
figure (2), imshow(opened);
figure (3), imshow(opened2);

% 3.
img = logical([1 0 0 0 1 1 1 0 1 1]);
se = strel('line', 3, 0);
dilated_img = imdilate(img, se);
eroded_img = imerode(img, se);
%figure (4), imshow(img);
%figure (5), imshow(dilated_img);
%figure (6), imshow(eroded_img);