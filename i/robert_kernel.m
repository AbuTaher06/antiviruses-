% Read the input image
image = imread('path_to_your_image.jpg'); % Replace with your image path
if size(image, 3) == 3
    image = rgb2gray(image); % Convert to grayscale
end

% Convert image to double for calculations
image = double(image);

% Define Robert Cross Kernels
Gx = [1 0; 0 -1];
Gy = [0 1; -1 0];

% Get image dimensions
[rows, cols] = size(image);

% Initialize gradient matrices
gradient_x = zeros(rows - 1, cols - 1);
gradient_y = zeros(rows - 1, cols - 1);
gradient_magnitude = zeros(rows - 1, cols - 1);

% Perform manual convolution
for i = 1:rows-1
    for j = 1:cols-1
        % Extract 2x2 region
        region = image(i:i+1, j:j+1);
        
        % Apply kernels
        gradient_x(i, j) = sum(sum(region .* Gx));
        gradient_y(i, j) = sum(sum(region .* Gy));
        
        % Compute gradient magnitude
        gradient_magnitude(i, j) = sqrt(gradient_x(i, j)^2 + gradient_y(i, j)^2);
    end
end

% Normalize gradient magnitude to 0-255
gradient_magnitude = uint8(255 * gradient_magnitude / max(gradient_magnitude(:)));

% Display results
figure;
subplot(1, 2, 1);
imshow(uint8(image));
title('Original Image');

subplot(1, 2, 2);
imshow(gradient_magnitude);
title('Edges Detected (Robert Cross)');
