function generate_random_images(input_name, num_of_outputs)
original = imread(input_name);
for i = 1:num_of_outputs
    img = imnoise(original, 'salt & pepper');
    imwrite(img, strcat('sample', int2str(i), '.jpg') );
end
end
