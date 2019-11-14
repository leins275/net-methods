problem;

%%%
% build a net
%%%  
n = 1280;
dim = 1;
errCur = 10;
i = 1;
while true  
  [v, x, h] = ... 
  FiniteDiffMethod(n, a, b, dim, alpha, beta, gamma, p, q, f);
  
  errPrew = errCur;
  errCur = norm(abs(v - u(x)), h, n);
  delta(i) = errCur;
  hi(i) = h;
  %{
  disp('----------------------------');
  dim
  n
  h
  errCur
  %}
  
  dim
  hi(i)
  delta(i)
  
  i = i + 1;
  n = n * 2;
  if (errCur >= errPrew)
    break;
  end
end

%{
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
%}

%{
figure;
hold on;
loglog(h, delta, 'linewidth', 2);
x = 0.01:0.01: 0.1;
y = x .* 2 - 0.1;
plot(x, y, 'r')

h
delta
delta = [delta, norm(y - y1, h, n(i))];
hi = [hi, h];
endfor
pp = n = 10:1:100;
figure();
plot(pp, delta);
[min, ind] = min(delta);

hold on;
grid on;
axis([min(x), max(x), min(y1 + y), max(y1 + y)]);
plot(x, y, 'linewidth', 2);
plot(x, y1, 'r', 'linewidth', 2);
legend("v, h = 0.75", "u: y = sin(e^x)");
%}
