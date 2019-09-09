%% Computer Vision Lab 1
% Francesca Canale, Filippo Gandolfi, Marco Giordano

% Loading images
img1=imread('boccadasse.jpg','jpg');
figure
imagesc(img1), title('Boccadasse: Original')
img1_gray=rgb2gray(img1);
figure
imagesc(img1_gray), colormap gray, title('Boccadasse: Gray')

img2=imread('flower.jpg','jpg');
figure
imagesc(img2), title('Flower: Original')
img2_gray=rgb2gray(img2);
figure
imagesc(img2_gray),colormap gray, title('Flower: Gray')

% Performing Transaltion
img1_transl = translation(img1_gray, 100, 150);
figure
imagesc(img1_transl), colormap gray, title('Boccadasse: Translation')

img2_transl = translation(img2_gray, 70, 50);
figure
imagesc(img2_transl), colormap gray, title('Flower: Translation')

% Performing Rotation
img1_rot = rotation(img1_gray, pi/2);
figure
imagesc(img1_rot), colormap gray, title('Boccadasse: Rotation')

img2_rot = rotation(img2_gray, pi/4);
figure
imagesc(img2_rot), colormap gray, title('Flower: Rotation')


%%Functions used
% Translation: with this function the single channel input image is 
% transalted of xTransaltion along x-axis and of yTranslation along y-axis.
function traslatedImg = translation(Img, xTranslation, yTranslation)

    [row,col] = size(Img);
    [X,Y] = meshgrid(1:col,1:row); % Domain of the warped image

    % Inverse function:
    Xt = (X - xTranslation); 
    Yt = (Y - yTranslation); % Domain of the original image

    traslatedImg = griddata(X,Y,double(Img),Xt,Yt,'linear');
end

% Rotation: with this function the single channel input image is rotated of
% theta around the center of the image.
function rotatedImg = rotation(Img, theta)

    [row,col] = size(Img);
    [X,Y] = meshgrid(1:col,1:row); % Domain of the warped image
    
    % Changing center of rotation:
    Xc = X - floor(col/2);
    Yc = Y - floor(row/2);
    
    % Inverse function and repositioning of the center of rotation:
    Xt = (Xc*cos(-theta) - Yc*sin(-theta)) + floor(col/2);
    Yt = (Xc*sin(-theta) + Yc*cos(-theta)) + floor(row/2); % Domain of the original image

    rotatedImg = griddata(X,Y,double(Img),Xt,Yt,'linear');
end