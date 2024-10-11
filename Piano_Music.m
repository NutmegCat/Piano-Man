% Part 3: Threshold and Filter Data
clear
clc
% Connect to the Arduino
a = arduino('COM5', 'Nano3'); % Adjust the COM port as needed

% Initialize parameters
max_samples = 300; % Number of samples to collect
filter_size = 5; % Window size for the moving average filter
threshold = 1.5; % Threshold value for sound data
tic; % Start timer

% Read data from the sound sensor
for i = 1:max_samples
    sound_data(i) = readVoltage(a, 'A2'); % Read sound sensor values
    time_data(i) = toc; % Record the elapsed time
end

% Apply moving average filter
for i = 1:(max_samples - filter_size)
    avg_sound_data(i) = mean(sound_data(i:i + filter_size)); % Calculate moving average
end

% Apply threshold filter
for i = 1:length(avg_sound_data)
    if avg_sound_data(i) > threshold
        thresholded_data(i) = 1; % Set to 1 if above threshold
    else
        thresholded_data(i) = 0; % Set to 0 if below threshold
    end
end

% Plot the thresholded data
figure;
plot(time_data(1:end-filter_size), thresholded_data);
axis([min(time_data) max(time_data) 0 1]); % Adjust the y-axis for binary data
xlabel('Time (s)');
ylabel('Binary Sound Signal (0 or 1)');
title('Thresholded and Filtered Piano Sound Data');
