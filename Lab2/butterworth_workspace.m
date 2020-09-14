I = imread('pepper_corrupt.tif');
[nx, ny] = size(I);
n=5;
D0=0.15; % mean
W = 0.1;

[X, Y] = meshgrid(linspace(-1,1,100));

% H = 1./(1.+(D0^2./(X.^2+Y.^2)).^n); % high pass
% H = 1./(1.+((X.^2+Y.^2)/D0^2).^n); % low pass
H = 1./ (1+ (((X.^2+Y.^2).^1/2.*W)./(X.^2+Y.^2-D0^2)).^(2*n)); % 2d band stop

%H = 1./ (1+ (((X.^2).^1/2.*W)./(X.^2-D0^2)).^(2*n)); % 1d band stop

surf(X,Y,H);