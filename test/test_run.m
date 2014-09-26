close all;
clear all;
% profile on;
%% Test layer extraction by k-mean clustering

% image = imread('001.bmp');
image = imread('D:\pcb samples\08092014 pcb board scanning\blue file.bmp');
image = imresize(image, 0.1);
segmented_images1 = extract_color_by_kmean(image, 4);

% profile off;
% profile viewer;

%% Test overlapping layer with gerber image to find suspected defects
gerber_pad = imread('052-34226A02&132-30079A02(bn41-01919c)_pad_p.png');
sample_pad = segmented_images1;
% gerber_pad = im2bw(gerber_pad, graythresh(gerber_pad));
% sample_pad = im2bw(sample_pad, graythresh(sample_pad));
diff= auto_image_registration(gerber_pad, sample_pad);

%% Save all the part with image difference
% lable all connected suspected defects
diff = uint8(diff);
diff_bw = im2bw(diff, graythresh(diff));
[label, total] = bwlabel(diff_bw, 8);

% count the num. of suspected defects
total

% measure the size of labeled elements (in num. of pixels)
[nelements,centers] = hist(label,unique(label));
element_sizes=[centers' sum((nelements),2)];
% neglect blank region
element_sizes = element_sizes(2:total, :);

% find element centers
% element_props = regionprops(label, 'Centroid', 'Area');
element_props = regionprops(label, 'Centroid');
element_props = element_props(2:total, :);

% ignore small elements
lower_bound = 60;%just hard code now, should be replaced by some dynamic methods
% upper_bound = ?;
% element_sizes2 = element_sizes(element_sizes(:,2)>lower_bound);
element_props = element_props(element_sizes(:,2)>lower_bound);

% convert element_centers struct to ordinary matrix
element_centers2 = zeros(size(element_props));
for row=1:size(element_props, 1)
    element_centers2(row,1) = element_props(row).Centroid(1);
    element_centers2(row,2) = element_props(row).Centroid(2);
end
% element_centers2 = element_props.Centroid;

% circle the defect parts on board
% close all
figure(), imshow(diff);
radius = ones(size(element_centers2,1), 1) * 10;
element_centers3 = horzcat(element_centers2, radius);
image2 = insertShape(image, 'FilledCircle', element_centers3, 'Color', 'red', 'Opacity', 0.5);
figure(), imshow(image2);
% insertShape
% image2 = insertMarker(image, element_centers2, 'x', 'Color', 'red', 'Size', 15);
% figure(), imshow(image2);
% image2 = insertMarker(image, element_centers2, '+', 'Color', 'red', 'Size', 15);
% figure(), imshow(image2);
% image2 = insertMarker(image, element_centers2, '*', 'Color', 'red', 'Size', 15);
% figure(), imshow(image2);
% image2 = insertMarker(image, element_centers2, 's', 'Color', 'red', 'Size', 15);
% figure(), imshow(image2);

%% Test extract vector from defect


%% Test svm

