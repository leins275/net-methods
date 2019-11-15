
gf = figure(1);
hold on;
grid on;
axis([min(x1), max(x1), min(u(x1)), max(u(x1))]);
plot(x1, u(x1), 'r', 'linewidth', 3);
plot(x, v, 'd','linewidth', 4);

figure;
grid on;
plot(x, abs(u(x) - v), 'k', 'linewidth', 2);
title("FEM, y = x * (1 - x)");
