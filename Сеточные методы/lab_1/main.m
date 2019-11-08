clear all;

n = 1000;
a = 0.5;
b = 2.0;
h = (b - a) / (n - 1);
x = a : h : b;
dim = 1;
y1 = u(x);
tic;
y = FiniteMethod(n, a, b, dim);

delta = norm(y - y1, h, n);
time = toc;
time
plot (x, y, x, y1, 'r');
h
delta
