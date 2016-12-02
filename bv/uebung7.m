% 2.
peppers = rgb2gray(imread('peppers.png'));
peppers_1 = imnoise(peppers, 'salt & pepper', 0.02);
peppers_2 = imgaussfilt(peppers);
peppers_3 = imnoise(peppers, 'salt & pepper', 0.6);

peppers_fft = fftshift(log(abs(fft2(peppers))));
peppers1_fft = fftshift(log(abs(fft2(peppers_1))));
peppers2_fft = fftshift(log(abs(fft2(peppers_2))));
peppers3_fft = fftshift(log(abs(fft2(peppers_3))));

figure (1), imshow(peppers_fft, []);
figure (2), imshow(peppers1_fft, []);
figure (3), imshow(peppers2_fft, []);
figure (4), imshow(peppers3_fft, []);
