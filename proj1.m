% Read the image
img = imread('coins.jpeg'); % Replace 'coins.jpg' with your image file

% Convert to grayscale
grayImg = rgb2gray(img);

% Apply a threshold to create a binary image
% You can adjust the threshold value as needed
binaryImg = imbinarize(grayImg);
% Apply Median Filter
filteredImage = medfilt2(grayImg, [3 3]);

% Clean up the image using morphological operations
% Remove small objects (noise)
cleanedImg = bwareaopen(binaryImg, 50); % Adjust the size as needed

% Label connected components
[labeledImg, numCoins] = bwlabel(cleanedImg);

% Display the results
fprintf('Number of coins detected: %d\n', numCoins);

% Optionally, display the original image with the detected coins
imshow(img);
hold on;
% Get the properties of the labeled regions
stats = regionprops(labeledImg, 'Centroid');
for k = 1:numCoins
    c = stats(k).Centroid;
    plot(c(1), c(2), 'r*', 'MarkerSize', 10); % Mark the centroids of coins
end
hold off;