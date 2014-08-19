%{
Objective: To check each defect OBJECTS whether which material it locates on
Procedures:
1. align defect OBJECTS map and gerber file (how to check if it is correctly combined?)
2. for each defect OBJECTS find its underlying material
%}

gpcb = pcb_subtract(pcb003, pcb004);
% imshow(gpcb);
% gpcb = gpcb_err;
gpcb = rgb2gray(gpcb);
gpcb = im2bw(gpcb, graythresh(gpcb));
CC = bwconncomp(logical(gpcb>0));
%% Enlarge and align pad with gpcb
resized_pad = imresize(pad, [size(gpcb,1), size(gpcb,2)]);
% figure;
% imshow(resized_pad);
%% for each defect find its underlying material
on_pad = zeros(CC.NumObjects, 1);
for object = 1:CC.NumObjects
    count = 0;
    for pixel = 1:size(CC.PixelIdxList{object}, 1)
        if resized_pad(CC.PixelIdxList{object}(pixel)) == 1
            count = count + 1;
        end
    end
    %this part decide which material the error object lies on
    if count > size(CC.PixelIdxList{object}, 1)/2
%     if count > 1
        on_pad(object) = 1;
    end
end

filtered = zeros(CC.ImageSize);
% to output filtered image
for object=1:size(on_pad, 1)
    if on_pad(object) == 1
        for pixel = 1:size(CC.PixelIdxList{object}, 1)
           filtered(pixel) = 1;
        end
    end
end

% for object = 1:CC.NumObjects
%     for pixel = 1:size(CC.PixelIdxList{object}, 1)
%         if CC.PixelIdxList{object}(pixel)
%         end
%     end
%     %this part decide which material the error object lies on
%     if count > size(CC.PixelIdxList{object}, 1)/2
% %     if count > 1
%         on_pad(object) = 1;
%     end
% end