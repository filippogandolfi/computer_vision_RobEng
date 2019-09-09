%% Computer Vision: Lab 4
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

% Dividing into channels and saving the Hue component:
for i = 1:6
    hue_component(:, :, i) = dividing_channels(rgb_image(:, :, :, i), i);
end

% Selecting image of frame 1:
frame_chosen = 1;

% Evaluating Hue component values of the car pixels:
[m, s] = hue_evaluation(hue_component(:, :, frame_chosen)); % Mean and standard deviation

% Segmenting the red car:
for i = 1:6
    seg(:, :, i) = segmentation(hue_component(:, :, i), m, s, i);
    figure, imagesc(seg(:, :, i)), colormap gray, title(['Segmented red car in frame ', num2str(i)])
end

% Detecting the car:
figure
for i = 1:6
    subplot(2, 3, i)
    detect_car(gray_image(:, :, i), seg(:, :, i), i);
end
sgtitle('Detected car')

%% Functions:
% Splitting the images in the three RGB channels and in the three HSV channels and saving the Hue component:
function Hue = dividing_channels(Img, numFrame)

    Img_hsv = rgb2hsv(Img);
    
    figure,
    subplot(2, 3, 1)
    imagesc(Img(:, :, 1)), colormap gray, title('R component') % Red
    subplot(2, 3, 2)
    imagesc(Img(:, :, 2)), colormap gray, title('G component') % Green
    subplot(2, 3, 3)
    imagesc(Img(:, :, 3)), colormap gray, title('B component') % Blue
    subplot(2, 3, 4)
    imagesc(Img_hsv(:, :, 1)), colormap gray, title('H component') % Hue
    subplot(2, 3, 5)
    imagesc(Img_hsv(:, :, 1)), colormap gray, title('S component') % Saturation
    subplot(2, 3, 6)
    imagesc(Img_hsv(:, :, 1)), colormap gray, title('V component') % Intensity
    sgtitle(['Frame ', num2str(numFrame), ': channels splitted'])
    
    Hue = Img_hsv(:, :, 1);
end

% Studying the Hue values:
function [mean, st_dev] = hue_evaluation (Img)

    red_car_area = Img(390:400, 710:740); % Selecting red car area
    mean = mean2(red_car_area); % Computing the mean value
    st_dev = std2(red_car_area); % Computing the standard deviation
end

% Segmenting the object in the image by thresholding the Hue component:
function seg = segmentation(Img, mean, st_dev, numFrame)
    
    [r, c] = size(Img);
    first_mask = zeros(r, c); % Initialization of the mask
    threshold_min = mean - 0.2 * st_dev;
    threshold_max = mean + 2 * st_dev;
    mask = Img > threshold_min & Img < threshold_max; % Thresholding the Hue component
    first_mask = first_mask + mask;
    figure, imagesc(first_mask), colormap gray, title(['First result of the segmentation for frame ', num2str(numFrame)])
    
    K = ones(9)/9^2; % Creation of an average filter
    filtred_mask = conv2(first_mask, K); % Filtering the mask
    figure, imagesc(filtred_mask), colormap gray, title(['Result of the segmentation after the convolution with the filter for frame ', num2str(numFrame)])
    
    seg = filtred_mask > threshold_min & filtred_mask < threshold_max; % Thresholding the filtered mask
end

% Detectin the object:
function detect_car(Img, seg, numFrame)

    properties = regionprops(seg, 'Area','Centroid','BoundingBox');
    
    imagesc(Img), colormap gray, title(['Frame ', num2str(numFrame)])
    hold on
    
    for i = 1:length(properties)
        if properties(i).Area > 300 % Discard too small areas
            x_centroid = floor(properties(i).Centroid(1));
            y_centroid = floor(properties(i).Centroid(2));
            ul_corner_width = properties(i).BoundingBox;
            plot(x_centroid, y_centroid, '*r') % Drowing a red * in the position of the centroid
            hold on
            rectangle('Position', ul_corner_width, 'EdgeColor', 'r', 'LineWidth', 2) % Drowing a red rectangle
        end
    end
end