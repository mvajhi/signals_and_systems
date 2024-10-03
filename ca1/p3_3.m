ts = 1e-9;
T = 1e-5;
tau = 1e-6;
R = 450;
a = 0.5;
C = physconst('LightSpeed');

time = 0:ts:T;
td = 2 * R / C;

signal = (time >= 0) & (time <= tau);

signalR = (time >= td) & (time <= tau + td);
signalR = signalR * a;

[correlation, lag] = xcorr(received_signal, transmitted_signal);


[~, max_index] = max(correlation);
estimated_delay = lag(max_index) * ts;
estimated_R = (estimated_delay * C) / 2;

figure;
subplot(2,1,1);
plot(time, transmitted_signal, 'b', 'LineWidth', 1.5);
title('Transmitted Signal');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;

subplot(2,1,2);
plot(time, received_signal(1:length(time)), 'r', 'LineWidth', 1.5);
title('Received Signal');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;

figure;
plot(lag * ts * C / 2, correlation, 'k', 'LineWidth', 1.5, ...
    'DisplayName', ['Estimated R = ', num2str(estimated_R), ' m']);
title('Correlation between Transmitted and Received Signals');
xlabel('distance (m)');
ylabel('Correlation Amplitude');
legend;
grid on;

