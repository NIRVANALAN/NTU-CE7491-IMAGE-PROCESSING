clear;clc;
input = 'Mandrill.bmp';
I = imread(input);
for window_size = [101,257, 351]    
%window_size = 21;

J = localhisteq_call(I, [window_size, window_size]);


% imshow
figure('Name',strcat('window_size: ', num2str(window_size)));
subplot(2,2,1);
imshow(I);
subplot(2,2,2);
imshow(J);
subplot(2,2,3);
imhist(I);
subplot(2,2,4);
imhist(J);
savefig(strcat(input, " ", num2str(window_size), '.fig'));

% pause;
end
close();


function J = localhisteq_call(I, range)
    % display input
    disp('range: ');
    disp(range);


    imsize = size(I);
    padImage = padarray(I, range, "symmetric");


    % histeq
    % J = histeq(I,255); % global histeq with 255 bins
    % init
    x_half_range = floor(range(1)/2);
    y_half_range = floor(range(2)/2);

    % loop

    for i = range(1)+1:imsize(1)+range(1)
        for j = range(2)+1:imsize(2)+range(2)
            J = histeq(padImage(i-x_half_range: i+x_half_range, j-y_half_range:j+y_half_range), 255); % 255 bin
            I(i-range(1),j-range(2)) = J(x_half_range+1,y_half_range+1);
        end
        fprintf('%4.2f%%\n',100*(i-range(1))/imsize(1));
    end
    J=I;
end


