%%%
% begin
%%%
clear;
n = 1000;  % num of nodes
a = 0;
b = 2;
h = (b - a) / n;
x = 0 : h : 2;
x = single(x);  
n = length(x);

m = BuildMatrix_h2(x, h);
for i = 1:n, r(i) = f(x(i)); end
r(1) = sin(1) - cos(1);
r(n) = e ^ 2 * cos(e ^ 2) + sin(e ^ 2);
r = UpdateF(m, r);

m = MakeTridiag(m);

for i = 1 : n, c(i) = m(i, i); end
for j = 1 : n - 1, d(j) = m(j, j + 1); end
for k = 2 : n, b(k) = m(k, k - 1); end
b(1) = 0;
d(n) = 0;
  
y = TrDiagMatrSolve(b, c, d, r);
y1 = u(x);

axis([min(x), max(x), min(y), max(y)]);

figure();
hold on;
plot(x, y, 'linewidth', 2);
plot(x, y1, 'r', 'linewidth', 2);

