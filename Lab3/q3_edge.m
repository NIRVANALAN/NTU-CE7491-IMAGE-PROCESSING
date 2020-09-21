% Notes:
% Default value of sigma is sqrt(2). Canny filter are chosen based on
% deviation automatically.
% Threshold must be less than 1

clear; clc;
% Read in image
I = rgb2gray(imread('sniper.jpg')); % Canny process gray scale images
[x, y] = size(I);

% Rotate and flip, construct symmetric image
Sym_I(x+1:2*x, y+1:2*y) = I;
Sym_I(1:x, 1:y) = imrotate(I, 180);
Sym_I(1:x, 2*y+1:3*y) = imrotate(I, 180);
Sym_I(2*x+1:3*x, 1:y) = imrotate(I, 180);
Sym_I(2*x+1:3*x, 2*y+1:3*y) = imrotate(I, 180);
Sym_I(1:x, 1*y+1:2*y) = flip(I, 1);
Sym_I(2*x+1:3*x, 1*y+1:2*y) = flip(I, 1);
Sym_I(1*x+1:2*x, 1:y) = flip(I, 2);
Sym_I(1*x+1:2*x, 2*y+1:3*y) = flip(I, 2);

sigma = input('input sigma:');
threshold = input('input threshold, 0<threshold<1:');
J = edge(Sym_I, 'canny', [threshold*0.4, threshold], sqrt(sigma)); % Apply standard Canny edge detection, using default standard deviation
J = J(x+1:2*x, y+1:2*y);

% Show result
subplot(1,2,1);
imshow(J, []);
title(sprintf('Canny Edge Detetion, threshold = %0.1f', threshold));
subplot(1,2,2);
imshow(I);
