% histTransfer('lena.bmp','Mandrill.bmp');
function newHistMatchImage = histTransfer(image1, image2)
I1 = imread(image1);
I2 = imread(image2);
newHistMatchImage = histeq(I1, imhist(I2));

%plot
figure(4);
subplot(3,2,1);
imshow(I1);
subplot(3,2,2);
imhist(I1);
subplot(3,2,3);
imshow(I2);
subplot(3,2,4);
imhist(I2);
subplot(3,2,5);
imshow(newHistMatchImage);
subplot(3,2,6);
imhist(newHistMatchImage);

end