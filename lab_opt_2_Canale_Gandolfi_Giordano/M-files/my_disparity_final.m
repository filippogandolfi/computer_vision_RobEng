function disparityMap = my_disparity_final(I1, I2, W, dmin, dmax)

% This function computes left-right disparity map
Dlr = my_disparity(I1, I2, W, dmin, dmax);

% Show the left-right disparity map
marker_idx = (Dlr == -realmax('single'));
Dlr(marker_idx) = min(Dlr(~marker_idx));
figure; imshow(mat2gray(Dlr)), title('Left-right disparity map');
colormap jet; colorbar;

% This function computes right-left disparity map
Drl = my_disparity(I2, I1, W, -dmax, -dmin);

% Show the right-left disparity map
marker_idx = (Drl == -realmax('single'));
Drl (marker_idx) = min(Drl(~marker_idx));
figure; imshow(mat2gray(Drl)), title('Right-left disparity map');
colormap jet; colorbar;

disparityMap = zeros(size(I1));
for r = 1 : length(disparityMap(:,1))
    for c = 1 : (length(disparityMap(1,:))-dmax) 
        
        if Dlr(r,c) == - Drl(r,c+(Dlr(r,c)))
            disparityMap(r,c) = Dlr(r,c);
        else
            disparityMap(r,c) = -realmax('single');
        end

    end
end