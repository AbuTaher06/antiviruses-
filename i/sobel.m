% Edge Detection Using Sobel Kernel

% Read the input image
image = imread('path_to_your_image.jpg'); % Replace with your image path
if size(image, 3) == 3
    image = rgb2gray(image); % Convert to grayscale if RGB
end

% Convert image to double for calculations
image = double(image);

% Define Sobel Kernels
Gx = [-1 0 1; -2 0 2; -1 0 1]; % Horizontal kernel
Gy = [1 2 1; 0 0 0; -1 -2 -1]; % Vertical kernel

% Get image dimensions
[rows, cols] = size(image);

% Initialize gradient matrices
gradient_x = zeros(rows, cols);
gradient_y = zeros(rows, cols);
gradient_magnitude = zeros(rows, cols);

% Perform convolution (manual)
for i = 2:rows-1
    for j = 2:cols-1
        % Extract 3x3 region
        region = image(i-1:i+1, j-1:j+1);
        
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
subplot(1, 3, 1);
imshow(uint8(image));
title('Original Image');

subplot(1, 3, 2);
imshow(uint8(abs(gradient_x)));
title('Gradient X (Vertical Edges)');

subplot(1, 3, 3);
imshow(gradient_magnitude);
title('Edges Detected (Sobel)');
