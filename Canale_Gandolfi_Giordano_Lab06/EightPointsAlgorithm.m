function [F] = EightPointsAlgorithm(P1, P2)

n_points = length(P1(1,:));
A = zeros(n_points, 9); % Initializing matrix A

A = [P2(1, :)'.*P1(1, :)', P2(1, :)'.*P1(2, :)', P2(1, :)', P2(2, :)'.*P1(1, :)', P2(2, :)'.*P1(2, :)', P2(2, :)', P1(1, :)', P1(2, :)', ones(n_points, 1)];

% Computing the SVD of A
[U, D, V] = svd(A);

% Selecting as solution the last coloumn of V
f = V(:, end);

% Reshaping coloumn vector f so to obtain matrix F (3X3)
F = reshape(f, 3, 3);
F = F'; % The reshape returns a transposed matrix respect to the wanted matrix F

% Computing th SVD of F
[U, D, V] = svd(F);
D(3, 3) = 0; % Enforcing the rank of F to be 2

% Recomputing final F
F = U * D * V';

end