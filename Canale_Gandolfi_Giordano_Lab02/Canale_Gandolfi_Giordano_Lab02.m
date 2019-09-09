%% Computer Vision: Lab 2
% Francesca Canale, Filippo Gandolfi, Marco Giordano

% Loading image:
img = imread('i235.png', 'png');
figure
imagesc(img), colormap gray, title('Original image')
figure, imhist(uint8(img), 256), title('Histogram: Original image') % displaying histogram

% Adding gaussian noise:
imgG = gaussian(img, 20); % 20 is the standard deviation
figure, imagesc(imgG), colormap gray, title('Gaussian noise')
figure, imhist(uint8(imgG), 256), title('Histogram: Gaussian noise') % displaying histogram
xlabel('Gray scale'), ylabel('Number of pixel')

% Adding salt and pepper noise:
imgSP = salt_pepper(img, 0.2); % 20% is the noise density
figure, imagesc(imgSP), colormap gray, title('Salt and pepper noise')
figure, imhist(uint8(imgSP), 256), title('Histogram: Salt and pepper noise') % displaying histogram
xlabel('Gray scale'), ylabel('Number of pixel')

% Filtering with moving average:
filter1_moveav_3 = moving_average(imgG, 3); % 3x3 pixels
figure, imagesc(filter1_moveav_3), colormap gray, title('Smoothing gaussian noise by averaging (3x3)')
figure, imhist(uint8(filter1_moveav_3), 256), title('Histogram: smoothing gaussian noise by averaging (3x3)') % displaying histogram
xlabel('Gray scale'), ylabel('Number of pixel')

filter1_moveav_7 = moving_average(imgG, 7); % 7x7 pixels
figure, imagesc(filter1_moveav_7), colormap gray, title('Smoothing gaussian noise by averaging (7x7)')
figure, imhist(uint8(filter1_moveav_7),256), title('Histogram: smoothing gaussian noise by averaging (7x7)') % displaying histogram
xlabel('Gray scale'), ylabel('Number of pixel')

filter2_moveav_3 = moving_average(imgSP, 3); % 3x3 pixels
figure, imagesc(filter2_moveav_3), colormap gray, title('Smoothing salt and pepper noise by averaging (3x3)')
figure, imhist(uint8(filter2_moveav_3), 256), title('Histogram: smoothing salt and pepper noise by averaging (3x3)') % displaying histogram
xlabel('Gray scale'), ylabel('Number of pixel')

filter2_moveav_7 = moving_average(imgSP, 7); % 7x7 pixels
figure, imagesc(filter2_moveav_7), colormap gray, title('Smoothing salt and pepper noise by averaging (7x7)')
figure, imhist(uint8(filter2_moveav_7),256), title('Histogram: smoothing salt and pepper noise by averaging (7x7)') % displaying histogram
xlabel('Gray scale'), ylabel('Number of pixel')

% Filtering with low-pass Gaussian filter:
filter1_gaussian = gaussian_f(imgG, 7); 
figure, imagesc(filter1_gaussian), colormap gray, title('Smoothing gaussian noise by gaussian filter')
figure, imhist(uint8(filter1_gaussian), 256), title('Histogram: smoothing gaussian noise by gaussian filter') % displaying histogram
xlabel('Gray scale'), ylabel('Number of pixel')

filter2_gaussian = gaussian_f(imgSP, 7); 
figure, imagesc(filter2_gaussian), colormap gray, title('Smoothing salt and pepper noise by gaussian filter')
figure, imhist(uint8(filter2_gaussian), 256), title('Histogram: smoothing salt and pepper noise by gaussian filter') % displaying histogram
xlabel('Gray scale'), ylabel('Number of pixel')

% Filtering with a median filter:
filter1_median = median_f(imgG, 3);
figure, imagesc(filter1_median), colormap gray, title('Smoothing gaussian noise by median filter')
figure, imhist(uint8(filter1_median), 256), title('Histogram: smoothing gaussian noise by median filter') % displaying histogram
xlabel('Gray scale'), ylabel('Number of pixel')

filter2_median = median_f(imgSP, 3);
figure, imagesc(filter2_median), colormap gray, title('Smoothing salt and pepper noise by median filter')
figure, imhist(uint8(filter2_median), 256), title('Histogram: smoothing salt and pepper noise by median filter') % displaying histogram
xlabel('Gray scale'), ylabel('Number of pixel')

% Impulse filter (slide 40):
filter1_linear1 = linear_f(imgG, 7, 1);
figure, imagesc(filter1_linear1), colormap gray, title('Smoothing gaussian noise with impulse filter')
figure, imhist(uint8(filter1_linear1), 256), title('Histogram: smoothing gaussian noise with impulse filter') % displaying histogram

filter2_linear1 = linear_f(imgSP, 7, 1);
figure, imagesc(filter2_linear1), colormap gray, title('Smoothing salt and pepper noise with impulse filter')
figure, imhist(uint8(filter2_linear1), 256), title('Histogram: smoothing salt and pepper noise with impulse filter') % displaying histogram

% Shifted right filter (slide 41):
filter1_linear2 = linear_f(imgG, 7, 2);
figure, imagesc(filter1_linear2), colormap gray, title('Smoothing gaussian noise with shifted right filter')
figure, imhist(uint8(filter1_linear2), 256), title('Histogram: smoothing gaussian noise with shifted right filter') % displaying histogram

filter2_linear2 = linear_f(imgSP, 7, 2);
figure, imagesc(filter2_linear2), colormap gray, title('Smoothing salt and pepper noise with shifted right filter')
figure, imhist(uint8(filter2_linear2), 256), title('Histogram: smoothing salt and pepper noise with shifted right filter') % displaying histogram

% Sharpening filter (slide 43):
filter1_linear3 = linear_f(imgG, 7, 3);
figure, imagesc(filter1_linear3), colormap gray, title('Smoothing gaussian noise with sharpening filter')
figure, imhist(uint8(filter1_linear3), 256), title('Histogram: smoothing gaussian noise with sharpening filter') % displaying histogram

filter2_linear3 = linear_f(imgSP, 7, 3);
figure, imagesc(filter2_linear3), colormap gray, title('Smoothing salt and pepper noise with sharpening filter')
figure, imhist(uint8(filter2_linear3), 256), title('Histogram: smoothing salt and pepper noise with sharpening filter') % displaying histogram

% Mesh of the original image
figure, mesh(img), title('Image without FFT')

% Shift the zero frequencies component to center of spectrum of the image
FZ = fftshift(fft2(img));
figure, imagesc(abs(FZ)), colormap gray, title('Image FFT')
figure, mesh(abs(FZ)), title('Image FFT')

% Shift the zero frequencies component to center of spectrum of a low-pass 
% Gaussian filter (101x101 pixels with sigma = 5).  
FH = fspecial('gaussian', 101, 5);
FFZ = fftshift(fft2(FH));
figure, imagesc(abs(FFZ)), colormap gray, title('Gauss FFT')
figure, mesh(abs(FFZ)), title('Gauss FFT')


%% Functions:
% Gaussian noise:
function noise_gaussian = gaussian(Img, st_dev)
    noise_gaussian = double(Img) + st_dev * randn(size(Img));
end

% Salt and pepper noise:
function noise_sp = salt_pepper(Img, density)
    Img = double(Img);
    [rr, cc] = size(Img);
    maxv = max(max(Img));
    indices = full(sprand(rr, cc, density)); 
    mask1 = indices > 0 & indices < 0.5;  mask2 = indices >= 0.5; % matlab masking technique
    noise_sp = Img.*(~mask1) ;
    noise_sp = noise_sp.*(~mask2) + maxv * mask2;
end

% Moving average filter:
function filter_movav = moving_average(Img, pixel)
    K = ones(pixel)/(pixel^2); 
    filter_movav = conv2(Img, K, 'same');
end

% Gaussian filter:
function filter_gaussian = gaussian_f(Img, fsize)
    sigma = fsize/6; % The half of the filter size must be three times the standard deviation 
    h = fspecial('gaussian', fsize, sigma);
    figure, imagesc(h), title('Gaussian filter image')
    figure, surf(h), title('Gaussian filter surface')
    filter_gaussian = imfilter(Img, h); % applying filter to the image
end

% Median filter:
function filter_median = median_f(Img, fsize)
    filter_median = medfilt2(Img, [fsize, fsize]);
end

% Linear filters
function imgFiltered = linear_f(Img, filterSize, method)
    switch method
        case 1 % Impulse filter
            center = ceil(filterSize/2);
            Kernel = zeros(filterSize);       
            Kernel(center, center) = 1;
        
        case 2 % Shifted right filter
            center = ceil(filterSize/2);
            Kernel = zeros(filterSize);       
            Kernel(center, filterSize) = 1;

        case 3 % Sharpening filter
            center = ceil(filterSize/2);
            Kernel = zeros(filterSize);       
            Kernel(center, center) = 2;
            Kernel = Kernel - (ones(filterSize)/(filterSize^2));

        otherwise
            disp('ERROR: Insert method between 1 and 3')
            return
        
    end
    imgFiltered = conv2 (Img, Kernel, 'same');
end
