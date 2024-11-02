clear all;

X = imread("./data/IC.png");
Y = imread("./data/PCB.jpg");

% Display images
figure; imshow(X); title('Image X');
figure; imshow(Y); title('Image Y');
hold on
% Convert to grayscale if needed
if size(X, 3) == 3
    X = rgb2gray(X);
end
if size(Y, 3) == 3
    Y = rgb2gray(Y);
end

% Compute normalized cross-correlation
correlationMatrix = normxcorr2(X, Y);

% Display the correlation surface
% figure; surf(correlationMatrix); shading flat;
% title('Normalized Cross-Correlation');

% Rotate X by 180 degrees and compute correlation
X_rotated = imrotate(X, 180);
correlationMatrix_rotated = normxcorr2(X_rotated, Y);

% Display the correlation surface for rotated image
% figure; surf(correlationMatrix_rotated); shading flat;
% title('Normalized Cross-Correlation with Rotated X');

% Threshold for significant matches
threshold = 0.7;

% Find local maxima in the correlation matrix
localMaxima1 = imregionalmax(correlationMatrix);
localMaxima2 = imregionalmax(correlationMatrix_rotated);

% Apply the threshold to keep only significant local maxima
significantLocalMaxima1 = localMaxima1 & (correlationMatrix > threshold);
significantLocalMaxima2 = localMaxima2 & (correlationMatrix_rotated > threshold);

% Adjust coordinates to account for padding
X_size = size(X);
[rows1, cols1] = find(significantLocalMaxima1);
[rows1_adj, cols1_adj] = deal(rows1 - X_size(1) + 1, cols1 - X_size(2) + 1);

[rows2, cols2] = find(significantLocalMaxima2);
[rows2_adj, cols2_adj] = deal(rows2 - X_size(1) + 1, cols2 - X_size(2) + 1);

% Retrieve values of these local maxima
values1 = correlationMatrix(significantLocalMaxima1);
values2 = correlationMatrix_rotated(significantLocalMaxima2);

% Filter out values below threshold again if needed
significant_idx1 = values1 > threshold;
rows1_adj = rows1_adj(significant_idx1);
cols1_adj = cols1_adj(significant_idx1);
values1 = values1(significant_idx1);

significant_idx2 = values2 > threshold;
rows2_adj = rows2_adj(significant_idx2);
cols2_adj = cols2_adj(significant_idx2);
values2 = values2(significant_idx2);

% Display results
fprintf('Coordinates and values of significant local maxima:\n');
for i = 1:length(rows1_adj)
    fprintf('Location1 (%d, %d): %.2f\n', rows1_adj(i), cols1_adj(i), values1(i));
end
for j = 1:length(rows2_adj)
    fprintf('Location2 (%d, %d): %.2f\n', rows2_adj(j), cols2_adj(j), values2(j));
end


% Draw blue rectangles on Y at high-correlation locations
for i = 1:length(rows1_adj)
    % Define the position for the rectangle
    pos = [cols1_adj(i), rows1_adj(i), X_size(2), X_size(1)]; % [x, y, width, height]

    % Draw the rectangle with a blue border
    rectangle('Position', pos, 'EdgeColor', 'b', 'LineWidth', 2);
end
hold off