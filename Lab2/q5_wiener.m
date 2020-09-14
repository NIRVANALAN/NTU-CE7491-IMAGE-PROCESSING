clear; clc;

% Read image
G = imread('coins_blurred.tif');
G_fft = fftshift(fft2(G));
[R,C] = size(G);

% creat disk filter
H = fspecial('disk',2);
H_fft = fftshift(fft2(H,R,C)); % 0 padding

% directly inverse filter
I_fft = G_fft./H_fft;
I = ifft2(fftshift(I_fft));

NSR = 0.001;
F_fft = wiener(H_fft, G_fft, NSR);


% transform to real
F = ifft2(ifftshift(F_fft));
F = real(F); % remove complex part
F(F<0)=0;
F(F>255)=255; % clip the result

% visualization result
R = 2;
C = 4;
% Degraded
subplot(R,C,1);
imshow(G);
subplot(R,C,5);
filterShow(G_fft);

% Disk filter with radius 2
subplot(R,C,6);
filterShow(H_fft);
subplot(R,C,2);
filterShow(H_fft, 'grey');

% Inverse filtering
subplot(R,C,3);
imshow(I,[]);
subplot(R,C,7);
filterShow(I_fft);

% Wiener filtering
subplot(R,C,4);
imshow(F,[]);
subplot(R,C,8);
filterShow(F_fft);
% wiener filter
function F_fft = wiener(H_fft, G_fft, NSR)
Wiener_fft = (H_fft)./(abs(H_fft).^2+NSR); % provide much better robustness to noise(high frequency), minimize the MSE
F_fft = Wiener_fft .* G_fft;
end