load("p2.mat")

[a, b] = p2_4(x,y)

plot(x, y, '.');
hold on;
plot(x, a * x + b, LineWidth=3);