% 2.
fingerprint = imread('fingerprint.png');
rec0 = strel('rectangle', [2, 2]);
lin1 = strel('line', 3, 0);
disk = strel('disk', 1, 4);
rec1 = strel('rectangle', [3 5]);
rec2 = strel('rectangle', [2, 2]);
opened1 = imopen(fingerprint, lin1);
opened2 = imopen(opened1, rec0);
opened3 = imopen(opened2, disk);
figure (1), imshow(fingerprint);
figure (2), imshow(opened1);
figure (3), imshow(opened2);
figure (4), imshow(opened3);

% 3.
img = logical([1 0 0 0 1 1 1 0 1 1]);
se = strel('line', 3, 0);
dilated_img = imdilate(img, se);
eroded_img = imerode(img, se);
%figure (4), imshow(img);
%figure (5), imshow(dilated_img);
%figure (6), imshow(eroded_img);