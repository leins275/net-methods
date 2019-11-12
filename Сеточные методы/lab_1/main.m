clear all;

%%%
% specify params for task
%%%
a = 0.5;
b = 2.0;
alpha = [1, 1];
beta = [1, 1];
gamma = [-alpha(1)*du(a) + beta(1)*u(a), alpha(2)*du(b) + beta(2)*u(b)];

%%%
% build a net
%%%  
n = 160000;
h = (b - a) / (n - 1);
x = a : h : b;

y1 = u(x);
tic;

%%%
% choose method
%%% 
dim = 2;
y = FiniteDiffMethod(n, a, b, dim, alpha, beta, gamma);

delta = norm(y - y1, h, n);
time = toc;
time
plot (x, y, 'linewidth', 2,  x, y1, 'r', 'linewidth', 2);
h
delta
