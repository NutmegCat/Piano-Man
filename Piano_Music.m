clear all; close all;
a = arduino('COM3', 'Nano3') % or use COM port
tic %start timer
max_samples = 1000; % how many times do we check the sound sensor?
tic %start timer
for i = 1:max_samples
    sound_data(i) = readVoltage(a,'A2')
    time_data(i) = toc;
end
plot(time_data, sound_data)