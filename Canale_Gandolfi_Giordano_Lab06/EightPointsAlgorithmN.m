function [F] = EightPointsAlgorithmN(P1, P2)

% Normalization of the points
[nP1, T1] = normalise2dpts(P1);
[nP2, T2] = normalise2dpts(P2);

n_points = length(nP1(1,:)); % Computing number of points

A = zeros(n_points, 9); % Initializing matrix A

A = [nP2(1, :)'.*nP1(1, :)', nP2(1, :)'.*nP1(2, :)', nP2(1, :)', nP2(2, :)'.*nP1(1, :)', nP2(2, :)'.*nP1(2, :)', nP2(2, :)', nP1(1, :)', nP1(2, :)', ones(n_points, 1)];

% Computing the SVD of A
[U, D, V] = svd(A);

% Selecting as solution the last coloumn of V
n = length(V(1,:));
f = V(:, n);

% Reshaping coloumn vector f so to obtain matrix F (3X3)
F = reshape(f, 3, 3);
F = F'; % The reshape returns a transposed matrix respect to the wanted matrix F

% Computing th SVD of F
[U, D, V] = svd(F);
D(3, 3) = 0; % Enforcing the rank of F to be 2

% Recomputing final F
F = U * D * V';

% De-normalize the resulting F
F = T2' * F * T1;  

end