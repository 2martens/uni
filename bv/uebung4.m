% 3.
img = logical([1 0 0 0 1 1 1 0 1 1]);
se = strel('line', 3, 0);
dilated_img = imdilate(img, se);
eroded_img = imerode(img, se);
figure (1), imshow(img);
figure (2), imshow(dilated_img);
figure (3), imshow(eroded_img);