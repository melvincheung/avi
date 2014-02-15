close all;
clear all;
input = imread('difference.jpg');
output = filter_by_threshold(input, 100);
imshow(input);
figure;
imshow(output);