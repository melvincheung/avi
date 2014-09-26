function [output] = extract_color_by_kmean(image, no_of_layers)
% This function use k-mean clustering to cluster different layers (pad, white ink, green ink...)
imshow(image), title('original image');
text(size(image,2),size(image,1)+15,...
    'pcb board', ...
    'FontSize',7,'HorizontalAlignment','right');

% References about CIELAB transformation
% http://www.aces.edu/dept/fisheries/education/pond_to_plate/documents/ExplanationoftheLABColorSpace.pdf
% http://en.wikipedia.org/wiki/Lab_color_space
use_lab_transform = true;
if use_lab_transform
    cform = makecform('srgb2lab');
    lab_image = applycform(image,cform);
    
    ab = double(lab_image(:,:,2:3));
    nrows = size(ab,1);
    ncols = size(ab,2);
    ab = reshape(ab,nrows*ncols,2);
    
else
    ab = double(image);
    nrows = size(ab,1);
    ncols = size(ab,2);
    ab = reshape(ab,nrows*ncols,3);
end
% no_of_layers = 4;
% repeat timage clustering 3 times to avoid local minima

% cluster by predetermined seeds (under construction)
if use_lab_transform
    pad = [150, 152];
    white_ink = [122, 127];
    green_ink = [85, 148];
    back_ground = [120, 128];
else
    pad = [236, 173, 146];
    white_ink = [220, 249, 255];
    green_ink = [0, 138, 80];
    back_ground = [64, 78, 72];
end
% back_ground =
seeds = [pad ; white_ink; green_ink; back_ground];

%Possible improvement: k-metroid clustering may improve computational time
%comparing with K-mean clustering
[cluster_idx, cluster_center] = kmeans(ab,no_of_layers,'distance','sqEuclidean', ...
    'start', seeds);

plot_color_dist(ab, 300, seeds, cluster_center);

% [cluster_idx, cluster_center] = kmeans(ab,no_of_layers,'distance','sqEuclidean', ...
%                                       'Replicates',3, 'start', 'cluster');
% output = cluster_idx;

pixel_labels = reshape(cluster_idx,nrows,ncols);
figure(); imshow(pixel_labels,[]), title('image labeled by cluster index');

segmented_images = cell(1,3);
rgb_label = repmat(pixel_labels,[1 1 3]);

for k = 1:no_of_layers
    color = image;
    color(rgb_label ~= k) = 0;
    segmented_images{k} = color;
end

figure(); imshow(segmented_images{1}), title('objects in cluster 1');
output = segmented_images{1};
% imwrite(segmented_images{1}, 'extracted1.png', 'png');
figure(); imshow(segmented_images{2}), title('objects in cluster 2');
% output = segmented_images{2};
figure(); imshow(segmented_images{3}), title('objects in cluster 3');

figure(); imshow(segmented_images{4}), title('objects in cluster 4');

% figure(); imshow(segmented_images{5}), title('objects in cluster 5');
%
% figure(); imshow(segmented_images{6}), title('objects in cluster 6');
end

function plot_color_dist(image, sample_size, seeds, cluster_center)
if exist('datasample', 'file') == 2 %check if 'datasample' function exist
    sample = datasample(image, sample_size, 1);
else
    %this part is for old version matlab which 'datasample' function
    %does not exist
%     subset = randperm(size(image, 1), sample_size);
    subset = randperm(size(image, 1));
    subset = subset(1:sample_size);
    sample = image(subset);
end
figure(); hold on;
scatter(sample(:,1), sample(:,2), '.');
%plot initial seeds
scatter(seeds(1,1), seeds(1,2), 'd', ...
    'MarkerEdgeColor', 'r', 'MarkerFaceColor', 'y');
scatter(seeds(2,1), seeds(2,2), 'd', ...
    'MarkerEdgeColor', 'r', 'MarkerFaceColor', 'w');
scatter(seeds(3,1), seeds(3,2), 'd', ...
    'MarkerEdgeColor', 'r', 'MarkerFaceColor', 'g');
scatter(seeds(4,1), seeds(4,2), 'd', ...
    'MarkerEdgeColor', 'r', 'MarkerFaceColor', 'k');
%plot final cluster centers
scatter(cluster_center(1,1), cluster_center(1,2), 24, 'o', ...
    'MarkerEdgeColor', 'y', 'MarkerFaceColor', 'y');
scatter(cluster_center(2,1), cluster_center(2,2), 24, 'o', ...
    'MarkerEdgeColor', 'r', 'MarkerFaceColor', 'r');
scatter(cluster_center(3,1), cluster_center(3,2), 24, 'o', ...
    'MarkerEdgeColor', 'g', 'MarkerFaceColor', 'g');
scatter(cluster_center(4,1), cluster_center(4,2), 24, 'o', ...
    'MarkerEdgeColor', 'k', 'MarkerFaceColor', 'k');
hold off;
end
