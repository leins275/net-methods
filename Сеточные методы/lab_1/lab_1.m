clear all;

% n = 20000;  % num of nodes

a = 0.5;
b = 2.0;
n = [10, 20, 40, 80, 160];
for i = 1: length(n)
  h(i) = (b - a) / n(i);
  x = a : h(i) : b;

  tic;
  y1 = u(x);
  y = FiniteMethod(n(i), a, b, 2);
  % ni = length(x);

  delta(i) = norm(y - y1, h(i), n(i)); 
  time = toc;
  
  h1 = h(i)
  delta1 = delta(i)
end

figure;
hold on;
loglog(h, delta, 'linewidth', 2);
x = 0.01:0.01: 0.1;
y = x .* 2 - 0.1;
plot(x, y, 'r')

% h
% delta
% delta = [delta, norm(y - y1, h, n(i))];
% hi = [hi, h];
% endfor
% pp = n = 10:1:100;
% figure();
% plot(pp, delta);
% [min, ind] = min(delta);

%hold on;
%grid on;
%axis([min(x), max(x), min(y1 + y), max(y1 + y)]);
%plot(x, y, 'linewidth', 2);
%plot(x, y1, 'r', 'linewidth', 2);
%legend("v, h = 0.75", "u: y = sin(e^x)");

