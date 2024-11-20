% Edge Detection Using Otsu's Method

% Read the input image
image = imread('path_to_your_image.jpg'); % Replace with your image path
if size(image, 3) == 3
    image = rgb2gray(image); % Convert to grayscale if RGB
end

% Step 1: Compute Histogram
image = double(image);
[hist_counts, bin_centers] = hist(image(:), 0:255); % Compute histogram for pixel intensities

% Step 2: Normalize histogram to get class probabilities
total_pixels = numel(image);
class_probabilities = hist_counts / total_pixels;

% Step 3: Compute class means and global mean
total_sum = sum(bin_centers .* class_probabilities);
background_weight = cumsum(class_probabilities); % Cumulative sum for background
foreground_weight = 1 - background_weight; % For foreground

background_mean = cumsum(class_probabilities .* bin_centers) ./ background_weight;
foreground_mean = (total_sum - cumsum(class_probabilities .* bin_centers)) ./ foreground_weight;

% Step 4: Compute Between-Class Variance for each threshold
between_class_variance = (background_weight .* foreground_weight) .* (background_mean - foreground_mean).^2;

% Step 5: Find optimal threshold (maximize between-class variance)
[~, optimal_threshold] = max(between_class_variance);

% Step 6: Apply the optimal threshold for edge detection
edge_image = image >= optimal_threshold;

% Display Results
figure;
subplot(1, 2, 1);
imshow(uint8(image));
title('Original Image');

subplot(1, 2, 2);
imshow(edge_image);
title('Edges Detected with Otsu Threshold');
