t_1 = 1000:9:1701;
y1 = y(1:50:length(x), t_1);
x1 = x(1:50:length(x));

figure;
[T, X] = meshgrid(t(t_1), x1);
plot3(X, T, y1);


x_1 = [1995, 1997, 1998, 2001];
t1 = t(t_1);
for i=1:4
    figure;
    grid on;
    hold on;
    plot(t(t_1), y1(x_1(i), :));
    plot(t(t_1), u(x1(x_1(i)), t1));
    set(gca,'FontSize',14);
    xlabel('t');
    ylabel('v(x, t)');
    legend({'v(x,t)', 'u(x,t)'});
    legend('boxoff');
    saveas(gcf, sprintf('pic/instable_x=%d', x_1(i)), 'epsc');
end


%{
figure;
hold on;
grid on;
plot(tsm, epsm);
plot([0.9995e-3, 1.0015e-3], [9.98e-4, 10e-4], 'r');
set(gca,'FontSize',14);
legend({'Eps(tau)', 'y = x - 15e-7'}, 'Location', 'northwest');
xlabel('tau');
ylabel('Eps');
saveas(gcf, sprintf('pic/epstau'), 'epsc');
%}

%{
figure;
hold on;
grid on;
plot(tsm, epsm);
plot(tsm, tsm.^2 ./ 4, 'r');
axis([0, 0.09, 0, 2.5e-3]);
set(gca,'FontSize',14);
legend({'Eps(tau)', 'y = x^2 / 4'}, 'Location', 'northwest');
xlabel('tau');
ylabel('Eps');
saveas(gcf, sprintf('pic/epstausym'), 'epsc');
%}


for i=1500:10:1701 % 654
    figure;
    grid on;
    hold on;
    %axis([a, b, min(u(x1, t(i)) - 0.1), max(u(x1, t(i)))+0.1]);
    plot(x1, y1(:, i), 'linewidth', 2);
    plot(x1, u(x1, t(i)), '--r', 'linewidth', 2);
    set(gca,'FontSize',14);
    xlabel('x');
    ylabel('v(x, t)');
    legend({'v(x,t)', 'u(x,t)'}, 'Location', 'southwest');
    legend('boxoff');
    %saveas(gcf, sprintf('pic/exp_d_t=%d', i), 'epsc');
end

