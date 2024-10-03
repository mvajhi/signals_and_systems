ts = 1e-9;
T = 1e-5;
tau = 1e-6;

time = 0:ts:T;

signal = (time >= 0) & (time <= tau);

plot(time, signal, 'LineWidth', 1.5);
title('Radar Transmitted Signal (Rectangular Pulse)');
xlabel('Time');
ylabel('Amplitude');
grid on;
