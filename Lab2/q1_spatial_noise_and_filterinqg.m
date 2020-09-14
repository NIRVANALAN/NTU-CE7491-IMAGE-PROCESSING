% Clear workspace and command window
clear; clc;

% Read in images
I_lena = imread('lena.tif');
I_flower = imread('flower.tif');

noise_deblur(I_lena);
noise_deblur(I_flower);
close();

function []=noise_deblur(I)
% Gaussian noise
I_lena_gaussian_noise = imnoise(I, 'gaussian'); % gaussian noise
I_lena_gaussian_noise_median_filter = medfilt2(I_lena_gaussian_noise,[3,3]); % median filter, default kernel param is good
I_lena_gaussian_noise_gaussian_filter = imgaussfilt(I_lena_gaussian_noise, 1); % gaussian filter

% Salt and pepper noise
I_lena_salt = imnoise(I, 'salt & pepper', 0.1); % salt & pepper noise
I_lena_salt_median = medfilt2(I_lena_salt,[3,3]);
I_lena_salt_gaussian = imgaussfilt(I_lena_salt, 1);

% imshow
imshow([I I_lena_gaussian_noise I_lena_gaussian_noise_median_filter I_lena_gaussian_noise_gaussian_filter; I I_lena_salt I_lena_salt_median I_lena_salt_gaussian]);
title("original       gaussian noise     median filter denoise        gaussian filter denoise");

% Calculate MSE
mse_gaussian_noise_median_deblur = immse(I, I_lena_gaussian_noise_median_filter);
mse_gaussian_noise_gaussian_deblur = immse(I, I_lena_gaussian_noise_gaussian_filter);
mse_salt_noise_median_deblur = immse(I, I_lena_salt_median);
mse_salt_noise_gaussian_deblur = immse(I, I_lena_salt_gaussian);
display(["MSE: gaussian_noise median_deblur:",mse_gaussian_noise_median_deblur;
    "MSE: gaussian_noise gaussian_deblur:",mse_gaussian_noise_gaussian_deblur; % better
    "MSE: salt_noise median_deblur:",mse_salt_noise_median_deblur; % better
    "MSE: salt_noise gaussian_deblur:",mse_salt_noise_gaussian_deblur;]);
pause();
end