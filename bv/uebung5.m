% 1.
% First the connected components are determined. Then an array with the
% color values for the gray colors is defined (possible value range 0-255).
% The distance of 20 between each color is chosen to make the difference
% visible for the human eye.
% Afterwards the 8 values are assigned to the pixels of the 8 components.
crosses = imread('crosses.gif');
figure (1), imshow(logical(crosses));
cc = bwconncomp(crosses);
pixelIDs = cc.PixelIdxList;
colors = [60, 80, 100, 120, 140, 160, 180, 200];
for i = 1 : 8
    crosses(pixelIDs{i}) = colors(i);
end
figure (2), imshow(crosses);

% 2.
dots = imread('littledots.gif');
dots_bw = dots;
% The threshold 50 is determined by looking at imhist(dots).
% The background is lighter and covers most of the image and
% it therefore is represented by the largest spike.
% The cells are a bit darker and the threshold is therefore on the direct 
% left of the spike.
%---
% The cells get the value 1, because the bwconncomp function views black as
% background and white as objects. Lastly the number of objects is
% extracted from the cc_dots struct.
for i = 1 : numel(dots_bw)
    if dots_bw(i) < 49
        dots_bw(i) = 1;
    else
        dots_bw(i) = 0;
    end
end
dots_bw_l = logical(dots_bw);
cc_dots = bwconncomp(dots_bw);
numObjects_dots = cc_dots.NumObjects;
figure (3), imshow(dots);
figure (4), imshow(dots_bw_l);

% 3. 
turkeys = imread('turkeys.jpg');
turkeys_bw = turkeys;
% The threshold 48 is determined by looking at imhist(turkeys).
% There are many spikes and the turkeys have different color values
% belonging to them. The larger part of them is on the darker side. The
% exact threshold was determined by try and error to see which value
% provided the best results. Since there was no single threshold in which
% only the turkeys remained, some morphological operations were necessary.
% Once every white dot not belonging to the turkeys was removed, one large
% dilate operation was necessary to connect the remaining dots in a way
% that represents the turkeys.
% ---
% The last step is to apply bwlabel to the prepared bw image.
for i = 1 : numel(turkeys_bw)
    if turkeys_bw(i) == 48
        turkeys_bw(i) = 255;
    else
        turkeys_bw(i) = 0;
    end
end
se = strel('line', 3, 90);
se_2 = strel('disk', 14);
se_3 = strel('square', 3);
se_4 = strel('line', 3, 0);
turkeys_opened = imopen(turkeys_bw, se);
t_opened2 = imopen(turkeys_opened, se_4);
t_opened3 = imopen(t_opened2, se_3);
t_dilated = imdilate(t_opened3, se_2);
[labels_turkeys, num_turkeys] = bwlabel(t_dilated);
figure (5), imshow(turkeys_bw);
figure (6), imshow(t_dilated);

% 4.
% I expect the two results to be equal. f shall be the box filter. g shall
% be the result from convolving f with itself. h shall be the result from
% convolving g with the image patch (i). Based on the associativity of
% convolution j = (i * f) * f should be equal to i * (f * f). Combined with 
% the commutativity j should be equal to (f * f) * i which is h.