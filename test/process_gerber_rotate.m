function process_gerber_rotate(gerber_name, angle)
pad = imread(strcat(gerber_name,'_pad_p.png'));
white  = imread(strcat(gerber_name,'_white_p.png'));
drill = imread(strcat(gerber_name,'_drill_p.png'));
pad = imrotate(pad, angle);
white = imrotate(white, angle);
drill = imrotate(drill, angle);
imwrite(pad, strcat(gerber_name,'_pad_p.png'), 'png');
imwrite(white, strcat(gerber_name,'_white_p.png'), 'png');
imwrite(drill, strcat(gerber_name,'_drill_p.png'), 'png');