clear
clc

a = arduino('COM5', 'Nano3'); % or use COM port
max_samples = 300; % how many times do we check the sound sensor?
filter_size = 5;
tic %start timer

sound_data = zeros(1, max_samples); % preallocate arrays for speed
time_data = zeros(1, max_samples);
avg_sound_data = zeros(1, max_samples - filter_size);

for i = 1:max_samples
    sound_data(i) = readVoltage(a, 'A2');
    time_data(i) = toc;

    % Only calculate moving average once we have enough samples
    if i > filter_size
        avg_sound_data(i - filter_size) = mean(sound_data(i-filter_size+1:i));
    end
end

plot(time_data(filter_size+1:end), avg_sound_data);
xlabel('Time (s)');
ylabel('Average Sound Voltage');