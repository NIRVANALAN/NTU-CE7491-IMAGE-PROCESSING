clear;clc;
I = imread('pepper_corrupt.tif');
% cI=fftshift(fft2(I));
butterworth_bandreject(I, 30,45,50);


function [J, H] = butterworth_bandreject(I,D_L, D_H,N) % I = imput image, DL = lower bound frequencyand DH vice versa.
[nx, ny] = size(I);
% zero_padding = [0,0];
cI=fftshift(fft2(I));

% D_L = D_L*size(I,1);
% D_H = D_H*size(I,1);

% W = D_H - D_L;
% D0 = (D_H+D_L)/2;
% [X,Y] = meshgrid(linspace(-1,1,nx));
% [X,Y] = meshgrid(-floor(nx/2):floor(nx-1)/2, -floor(ny/2):floor(ny-1)/2);
% H = 1./ (1+ (((X.^2+Y.^2).^1/2.*W)./(X.^2+Y.^2-D0^2)).^(2*N));
H = butterworth2d(I, D_L, D_H, N);
J = cI .* H;
iJ = ifft2(ifftshift(J));



subplot(2,3,1);
imshow(I);
subplot(2,3,4);
filterShow(cI);

subplot(2,3,2);
filterShow(H, 'grey');
subplot(2,3,5);
filterShow(H);

subplot(2,3,3);
imshow(iJ,[]);
subplot(2,3,6);
filterShow(J);
end
% filterShow(cI,'mesh')