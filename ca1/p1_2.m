t = 0:0.01:1;
z1 = sin(2 * pi * t);
z2 = cos(2 * pi * t);

x0 = [0.5; 0.25];
y0 = [0.2; -0.8];

% figure;
subplot(1,2,1)
plot(t, z1, '--b')
title('Sin')
grid on
xlabel('time') % the name of X-axis
ylabel('amplitude') % the name of Y-axis
text(x0(1), y0(1), 'sin(2 \pi t)'); % Add comment at (x0, y0)

subplot(1,2,2)
plot(t, z2, 'r')
title('Cos')
grid on
xlabel('time') % the name of X-axis
ylabel('amplitude') % the name of Y-axis
text(x0(2), y0(2), 'cos(2 \pi t)'); % Add comment at (x0, y0)
