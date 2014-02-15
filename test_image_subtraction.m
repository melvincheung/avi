filter = imread('sakura.jpg');
sample = imread('sample1.jpg');
difference = image_subtraction(sample, filter);
figure;
imshow(difference);