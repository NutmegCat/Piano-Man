clear
clc

a = arduino('COM5', 'Nano3'); % or use COM port
max_samples = 1000; % how many times do we check the sound sensor?
filter_size = 5;
tic % start timer

sound_data = zeros(1, max_samples); % preallocate arrays for speed
time_data = zeros(1, max_samples);
avg_sound_data = zeros(1, max_samples - filter_size);

figure; % Create a new figure for plotting
hPlot = plot(nan, nan); % Initialize the plot with empty data
xlabel('Time (s)');
ylabel('Average Sound Voltage');
title('Live Sound Data Plot');
xlim([0, max_samples * 0.1]); % Adjust x-axis limits as necessary
ylim([0, 5]); % Adjust y-axis limits according to your sensor voltage range (0-5V)

for i = 1:max_samples
    sound_data(i) = readVoltage(a, 'A2');
    time_data(i) = toc;

    % Only calculate moving average once we have enough samples
    if i > filter_size
        avg_sound_data(i - filter_size) = mean(sound_data(i-filter_size+1:i));
        
        % Update the plot with new data points
        set(hPlot, 'XData', time_data(filter_size+1:i), 'YData', avg_sound_data(1:i-filter_size));
        drawnow; % Force MATLAB to update the plot immediately
    end
end