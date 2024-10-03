ts = 1e-9;
T = 1e-5;
tau = 1e-6;
R = 450;
a = 0.5;
C = physconst('LightSpeed');

time = 0:ts:T;
td = 2 * R / C;

signal = (time >= td) & (time <= tau + td);
signal = signal * a;

plot(time, signal, 'LineWidth', 1.5);
title('Radar Transmitted Signal (Rectangular Pulse)');
xlabel('Time');
ylabel('Amplitude');
grid on;
