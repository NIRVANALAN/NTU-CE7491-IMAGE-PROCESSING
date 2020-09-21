clear; clc;

% The Hough transform matrix, H, is NRHO-by-NTHETA
% NRHO = (2*ceil*D/RhoResolution)) + 1 where
% D = sqrt((numRowsInBW - 1)^2 + (numColsInBW - 1)^2)
%   In our case:
%       RhoResolution = 0.5 (interactive input by user)
%       D = sqrt((634-1)^2 + (845-1)^2) = 1055

% RhoResolution is a real scalar between 0 and norm(size(BW)), exclusive.
% RhoResolution specifies the spacing of the Hough transform bins along the
% rho axis. Default: 1.
   
% RHO values range from -DIAGONAL to DIAGONAL where
% DIAGONAL = RhoResolution*ceil(D/RhoResolution)
%   In our case,
%   For RhoResolution = 0.5
%   DIAGONAL = 0.5*ceil(1055/0.5) = 1055

% THETA values are within the range [-90,90) degrees with variable step
% size (interactive input by user)

% Read in image
I = rgb2gray(imread('sniper.jpg'));
[x, y] = size(I);

% Generate symmetrically reflected image.

R(x+1:2*x, y+1:2*y) = I;
R(1:x, 1:y) = imrotate(I, 180);
R(1:x, 2*y+1:3*y) = imrotate(I, 180);
R(2*x+1:3*x, 1:y) = imrotate(I, 180);
R(2*x+1:3*x, 2*y+1:3*y) = imrotate(I, 180);
R(1:x, 1*y+1:2*y) = flip(I, 1);
R(2*x+1:3*x, 1*y+1:2*y) = flip(I, 1);
R(1*x+1:2*x, 1:y) = flip(I, 2);
R(1*x+1:2*x, 2*y+1:3*y) = flip(I, 2);
subplot(2,2,1);
imshow(R);
title('symmetrically reflected sniper');

% Apply standard canny edge detection
sigma = input('input sigma:');
BW = edge(R, 'canny', [], sqrt(sigma)); % approxCanny in this case
BW = BW(x+1:2*x, y+1:2*y);

% Apply hough transform
RhoResolution = input('input RhoResolution Bin Space size: ');
[H,T,R] = hough(BW,'RhoResolution',RhoResolution,'Theta',-90:89); % -90 degree - 89 degree, default
% return H — Hough transform matrix, theta — Angle between x-axis and rho
% vector, rho — Distance from origin to line


% Display the original image and most prominent line
subplot(2,2,2);
imshow(I);
% line([x1,x2],[y1,y2]);
title('sniper.jpg');

% extract peak points. ret value are arrays of lines
P  = houghpeaks(H,2); % (1 in this case)
x = T(P(:,2)); 
y = R(P(:,1));

% Display the H matrix
subplot(2,2,3);
imshow(imadjust(rescale(H)),'XData',T,'YData',R,'InitialMagnification','fit');


title('Hough transform of sniper.jpg');
xlabel('\theta'), ylabel('\rho');
axis on, axis normal, hold on;
colormap(gca,hot);
plot(x,y,'s','color','green'); % plot points

% plot line segments
lines=houghlines(BW,T,R,P);% extract lines
subplot(2,2,4);
imshow(I), hold on;
for k = 1:length(lines)
xy = [lines(k).point1; lines(k).point2];
 plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');% plot segments
plot(xy(1,1),xy(1,2),'x','LineWidth',2,'Color','yellow');%start
plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','red');% end
end