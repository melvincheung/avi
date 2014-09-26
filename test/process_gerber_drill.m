function process_gerber_drill(gerber_name)
a = imread(gerber_name);%e.g. '052-34523a01-132-34524a01_white.png'
b = zeros(size(a,1), size(a,2), 3);
for row = 1:size(a,1)
    for col = 1:size(a,2)
        if a(row, col, 1) > 0 || a(row, col, 2) > 0 || a(row, col, 3) > 0
            b(row, col, 1) = 255;
            b(row, col, 2) = 255;
            b(row, col, 3) = 255;
        end
    end
end
imshow(b);
gerber_name = strrep(gerber_name, '.png', '');
imwrite(b, strcat(gerber_name,'_p.png'), 'png');

% imwrite(b, '052-34523a01-132-34524a01_pad_p.png', 'png');