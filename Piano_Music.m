clear
clc

a = arduino('COM5', 'Nano3');

figure
h = animatedline;
ax = gca;
ax.YGrid = 'on';
ax.YLim = [-0.1 5];
title('Sound sensor voltage vs time (live)');
ylabel('Time [HH:MM:SS]');
xlabel('Voltage [volt]');
stop = false;
startTime = datetime('now');
while ~stop
    % Read current voltage value
    voltage = readVoltage(a,'A2');
    % Get current time
    t = datetime('now') - startTime;
    % Add points to animation
    addpoints(h,datenum(t),voltage)
    % Update axes
    ax.XLim = datenum([t-seconds(15) t]);
    datetick('x','keeplimits')
    drawnow
    % Check stop condition (check the button on D6)
    stop = readDigitalPin(a,'D6');
end