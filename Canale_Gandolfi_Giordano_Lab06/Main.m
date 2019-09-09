%% Computer Vision Lab 6:
% Francesca Canale, Filippo Gandolfi, Marco Giordano

% Loading the images:
img1 = imread('Mire/Mire1.pgm');
img2 = imread('Mire/Mire2.pgm');
% img1 = imread('Rubik/Rubik1.pgm');
% img2 = imread('Rubik/Rubik2.pgm');

% Showing the images:
figure, imshow([img1 img2]);

% Loading corresponding points:
p1 = load('Mire/Mire1.points')';
p2 = load('Mire/Mire2.points')';
% p1 = load('Rubik/Rubik1.points')';
% p2 = load('Rubik/Rubik2.points')';

n_points = length(p1(1, :)); % Number of points

p1 = [p1; ones(1, n_points)]; % Adding a row of ones at the points matrix
p2 = [p2; ones(1, n_points)]; % Adding a row of ones at the points matrix

% Eight point algorithm function (version1)
F1 = EightPointsAlgorithm(p1, p2);

% Eight point algorithm function (version2)
F2 = EightPointsAlgorithmN(p1, p2);

% Evaluation of the results:
result_1 = zeros(n_points, 1);
result_2 = zeros(n_points, 1);
for i = 1 : n_points
    result_1(i) = p2(:, i)'* F1* p1(:, i); % Checking epipolar constraint for version 1
    result_2(i) = p2(:, i)'* F2* p1(:, i); % Checking epipolar constraint for version 2
end

visualizeEpipolarLines(img1, img2, F1, p1(1:2, :)', p2(1:2, :)')
visualizeEpipolarLines(img1, img2, F2, p1(1:2, :)', p2(1:2, :)')

[U1, D, V1] = svd(F1);
rEpiPoles1 = U1(:,end) % Compute right epipoles
lEpiPoles1 = V1(:,end) % Compute left epipoles

[U2, D, V2] = svd(F2);
rEpiPoles2 = U2(:,end) % Compute right epipoles
lEpiPoles2 = V2(:,end) % Compute left epipoles

% Adding a wrong corresponding points to test RANSAC method
p1mat = [p1 , [600; 600; 1]] ;
p2mat = [p2 , [0; 0; 1]] ;

[matlabF] = estimateFundamentalMatrix(p1mat(1:2,:)', p2mat(1:2,:)', 'Method','RANSAC' );

visualizeEpipolarLines(img1, img2, matlabF, p1mat(1:2,:)', p2mat(1:2,:)')



