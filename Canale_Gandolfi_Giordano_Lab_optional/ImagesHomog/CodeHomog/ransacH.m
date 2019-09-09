function [bestH, consensus, outliers]=ransacH(X1,X2, th)
    P = [X1(1:2,:);X2(1:2,:)];
    ii = 0;
    iter = 100;
    N = size(P, 2);
    sin = [P(1:2, :); ones(1, N)];
    des = [P(3:4, :); ones(1, N)];
    bestH = zeros(3, 3);
    bestNInlier = 0;
    p = 0.999;
    consensus = [];
    outliers = [];
    while ii < iter
        perm = randperm(N);
        M = P(:, perm(1:4)); % select 4 random pairs
        H = my_homography([M(1:2, :);ones(1, 4)], [M(3:4, :);ones(1, 4)]);
        residuals = testH(H, sin, des);
        nInlier = sum(residuals < th) / N; % current estimated inliers
        if(nInlier > bestNInlier) % if number of inliers grows
           bestNInlier = nInlier; % update of the fly the probability of having inliers
           bestH = H; % update the best homography
           consensus = P(:, residuals < th); % inliers
           outliers = P(:, residuals >= th); % outliers
           iter = log(1 - p) / log(1 - bestNInlier.^4); % update the number of iterations needed
        end
        ii = ii + 1;
    end  
end


function [residual] = testH(H, sin, des)
    res = H * sin;
    res(1, :) = res(1, :) ./ res(3, :);
    res(2, :) = res(2, :) ./ res(3, :);
    res(3, :) = res(3, :) ./ res(3, :);
    res = res  - des;
    residual = zeros(size(res, 2), 1);
    for i=1:size(res, 2)
        residual(i) = norm(res(:, i));
    end
    residual = sqrt(residual);
end