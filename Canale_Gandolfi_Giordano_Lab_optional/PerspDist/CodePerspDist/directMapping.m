function [I2] = directMapping(I1, H)

I2 = zeros(size(I1));

for rr=1:size(I1,1)
    for cc=1:size(I1,2)
        coords = H*[cc rr 1]';
        coords = floor(coords./coords(3));
        new_row = coords(2);
        new_col = coords(1);
        if ( new_row > 0) && (new_row < size(I1,1)) && (new_col > 0) && (new_col < size(I1,2))
            I2(new_row, new_col,:) = I1(rr,cc, :); 
        end
    end
end

