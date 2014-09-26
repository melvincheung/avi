close all;
clear all;
drill = imread('052-34523a01-132-34524a01_drill.png');
pad = imread('052-34523a01-132-34524a01_pad.png');
white_ink = imread('052-34523a01-132-34524a01_white.png');
% stupid method but work
for row=1:size(drill,1)
    for col=1:size(drill,2)
        % drill
        if drill(row, col, 1)>0 || drill(row, col, 2)>0 || drill(row, col, 3)>0
            drill(row, col, 1) = 255;
            drill(row, col, 2) = 0;
            drill(row, col, 3) = 0;
        end
    end
end

% the 2 gerber generated files are of different size. This is a potential
% problem
for row=1:size(white_ink,1)
    for col=1:size(white_ink,2)
        % white ink
        if white_ink(row, col, 1)>0 || white_ink(row, col, 2)>0 || white_ink(row, col, 3)>0
            white_ink(row, col, 1) = 255;
            white_ink(row, col, 2) = 0;
            white_ink(row, col, 3) = 0;
        end
    end
end
figure('name', 'drill'); imshow(drill);
figure('name', 'white ink'); imshow(white_ink);


% green ink