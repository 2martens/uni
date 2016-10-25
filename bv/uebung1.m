% 1.
M = [1 2; 3 4; 5 6];
M = [M(1, 1:2) M(3, 1:2) M(2, 1:2)];

% 2.
lowerBound = 0;
upperBound = 10;
M2 = (upperBound-lowerBound).*rand(10, 10) + lowerBound;
M2(1, 1:end) = 1;
M2(1:end, 1) = 1;

% 3.
rowVector = zeros(1, 200);
rowVector(1:4) = [8 6 4 2];
rowVector(end) = 10;