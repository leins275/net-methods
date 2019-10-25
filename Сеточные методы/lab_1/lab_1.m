clear all;

n = 20000;  % num of nodes

% n = [20, 40, 100, 1000, 10000, 300000]
hi =[];
delta = [];
% for n = 10:1: 100
% for i = 1: length(n)
a = 0.5;
b = 2.0;

h = (b - a) / n;
x = a : h : b;

tic;
y1 = u(x);
y = h2(n, a, b);
n = length(x);

delta = norm(y - y1, h, n);
time = toc;
time

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

