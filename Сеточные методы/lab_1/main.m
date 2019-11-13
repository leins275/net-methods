problem;

%%%
% build a net
%%%  
n = 20;
dim = 1;
errCur = 10;

while true  
  [v, x, h] = ... 
  FiniteDiffMethod(n, a, b, dim, alpha, beta, gamma, p, q, f);
  
  errPrew = errCur;
  errCur = norm(abs(v - u(x)), h, n);
  
  disp('----------------------------');
  dim
  n
  h
  errCur
  
  n = n * 2;
  if (errCur >= errPrew)
    break;
  end
end

% plot (x, v, 'linewidth', 2,  x, u(x), 'r', 'linewidth', 2);

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
