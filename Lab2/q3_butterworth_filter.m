clear;clc;
% Initialize variables
D0 = 80; % frequency cutoff
n = 10; % controls the steepness
% filter_type = 'highpass'; % low or high
rows = 2;  
cols = 3;

% Read in image
I = imread('flower.tif');
subplot(rows,cols,1);
imshow(I);
% colormap default

% Apply butterworth filter
[J,H] = ButterWorthFilter(I, D0, n, "lowpass");
pause();
[J,H] = ButterWorthFilter(I, D0, n, "highpass");


function [J, H] = ButterWorthFilter(I, D0, n, filter_type)
if ~strcmp(filter_type, 'highpass') && ~strcmp(filter_type,'lowpass')
    error('filter type unknown. Must be either highpass or lowpass');
end

rows = 2;
cols = 3;
    
% construct fft
[nx, ny] = size(I);
zero_padding = [2*nx+1, 2*ny+1];
fftI = fftshift(fft2(I, zero_padding(1),zero_padding(2))); % zero padding
subplot(rows,cols,4); % visualize the filter
filterShow(fftI);

% Construct butterworth filter H
[X, Y] = meshgrid(-nx:ny);
if strcmp(filter_type, 'highpass') % high pass filter
    H = 1./(1.+(D0^2./(X.^2+Y.^2)).^n);
else % low pass filter
    H = 1./(1.+((X.^2+Y.^2)/D0^2).^n);
end
subplot(rows,cols,2);
filterShow(H);

% Plot Butterworth filter H
subplot(rows,cols,5);
filterShow(H,'grey');

J = fftI .* H; % apply butterworth filter to fftI
subplot(rows,cols,6);
filterShow(J);
J = ifftshift(J); % inverse shift  for visualization
J = ifft2(J, zero_padding(1),zero_padding(2));
J = uint8(real(J(1:nx,1:ny)));
subplot(rows,cols,3);
imshow(J);
end