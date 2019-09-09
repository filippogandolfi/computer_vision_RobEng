function [I2] = inverseMapping(I1, H)

I2 = zeros(size(I1));

for rr=1:size(I1,1)
    for cc=1:size(I1,2)
        
        coords = inv(H)*[cc rr 1]';
        
        coords = coords./coords(3);
        new_row = coords(2);
        new_col = coords(1);
        
        ymin = floor(new_col);
        ymax = ymin + 1;
        xmin = floor(new_row);
        xmax = xmin + 1;
        
        % Computing distances a & b needed to use bilinear interpolation
        b = ( new_col - ymin );
        a = ( new_row - xmin );
        
                
        % Check if new coordinates are included in the range
        if ( xmin > 0) && (xmax < size(I1,1)) && (ymin > 0) && (ymax < size(I1,2))
            % Compute the new value for the output pixel, according to the given formula                   
            I2(rr,cc,:)= (1 - a)*(1 - b)*I1(xmin,ymin,:)+a*(1-b)*I1(xmax,ymin,:)+a*b*I1(xmax,ymax,:)+(1-a)*b*I1(xmin,ymax,:);      
        end
    end
end