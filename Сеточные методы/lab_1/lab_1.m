clear;
n = 100000;  % num of nodes
a = 0;
b = 2;
h = (b - a) / n;
x = a : h : b;
n = length(x);

m = BuildMatrix_h2(x, h);
for i = 1:n, r(i) = f(x(i)); end
r(1) = sin(1) - cos(1);
r(n) = e ^ 2 * cos(e ^ 2) + sin(e ^ 2);
r = UpdateF(n, m, r);

m = MakeTridiag(n, m);
  
for i = 1:n - 1, b(i) = m(3, i); end
b(n) = 0;
d(1) = 0;  
for i = 2:n, d(i) = m(1, i); end
% y = TrDiagMatrSolve(b, m(2, :), d, r);
y = TrDiagMatrSolve(m(3, :), m(2, :), m(1, :), r);
y1 = u(x);

axis([min(x), max(x), min(y1 + y), max(y1 + y)]);

hold on;
plot(x, y, 'linewidth', 2);
plot(x, y1, 'r', 'linewidth', 2);

