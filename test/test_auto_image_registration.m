gerber_pad = imread('0001.bmp');
sample_pad = imread('0002.bmp');
gerber_pad = imresize(gerber_pad, 0.1);
sample_pad = imresize(sample_pad, 0.1);
diff = auto_image_registration(gerber_pad, sample_pad);