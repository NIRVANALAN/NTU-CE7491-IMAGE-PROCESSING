% Clear workspace and command window
clear; clc;

% Initialie variables
files = ["Lena.bmp", "Peppers.bmp", "Mandrill.bmp"];
quant_levels = [2 4 8 16 64];

% Loop through images
for i = 1 : length(files)
    image = imread(files(i));

    % Quantization
    for j = 1 : length(quant_levels)
        % Compute quantized image
        quantized_image = image / quant_levels(j); % not uniform
        % thresh = multithresh(image, quant_levels(j));
        %valueMax = [thresh, max(image(:))];
        %quantized_image = imquantize(image, thresh, value);
        % quantMax = imquantize(image, thresh);
        % Show quantized image
        figure(1);
        subplot(1,2,1)
        imshow(quantized_image,[]);
        subplot(1,2,2)
        imhist(quantized_image);
        title(strcat('Divide by: ',num2str(quant_levels(j))));
        pause;
    end
end