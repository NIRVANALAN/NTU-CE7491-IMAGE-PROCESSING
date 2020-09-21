% Clear command window and workspace
clear; clc;

% Read in image
I = imread('flowers.jpg');
I_HSV = rgb2hsv(I);
I_LAB = rgb2lab(I);

% Equalize the 3 RGB channels individually and combine the results
Indiv_Equ(:,:,1) = histeq(I(:,:,1));
Indiv_Equ(:,:,2) = histeq(I(:,:,2));
Indiv_Equ(:,:,3) = histeq(I(:,:,3));

%Convert to HSV and equalize only V, convert back to RGB
HSV_2 = rgb2hsv(I);
HSV_2(:,:,3) = histeq(HSV_2(:,:,3));
V_equ = hsv2rgb(HSV_2);

% Convert to L*a*b and equalize only L*, convert back to RGB
LAB_3 = rgb2lab(I);
LAB_3(:,:,1) = histeq(LAB_3(:,:,1));
L_equ = lab2rgb(LAB_3);

% Results
r = 2;
c = 2;
subplot(r,c,1);
imshow(I);
title('Original');
subplot(r,c,2);
imshow(Indiv_Equ);
title('Equalize RGB channels individually');
subplot(r,c,3);
imshow(V_equ);
title('Equalize only on Vue channel');
subplot(r,c,4);
imshow(L_equ);
title('Equalize only on L* channel');