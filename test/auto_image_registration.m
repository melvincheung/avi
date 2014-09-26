function diff = auto_image_registration(fix, rotate)
% reference:
% http://www.mathworks.com/company/newsletters/articles/automating-image-registration-with-matlab.html
% further work: can we use the same parameter on other layers (white,
% green...)?
% clear all;
% close all;

%     Read the images into the workspace with imread.
% orthophoto = imread('0002.bmp');
orthophoto = fix;
figure, imshow(orthophoto)
% unregistered = imread('0003.bmp');
unregistered = rotate;
% unregistered = imread('drills.png');
figure, imshow(unregistered)
orthophoto = rgb2gray(orthophoto);
unregistered = rgb2gray(unregistered);
orthophoto = imresize(orthophoto, size(unregistered));
% orthophoto = imresize(orthophoto, 0.1);
% unregistered = imresize(unregistered, 0.1);
%     Create the optimizer and metric with imregconfig.
[optimizer, metric]  = imregconfig('monomodal');
%     Register the images with imregister.
[movingRegistered R_reg] = imregister(unregistered, orthophoto, 'translation', optimizer, metric);
%     View the results with imshowpair or save a copy of an image showing the results with imfuse.
figure; imshowpair(orthophoto, movingRegistered);
diff = int8(orthophoto) - int8(movingRegistered);
% diff = uint8( abs(int8(orthophoto) - int8(movingRegistered)) );
figure; imshow(uint8(diff));
