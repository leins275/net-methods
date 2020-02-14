figure;
[T, X] = meshgrid(t, x);
plot3(X, T, y);

%{
i = 100;
figure;
grid on;
hold on;
plot(x, y(:, i));
plot(x, u(x, t(i)), '-r');
set(gca,'FontSize',18);
xlabel('x');
ylabel('v(x, t)');
title(sprintf('t = %d', i));
legend('v(x, t)', 'u(x, t)');
%}

%{
for i=1:100:length(t)
    figure;
    grid on;
    hold on;
    plot(x, y(:, i));
    plot(x, u(x, t(i)), '-r')
end
%}
