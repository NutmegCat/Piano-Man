clear 
clc

a = arduino('COM5', 'Nano3'); % or use COM port
tic %start timer
max_samples = 300; % how many times do we check the sound sensor?
filter_size = 5;
tic %start timer
for i = 1:max_samples
    sound_data(i) = readVoltage(a,'A2')
    time_data(i) = toc;
end
plot(time_data, sound_data)
% put labels on your graph.
% Now, add filtering to the data.
% plot the filtered data.