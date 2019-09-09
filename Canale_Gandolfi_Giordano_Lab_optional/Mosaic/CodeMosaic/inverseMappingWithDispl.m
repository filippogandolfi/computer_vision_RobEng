function [M] = inverseMappingWithDispl(I, H, Minit, dx, dy);

pt = zeros(3,1);

for x = -dx+1 : size(Minit, 2)-1
    
    pt(1) = double(x);
    
    for y = -dy+1 : size(Minit, 1)-1
        
        pt(2) = double(y);
        pt(3) = 1.;
        
        ptv = inv(H)*pt;
        
        ptv = ptv./ptv(3);
        
        inf_x = floor(ptv(1)); 
        inf_y = floor(ptv(2));
        sup_x = ceil(ptv(1)); 
        sup_y = ceil(ptv(2));
        
        
        % are we inside the image boundaries? 
        if(inf_x >= 1 && inf_x <= size(I, 2) && sup_x >= 1 && sup_x <= size(I, 2) && ...
                inf_y >= 1 && inf_y <= size(I, 1) && sup_y >= 1 && sup_y <= size(I, 1)) 
            
            if(x+dx >= 1 && x+dx <= size(Minit, 2) && ...
                y+dy >= 1 && y+dy <= size(Minit, 1))
            
                t = ptv(1) - double(inf_x);
                u = ptv(2) - double(inf_y);
                
                Minit(y+dy,x+dx) = (1-t)*(1-u)*I(inf_y,inf_x) + t*(1-u)*I(inf_y,sup_x) + u*(1-t)*I(sup_y,inf_x) + u*t*I(sup_y,sup_x);
                
            end
        end
 
    
    end
    
end

M = Minit;
    
