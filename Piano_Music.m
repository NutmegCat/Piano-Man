clear
clc

a = arduino('COM5', 'Nano3'); % or use COM port
tic %start timer
max_samples = 300; % how many times do we check the sound sensor?
filter_size = 5;
tic %start timer

for i = 1:(max_samples-filter_size)
    sound_data(i) = readVoltage(a,'A2');
    time_data(i) = toc;
    avg_sound_data(i) = mean(sound_data(i:i+filter_size));
end

plot(time_data, avg_sound_data)