% 1.
% Let's take two sequences f(x) = {0 -> 1, 1 -> 1, 2 -> 100} and
% g(x) = { 0 -> 2, 1 -> 3, 2 -> 0}. The sum of both is 
% h(x) = {0 -> 3, 1 -> 4, 2 -> 100}. The mean values are: mean(f) = 34,
% mean(g) = 5/3, mean(h) = 107/3 = 34 + 5/3. The linearity mean(f) +
% mean(g) = mean(f + g) is satisfied. The median values are: median(f) = 1,
% median(g) = 2, median(h) = 4. But median(f) + median(g) != median(f + g).
% Therefore the linearity isn't satisfied which means that median is
% non-linear.

% 2.
peppers = rgb2gray(imread('peppers.png'));
peppers_1 = imnoise(peppers, 'salt & pepper', 0.02);
peppers_2 = imgaussfilt(peppers);
peppers_3 = imnoise(peppers, 'salt & pepper', 0.6);
peppers_4 = imnoise(peppers, 'poisson');
peppers_5 = imgaussfilt(peppers, 3);

peppers_fft = fftshift(log(abs(fft2(peppers))));
peppers1_fft = fftshift(log(abs(fft2(peppers_1))));
peppers2_fft = fftshift(log(abs(fft2(peppers_2))));
peppers3_fft = fftshift(log(abs(fft2(peppers_3))));
peppers4_fft = fftshift(log(abs(fft2(peppers_4))));
peppers5_fft = fftshift(log(abs(fft2(peppers_5))));

%figure (1), imshow(peppers_fft, []);
%figure (2), imshow(peppers1_fft, []);
%figure (3), imshow(peppers2_fft, []);
%figure (4), imshow(peppers3_fft, []);
%figure (5), imshow(peppers4_fft, []);
%figure (6), imshow(peppers5_fft, []);

%3.
low_pass = fspecial('gaussian', [3 3], 1);
low_pass_fft = fft2(low_pass, size(peppers, 1), size(peppers, 2));
high_pass = fspecial('laplacian', 0.2);
high_pass_fft = fft2(high_pass, size(peppers, 1), size(peppers, 2));
peppers_fft2 = fft2(peppers);
peppers_filtered_low_fft = peppers_fft2 .* low_pass_fft;
peppers_filtered_high_fft = peppers_fft2 .* high_pass_fft;
peppers_filtered_low = real(ifft2(peppers_filtered_low_fft));
peppers_filtered_high = real(ifft2(peppers_filtered_high_fft));
figure (7), imshow(peppers_filtered_low, []);
figure (8), imshow(peppers_filtered_high, []);
