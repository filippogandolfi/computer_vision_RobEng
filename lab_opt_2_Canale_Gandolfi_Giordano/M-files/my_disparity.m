function disparityMap = my_disparity(I1, I2, W, dmin, dmax)
% This function comutes disparity map
% WxW image patches (dimension for the ssd)
% [dmin, dmax] range value for disparity

% Assuming image pair same size
halfW = floor(W/2);
drange = dmax-dmin;

offset = -dmin;

rowend = length(I1(:,1))-halfW;
colend = length(I1(1,:))-halfW-abs(dmax);

disparityMap = zeros(size(I1));
for r = halfW+1: rowend
    for c = abs(offset)+halfW+1 : colend
        dvec = zeros(drange,1);
        N1 = I1(r-halfW:r+halfW, c-halfW:c+halfW);
        for d=dmin:dmax
            
            N2 = I2(r-halfW:r+halfW, c+d-halfW:c+d+halfW);
            dvec(d+offset+1) = -my_ssd(N1,N2);

         
        end
            % Assign the maximum similarity point to D(r,c)
            % If all the values of dvec are equal we choose as correspondence 
            % point for (r,c) the point (r,c) in the other image
             if range(dvec) == 0  
                disparityMap(r,c) = 0;
             else
                [~, argmax] = max(dvec);
               
                disparityMap(r,c) = argmax+dmin-1;
             end
    
    end
end

end