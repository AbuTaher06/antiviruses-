% Edge Detection Using Canny Method

% Read the input image
image = imread('path_to_your_image.jpg'); % Replace with your image path
if size(image, 3) == 3
    image = rgb2gray(image); % Convert to grayscale if RGB
end

% Step 1: Apply Gaussian filter for noise reduction
sigma = 1; % Standard deviation for Gaussian filter
filter_size = 2 * ceil(3 * sigma) + 1; % Kernel size
gaussian_filter = fspecial('gaussian', filter_size, sigma);
smoothed_image = conv2(double(image), gaussian_filter, 'same');

% Step 2: Compute gradients using Sobel filters
Gx = [-1 0 1; -2 0 2; -1 0 1]; % Sobel X
Gy = [1 2 1; 0 0 0; -1 -2 -1]; % Sobel Y

gradient_x = conv2(smoothed_image, Gx, 'same');
gradient_y = conv2(smoothed_image, Gy, 'same');

gradient_magnitude = sqrt(gradient_x.^2 + gradient_y.^2);
gradient_direction = atan2(gradient_y, gradient_x);

% Step 3: Non-Maximum Suppression
[rows, cols] = size(gradient_magnitude);
nms_image = zeros(rows, cols); % Initialize non-maximum suppression result
angle = gradient_direction * (180 / pi); % Convert to degrees
angle(angle < 0) = angle(angle < 0) + 180;

for i = 2:rows-1
    for j = 2:cols-1
        % Determine neighboring pixels in gradient direction
        if ((angle(i, j) >= 0 && angle(i, j) < 22.5) || (angle(i, j) >= 157.5 && angle(i, j) <= 180))
            neighbors = [gradient_magnitude(i, j-1), gradient_magnitude(i, j+1)];
        elseif (angle(i, j) >= 22.5 && angle(i, j) < 67.5)
            neighbors = [gradient_magnitude(i-1, j+1), gradient_magnitude(i+1, j-1)];
        elseif (angle(i, j) >= 67.5 && angle(i, j) < 112.5)
            neighbors = [gradient_magnitude(i-1, j), gradient_magnitude(i+1, j)];
        else
            neighbors = [gradient_magnitude(i-1, j-1), gradient_magnitude(i+1, j+1)];
        end
        
        % Suppress non-maximum pixels
        if gradient_magnitude(i, j) >= max(neighbors)
            nms_image(i, j) = gradient_magnitude(i, j);
        else
            nms_image(i, j) = 0;
        end
    end
end

% Step 4: Double Thresholding
high_threshold = 0.2 * max(nms_image(:)); % Define high threshold
low_threshold = 0.1 * max(nms_image(:));  % Define low threshold

strong_edges = nms_image >= high_threshold;
weak_edges = (nms_image >= low_threshold) & (nms_image < high_threshold);

% Step 5: Edge Tracking by Hysteresis
output_image = strong_edges;
for i = 2:rows-1
    for j = 2:cols-1
        if weak_edges(i, j) && any(any(strong_edges(i-1:i+1, j-1:j+1)))
            output_image(i, j) = 1;
        end
    end
end

% Display results
figure;
subplot(1, 3, 1);
imshow(uint8(image));
title('Original Image');

subplot(1, 3, 2);
imshow(nms_image, []);
title('Non-Maximum Suppression');

subplot(1, 3, 3);
imshow(output_image);
title('Canny Edge Detection');
