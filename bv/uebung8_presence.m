cameraman = imread('cameraman.tif');
cam_fft = fft2(cameraman);
%figure, imshow(log(abs(fftshift(cam_fft))), []);

[m, n] = size(cameraman);
mask = zeros(m, n);
rm = round(m/2) + 1;
rn = round(n/2) + 1;
maskSize = 25;
mask(rm - maskSize : rm + maskSize, rn - maskSize : rn + maskSize) = 1;
mask = logical(mask);
figure (1), imshow(mask);

lowPass = fftshift(cam_fft) .* mask;
figure (2), imshow(log(abs(lowPass)), []);
maskHigh = ~mask;
highPass = fftshift(cam_fft) .* maskHigh;
figure (3), imshow(log(abs(highPass)), []);

new = ifft2(fftshift(lowPass));
new_high = ifft2(fftshift(highPass));
figure (4), imshow(new, []);
figure (5), imshow(new_high, []);
new2 = new + new_high;
figure (6), imshow(new2, []);

%
circuit = imread('circuit.tif');
v_filter = [-1;1];
h_filter = [-1 1];
circuit_v = imfilter(circuit, v_filter);
circuit_h = imfilter(circuit, h_filter);
figure (7), imshow(circuit);
figure (8), imshow(circuit_v, []);
figure (9), imshow(circuit_h, []);

%
coins = imread('coins.png');
filter = [0 1 0;1 -4 1; 0 1 0];
coins_filtered = imfilter(coins, filter);
figure (10), imshow(coins);
figure (11), imshow(coins_filtered);
