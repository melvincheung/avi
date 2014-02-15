clear all
profile on
img = imread('sakura.jpg');
img2 = imread('sample1.jpg');
img3 = img2 -img;
% imshow(img);
% figure;
% imshow(img2);
% imwrite(img2, 'sakura1.jpg');
imshow(img3);
profile off
% profile viewer