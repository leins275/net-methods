clear;

%%
%  Задание параметров
a = 0.5; 
b = 2;
E = 1e-3;
d = E * 0.1;
N = 1000
tic
disp('explicit:');
[x, y, h, t] = explicit(a, b, N, d, E);
%disp('implicit:');
%y = implicit(a, b, N);
%disp('symmetric:');
%y = symmetric(a, b, N);

toc
epsilon = eps(N, x, y, t, h)
toc

%  график
figure;
[T, X] = meshgrid(t, x);
plot3(X, T, y);






