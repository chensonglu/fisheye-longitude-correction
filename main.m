img = imread('test.jpg');

result = fisheye_longitude_correction(img, 40);
figure, imshow(result)


% very slow, unless you want
% result = fisheye_longitude_correction_other(img, 40);
% figure, imshow(result)