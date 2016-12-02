% 1.
peppers = rgb2gray(imread('peppers.png'));
peppers_smooth = imgaussfilt(peppers, 3);
peppers_fft = fft2(peppers);
peppers_smooth_fft = fft2(peppers_smooth);

sum_peppers = sum(peppers(:));
first_el = peppers_fft(1, 1);

peppers_fftshift = fftshift(log(abs(peppers_fft)));
peppers_smooth_fftshift = fftshift(log(abs(peppers_smooth_fft)));

%figure (1), imshow(peppers);
%figure (2), imshow(peppers_smooth);
%figure (3), imshow (log(abs(peppers_fft)), []);
%figure (4), imshow (log(abs(peppers_smooth_fft)), []);
%figure (5), imshow(peppers_fftshift, []);
%figure (6), imshow(peppers_smooth_fftshift, []);
%figure (7), imshow(fftshift(peppers))

%---------
tissue = rgb2gray(imread('tissue.png'));
tissue_fft = fft2(tissue);
tissue_fft_processed = log(abs(tissue_fft));
tissue_fft_shifted_processed = fftshift(tissue_fft_processed);

figure (8), imshow(tissue);
figure (9), imshow(tissue_fft_shifted_processed, []);

test = imread('testpat1.png');
test_fft = fft2(test);
test_fft_processed = log(abs(test_fft));
test_fft_shifted_processed = fftshift(test_fft_processed);

figure (10), imshow(test);
figure (11), imshow(test_fft_shifted_processed , []);
