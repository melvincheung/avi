clear all;
close all;
orthophoto = imread('0002.bmp');
figure, imshow(orthophoto)
unregistered = imread('drills.png');
figure, imshow(unregistered)
orthophoto = rgb2gray(orthophoto);
unregistered = rgb2gray(unregistered);
orthophoto = imresize(orthophoto, size(unregistered));
cpselect(unregistered, orthophoto);
%function fitgeotrans is not implement is 2013a, may have to replace by Maketform/imtransform
%to be continued
%mytform = fitgeotrans(input_points, base_points, 'projective');
pause;
figure('name','before transform'); imshowpair(orthophoto, unregistered);
% base_points = base_points(1:4,:);
% input_points = input_points(1:4,:);
% T = maketform('projective',input_points,base_points); %ma
base_points = base_points(1:3,:);
input_points = input_points(1:3,:);
T = maketform('affine',input_points,base_points); %ma
B = imtransform(unregistered,T);
figure('name','after transform'); imshowpair(orthophoto, B);

%BW2 = bwmorph(BW,operation) 