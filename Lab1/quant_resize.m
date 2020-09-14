% Clear workspace and command window
clear; clc;

% Initialie variables
files = ["Lena.bmp", "Peppers.bmp", "Mandrill.bmp"];
quant_levels = [1 2 4 8 16];

% Loop through images
for i = 1 : length(files) 
    image = imread(files(i));

    % Quantization
    for j = 1 : length(quant_levels)
        % Compute quantized image
        quantized_image = imresize(image, 1/quant_levels(j)); % not uniform
        imresize(quantized_iamge, quant_levels(j));
        % thresh = multithresh(image, quant_levels(j));
        %valueMax = [thresh, max(image(:))];
        %quantized_image = imquantize(image, thresh, value);
        % quantMax = imquantize(image, thresh);
        % Show quantized image
        figure(1);
        % set(gcf,'Position',[100 100 260 220]);
        imshow(quantized_image,[]);
        title(strcat('Resize by: ',num2str(quant_levels(j)), ' Dim: ', num2str(size(quantized_image))));
        pause;
    end
end  