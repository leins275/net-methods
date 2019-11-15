
gf = figure(1);
hold on;
grid on;
axis([min(x), max(x), min(v), max(u(x))]);
plot(x, v, 'd','linewidth', 2)
plot(x, u(x), 'r', 'linewidth', 1);
plot(x, abs(u(x) - v), 'k', 'linewidth', 2);
