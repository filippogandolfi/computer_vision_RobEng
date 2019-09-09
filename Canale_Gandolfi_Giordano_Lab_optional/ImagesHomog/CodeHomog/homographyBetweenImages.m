clc;
clear all;
close all;

I1 = imread('../imagesHomog/SET2_01.jpg'); % put the first image here
I2 = imread('../imagesHomog/SET2_02.jpg'); % put the second image here
%code for selection 4 points
n_point=4; % number of point
disp(['Choose ',num2str(n_point), ' points...']);
figure, imshow(I1), title(['Select ',num2str(n_point), ' points']), hold on;
X1 = zeros(n_point,2);
for i = 1 : n_point
    X1(i,:) = ginput(1);
    plot(X1(i,1), X1(i,2), 'sr');
    text(X1(i,1)-20, X1(i,2)-20, sprintf('%d',i));
end
X1 = [X1'; ones(1,n_point)];

disp(['Choose the corresponding ',num2str(n_point), ' points on the other image ...']);
figure, imshow(I2), title(['Select ',num2str(n_point), '  points']), hold on;
X2 = zeros(n_point,2);
for i = 1 : n_point
    X2(i,:) = ginput(1);
    plot(X2(i,1), X2(i,2), 'sr');
    text(X2(i,1)-20, X2(i,2)-20, sprintf('%d',i));
end
X2 = [X2'; ones(1,n_point)];


% estimate the homography
H = my_homography(X1,X2);

% estimate the homography with RANSAC method
Hr = ransacH(X1,X2,3);

% inverse mapping
I3 = inverseMapping(I1, H);
figure, imshow(uint8(I3)), title('Inverse mapping');

Im = (double(I2)+double(I3))/2.;
figure, imshow(uint8(Im)), title('Average image');

% inverse mapping with RANSAC method
I3 = inverseMapping(I1, Hr);
figure, imshow(uint8(I3)), title('Inverse mapping with RANSAC method');

Im = (double(I2)+double(I3))/2.;
figure, imshow(uint8(Im)), title('Average image with RANSAC method');

% normalization of the points
[X1n, T1] = normalise2dpts(X1);
[X2n, T2] = normalise2dpts(X2);

% estimate the homography
Hn = my_homography(X1n,X2n);

% de-normalize H
Hn = inv(T2) * Hn * T1;

% inverse mapping
I3 = inverseMapping(I1, Hn);
figure, imshow(uint8(I3)), title('Inverse mapping with normalized points');

Im = (double(I2)+double(I3))/2.;
figure, imshow(uint8(Im)), title('Average image with normalized points');

