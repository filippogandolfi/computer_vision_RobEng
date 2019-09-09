%% Computer Vision: Lab 5
% Francesca Canale, Filippo Gandolfi, Marco Giordano

% Loading images:
rgb_image(:, :, :, 1) = imread('ur_c_s_03a_01_L_0376.png', 'png');
rgb_image(:, :, :, 2) = imread('ur_c_s_03a_01_L_0377.png', 'png');
rgb_image(:, :, :, 3) = imread('ur_c_s_03a_01_L_0378.png', 'png');
rgb_image(:, :, :, 4) = imread('ur_c_s_03a_01_L_0379.png', 'png');
rgb_image(:, : ,:, 5) = imread('ur_c_s_03a_01_L_0380.png', 'png');
rgb_image(:, :, :, 6) = imread('ur_c_s_03a_01_L_0381.png', 'png');

% Grayscale images:
figure
for i = 1:6
    gray_image(:, :, i) = rgb2gray(rgb_image(:, :, :, i));
    subplot(2, 3, i)
    imagesc(gray_image(:, :, i)), colormap gray, title(['Frame ', num2str(i)])
end
sgtitle('Grayscale images')

% Normalized Cross Correlation:
for i = 1:6 % For each frame

a = 320;
b = 450;
d = 665;
e = 795;
red_car_area = gray_image(a:b, d:e, 1);

    for j= 1:3 % For each size of the template
        [xoffSet, yoffSet, xmax, ymax] = ncc(gray_image(:, :, i), red_car_area, j);

        figure
        imagesc(gray_image(:, :, i)), colormap gray, title(['Frame ' num2str(i) ' with template of size ' num2str(j)])
        hold on
        rectangle('Position',[xoffSet+1 yoffSet+1 size(red_car_area, 2) size(red_car_area, 1)],'EdgeColor', 'r', 'LineWidth', 2)
        hold on
        plot(xmax, ymax, 'r*')
        
        % Changing size of the template
        a = a + 20;
        b = b - 20;
        d = d + 20;
        e = e - 20;
        red_car_area = gray_image(a:b, d:e, 1);
    end
end

%% Function
% NCC
function [xoffSet, yoffSet, xmax, ymax] = ncc(Img, Window, n)
    t = cputime;
    
	figure
    c = normxcorr2(Window, Img); % Applaying NNC 
    imagesc(c), colormap gray, title(['NNC with template of size ' num2str(n)])

    % Find the maximum value:
    [ypeak, xpeak] = find(c==max(c(:)));
    yoffSet = ypeak - size(Window, 1);
    xoffSet = xpeak - size(Window, 2);
    
    ymax = ypeak - size(Window, 1)/2;
    xmax = xpeak - size(Window, 2)/2;
    
    e = cputime - t; % Calculates computational time
    disp(['Computational time is ' num2str(e) ' s']);
end