clear; clc;

Original_I = imread('flowers.jpg');
mask = uint8(imread('mask.tif'));

% Part I, swap the R and B values for the pixels in the mask and generate a
% new image
J = Original_I .* mask;

% extract rgb channel
R = J(:,:,1);
J(:,:,1) = J(:,:,3); % B
J(:,:,3) = R;
J = Original_I .* (1-mask) + J;

% Part 2 HSV: Convert RGB to HSV and extract hue using mask
M = double(mask);
HSV = rgb2hsv(Original_I);
MASK_HUE = HSV(:,:,1) .* M;
% hue value is in [0,1], rotate by multiplying 360 and subtract/add, then
% scale back to [0,1]

rotations = (0:40:360);

for i=1:length(rotations) %
    rotated_hue = mod(MASK_HUE .* 360 + rotations(i), 360) / 360;
    K(:,:,:,i) = HSV;
    K(:,:,1,i) = HSV(:,:,1) .* (1-M) + rotated_hue .* M;
end


figure(1);
imshow([Original_I, J]);

figure(2);
c = 4;
r = ceil(length(rotations)/c);
for i=1:length(rotations)
    subplot(r,c,i);
    imshow(hsv2rgb(K(:,:,:,i)));
    title(rotations(i));
end

% pause();
% close();