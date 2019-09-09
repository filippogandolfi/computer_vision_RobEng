%% Computer Vision: Lab 3
% Francesca Canale, Filippo Gandolfi, Marco Giordano

% Loading images:
car_image = imread('car.bmp', 'bmp');
figure, imagesc(car_image), colormap gray, title('Original image: car')

cameraman_image = imread('cameraman.tif', 'tif');
figure, imagesc(cameraman_image), colormap gray, title('Original image: cameraman')

boccadasse_color = imread('boccadasse.jpg', 'jpg');
boccadasse_image=rgb2gray(boccadasse_color);
figure, imagesc(boccadasse_image), colormap gray, title('Original image: boccadasse')

%% Laplacian of Gaussian:
Z1 = laplacian_operator(1.5); % Standard deviaton of 1.5
Z2 = laplacian_operator(3); % Standard deviaton of 3

figure
subplot(2, 2, 1)
surf(Z1), title('\sigma = 1.5')
subplot(2, 2, 2)
imagesc(Z1), title('\sigma = 1.5')
subplot(2, 2, 3)
surf(Z2), title('\sigma = 3')
subplot(2, 2, 4)
imagesc(Z2), title('\sigma = 3')
sgtitle('Laplacian operator')

%% Convolution of the image with the Laplacian:
% Car image:
car_convolution_matrix_1 = conv2(car_image, Z1, 'same'); 
car_convolution_matrix_2 = conv2(car_image, Z2, 'same');

figure
pos1 = [0.1 0.3 0.35 0.35];
pos2 = [0.55 0.3 0.35 0.35];
subplot('Position', pos1)
imagesc(car_convolution_matrix_1), colormap gray, title('\sigma = 1.5')
subplot('Position', pos2)
imagesc(car_convolution_matrix_2), colormap gray, title('\sigma = 3')
sgtitle('Laplacian operator and convolution')

% Cameraman image:
cameraman_convolution_matrix_1 = conv2(cameraman_image, Z1, 'same'); 
cameraman_convolution_matrix_2 = conv2(cameraman_image, Z2, 'same');

figure
pos1 = [0.1 0.3 0.35 0.35];
pos2 = [0.55 0.3 0.35 0.35];
subplot('Position', pos1)
imagesc(cameraman_convolution_matrix_1), colormap gray, title('\sigma = 1.5')
subplot('Position', pos2)
imagesc(cameraman_convolution_matrix_2), colormap gray, title('\sigma = 3')
sgtitle('Laplacian operator and convolution')

% Boccadasse image:
boccadasse_convolution_matrix_1 = conv2(boccadasse_image, Z1, 'same'); 
boccadasse_convolution_matrix_2 = conv2(boccadasse_image, Z2, 'same');

figure
pos1 = [0.1 0.3 0.35 0.35];
pos2 = [0.55 0.3 0.35 0.35];
subplot('Position', pos1)
imagesc(boccadasse_convolution_matrix_1), colormap gray, title('\sigma = 1.5')
subplot('Position', pos2)
imagesc(boccadasse_convolution_matrix_2), colormap gray, title('\sigma = 3')
sgtitle('Laplacian operator and convolution')


%% Testing algorithm for edge detection:
% Car image:
car_edge1_1 = edge_detection(0.05, car_convolution_matrix_1); % threshold of 0.05
car_edge1_2 = edge_detection(0.1, car_convolution_matrix_1); % threshold of 0.1
car_edge1_3 = edge_detection(0.5, car_convolution_matrix_1); % threshold of 0.5
car_edge2_1 = edge_detection(0.05, car_convolution_matrix_2); % threshold of 0.05
car_edge2_2 = edge_detection(0.1, car_convolution_matrix_2); % threshold of 0.1
car_edge2_3 = edge_detection(0.5, car_convolution_matrix_2); % threshold of 0.5

figure
subplot(2, 3, 1)
imagesc(car_edge1_1), colormap gray, title('\sigma = 1.5, threshold = 0.05')
subplot(2, 3, 2)
imagesc(car_edge1_2), colormap gray, title('\sigma = 1.5, threshold = 0.1')
subplot(2, 3, 3)
imagesc(car_edge1_3), colormap gray, title('\sigma = 1.5, threshold = 0.5')
subplot(2, 3, 4)
imagesc(car_edge2_1), colormap gray, title('\sigma = 3, threshold = 0.05')
subplot(2, 3, 5)
imagesc(car_edge2_2), colormap gray, title('\sigma = 3, threshold = 0.1')
subplot(2, 3, 6)
imagesc(car_edge2_3), colormap gray, title('\sigma = 3, threshold = 0.5')
sgtitle('Edge detection')

% Cameraman image:
cameraman_edge1_1 = edge_detection(0.05, cameraman_convolution_matrix_1); % threshold of 0.05
cameraman_edge1_2 = edge_detection(0.1, cameraman_convolution_matrix_1); % threshold of 0.1
cameraman_edge1_3 = edge_detection(0.5, cameraman_convolution_matrix_1); % threshold of 0.5
cameraman_edge2_1 = edge_detection(0.05, cameraman_convolution_matrix_2); % threshold of 0.05
cameraman_edge2_2 = edge_detection(0.1, cameraman_convolution_matrix_2); % threshold of 0.1
cameraman_edge2_3 = edge_detection(0.5, cameraman_convolution_matrix_2); % threshold of 0.5

figure
subplot(2, 3, 1)
imagesc(cameraman_edge1_1), colormap gray, title('\sigma = 1.5, threshold = 0.05')
subplot(2, 3, 2)
imagesc(cameraman_edge1_2), colormap gray, title('\sigma = 1.5, threshold = 0.1')
subplot(2, 3, 3)
imagesc(cameraman_edge1_3), colormap gray, title('\sigma = 1.5, threshold = 0.5')
subplot(2, 3, 4)
imagesc(cameraman_edge2_1), colormap gray, title('\sigma = 3, threshold = 0.05')
subplot(2, 3, 5)
imagesc(cameraman_edge2_2), colormap gray, title('\sigma = 3, threshold = 0.1')
subplot(2, 3, 6)
imagesc(cameraman_edge2_3), colormap gray, title('\sigma = 3, threshold = 0.5')
sgtitle('Edge detection')

% Boccadasse image:
boccadasse_edge1_1 = edge_detection(0.05, boccadasse_convolution_matrix_1); % threshold of 0.05
boccadasse_edge1_2 = edge_detection(0.1, boccadasse_convolution_matrix_1); % threshold of 0.1
boccadasse_edge1_3 = edge_detection(0.5, boccadasse_convolution_matrix_1); % threshold of 0.5
boccadasse_edge2_1 = edge_detection(0.05, boccadasse_convolution_matrix_2); % threshold of 0.05
boccadasse_edge2_2 = edge_detection(0.1, boccadasse_convolution_matrix_2); % threshold of 0.1
boccadasse_edge2_3 = edge_detection(0.5, boccadasse_convolution_matrix_2); % threshold of 0.5

figure
subplot(2, 3, 1)
imagesc(boccadasse_edge1_1), colormap gray, title('\sigma = 1.5, threshold = 0.05')
subplot(2, 3, 2)
imagesc(boccadasse_edge1_2), colormap gray, title('\sigma = 1.5, threshold = 0.1')
subplot(2, 3, 3)
imagesc(boccadasse_edge1_3), colormap gray, title('\sigma = 1.5, threshold = 0.5')
subplot(2, 3, 4)
imagesc(boccadasse_edge2_1), colormap gray, title('\sigma = 3, threshold = 0.05')
subplot(2, 3, 5)
imagesc(boccadasse_edge2_2), colormap gray, title('\sigma = 3, threshold = 0.1')
subplot(2, 3, 6)
imagesc(boccadasse_edge2_3), colormap gray, title('\sigma = 3, threshold = 0.5')
sgtitle('Edge detection')


%% Comparison with function edge('log'...):
% Car image:
[function_edge_car, threshold_check] = edge(car_image, 'log'); % To check the value of threshold

Z3 = laplacian_operator(2); % The defalut value of sigma for function edge() of Matlab is 2
car_convolution = conv2(car_image, Z3, 'same'); 
our_algorithm_car = edge_detection(0.0029, car_convolution); % Threshold of 0.0029 is the value of threshold_check

figure
pos1 = [0.1 0.3 0.35 0.35];
pos2 = [0.55 0.3 0.35 0.35];
subplot('Position', pos1)
imagesc(our_algorithm_car), colormap gray, title('Algorithm implemented')
subplot('Position', pos2)
imagesc(function_edge_car), colormap gray, title('Function edge()')
sgtitle('Comparison')

% Cameraman image:
[function_edge_cameraman, threshold_check] = edge(cameraman_image, 'log'); % To check the value of threshold

Z4 = laplacian_operator(2); % The defalut value of sigma for function edge() of Matlab is 2
cameraman_convolution = conv2(cameraman_image, Z4, 'same'); 
our_algorithm_cameraman = edge_detection(0.0051, cameraman_convolution); % Threshold of 0.0051 is the value of threshold_check

figure
pos1 = [0.1 0.3 0.35 0.35];
pos2 = [0.55 0.3 0.35 0.35];
subplot('Position', pos1)
imagesc(our_algorithm_cameraman), colormap gray, title('Algorithm implemented')
subplot('Position', pos2)
imagesc(function_edge_cameraman), colormap gray, title('Function edge()')
sgtitle('Comparison')

% Boccadasse image:
[function_edge_boccadasse, threshold_check] = edge(boccadasse_image, 'log'); % To check the value of threshold

Z5 = laplacian_operator(2); % The defalut value of sigma for function edge() of Matlab is 2
boccadasse_convolution = conv2(boccadasse_image, Z5, 'same'); 
our_algorithm_boccadasse = edge_detection(0.0063, boccadasse_convolution); % Threshold of 0.0063 is the value of threshold_check

figure
pos1 = [0.1 0.3 0.35 0.35];
pos2 = [0.55 0.3 0.35 0.35];
subplot('Position', pos1)
imagesc(our_algorithm_boccadasse), colormap gray, title('Algorithm implemented')
subplot('Position', pos2)
imagesc(function_edge_boccadasse), colormap gray, title('Function edge()')
sgtitle('Comparison')


%% Functions:
% Laplacian of Gaussian operator:
function laplacian_matrix = laplacian_operator(st_dev)
    sp_supp = ceil(st_dev * 3);  % Half length of kernel should be 3 times the standard deviation
    [X, Y] = meshgrid(-sp_supp : sp_supp);
    laplacian_matrix = ( 1/( 2 * pi * st_dev^2)) * (( X.^2 + Y.^2 - 2 * st_dev^2)/ st_dev^4).* exp( -( X.^2 + Y.^2)/( 2 * st_dev^2));    
end

% Edge detection on the location of the zerocrossing:
function  edge_matrix = edge_detection (threshold, conv_matrix)
    [row, col] = size(conv_matrix);
    edge_matrix = zeros(row, col); % Initialization of the matrix
    
    % Scan along each row, record an edge point at the location of the zerocrossing
    for r = 1 : row
        for c = 1 : col-1
            % Transition {+-}
            if (conv_matrix(r, c) > threshold && conv_matrix(r, c+1) < -threshold)
                edge_matrix(r, c) = 1;
            % Transition {-+}
            elseif (conv_matrix(r, c) < -threshold && conv_matrix (r, c+1) > threshold)
                edge_matrix(r, c) = 1;
            end
        end
    end
    
    % Scan along each coloumn, record an edge point at the location of the zerocrossing
    for r = 1 : row-1
        for c = 1 : col
            % Transition {+-}
            if (conv_matrix(r, c) > threshold && conv_matrix(r+1, c) < -threshold)
                edge_matrix(r, c) = 1;
            % Transition {-+}
            elseif (conv_matrix(r, c) < -threshold && conv_matrix (r+1, c) > threshold)
                edge_matrix(r, c) = 1;
            end
        end
    end
end