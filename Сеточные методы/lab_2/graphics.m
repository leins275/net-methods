
figure;
grid on;
% [T, X] = meshgrid(t(1:50:length(t)), x(1:100:length(x)));
[T, X] = meshgrid(t, x);
y1 = y(1:100:length(x), 1:50:length(t));
plot3(X, T, y);

i = 100;
figure;
grid on;
hold on;
plot(x, y(:, i));
plot(x, u(x, t(i)), '-r')
set(gca,'FontSize',18);
xlabel('x');
ylabel('v(x, t)');
s = sprintf('t = %d', i);
title(s)
legend('v(x, t)', 'u(x, t)');

%{
for i=1:100:length(t)
    figure;
    grid on;
    hold on;
    plot(x, y(:, i));
    plot(x, u(x, t(i)), '-r')
end
%}

%{
gf_loglog = figure(5);
hold on;
grid on;
axis([-12, -6, -25, 2]);
set(gca, 'FontSize', 14);
plot(log(hi_1), log(delta_1), '-sb', 'linewidth', 1);
plot(log(hi_2), log(delta_2), '-sr', 'linewidth', 1);
plot([-12, -6], [-14, -8], 'b');
plot([-12, -6], [-25, -13], 'r');
legend('log(||zh||)=k1*log(h)+b1, O(h)', 
       'log(||zh||)=k2*log(h)+b2, O(h^2)',
       'y = x - 2',
       'y = 2x -1');
xlabel('log(h)');
ylabel('log(||zh||)');

gf_1_20 = figure(1);
hold on;
grid on;
axis([a, b, min(y) - 0.1, max(y) + 0.1]);
plot(x_1_20, v_1_20, 'linewidth', 1);
plot(x, y, 'r', 'linewidth', 1);
set(gca,'FontSize',18);
legend('v', 'u');
xlabel('x');
ylabel('y');

gf_1_100 = figure(2);
hold on;
grid on;
axis([a, b, min(y) - 0.1, max(y) + 0.1]);
plot(x_1_100, v_1_100, 'linewidth', 1);
plot(x, y, 'r', 'linewidth', 1);
set(gca,'FontSize',18);
legend('v', 'u');
xlabel('x');
ylabel('y');

gf_2_20 = figure(3);
hold on;
grid on;
axis([a, b, min(y) - 0.1, max(y) + 0.1]);
plot(x_2_20, v_2_20, 'linewidth', 1);
plot(x, y, 'r', 'linewidth', 1);
set(gca,'FontSize',18);
legend('v', 'u');
xlabel('x');
ylabel('y');

gf_2_100 = figure(4);
hold on;
grid on;
axis([a, b, min(y) - 0.1, max(y) + 0.1]);
plot(x_2_100, v_2_100, 'linewidth', 1);
plot(x, y, 'r', 'linewidth', 1);
set(gca,'FontSize',18);
legend('v', 'u');
xlabel('x');
ylabel('y');

% saving plots
print(gf_1_20, "pic/h1_20",'-djpg');
print(gf_1_100, "pic/h1_100",'-djpg');
print(gf_2_20, "pic/h2_20",'-djpg');
print(gf_2_100, "pic/h2_100",'-djpg');
print(gf_loglog, "pic/loglog",'-djpg');
%}
