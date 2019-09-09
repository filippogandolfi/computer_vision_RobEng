function d = my_ssd(N1,N2)
% this function computes SSD (sum of squared differences) between two
% image patches of the same size

%N1 N2 square and same size
d=sum( sum( (N1-N2).^2) );


