
gf = figure(1);
hold on;
grid on;
axis([min(x), max(x), min(v), max(u(x))]);
plot(x, v, 'linewidth', 1)
plot(x, u(x), 'r', 'linewidth', 1);
%x1 = [1e-5, 1e-3];
%y1 = [10e-8, 2e-3 + 1e-8 - 2e-5];
%loglog(hi, delta, 'linewidth', 2);
%plot(x1, y1, 'k', 'linewidth', 2);
legend('v', 'u');
xlabel('x');
ylabel('y');
title('O(h^2) approximation (100 nodes)');
print(gf, "pic/h2_100",'-djpg');
