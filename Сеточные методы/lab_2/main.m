clear;

%%
%  setting up problem
a = 0.5; %  edges of intervalq
b = 2;
d = 0.01;
N = 10

disp('explicit:');
y = explicit(a, b, N, d);
%disp('implicit:');
%y = implicit(a, b, N);
%disp('symmetric:');
%y = symmetric(a, b, N);

x = x_grid(a, b, N);
h = (b - a) / N;
step = 0.999 .* ( h.^2 / 2 );
K = length(y(1,:));
for i = 1:length(y(1,:))
  t(i) = step*(i-1); 
endfor

epsilon = eps(K, N, x, y, step, h)

for n=1:length(t)
  for i=1:length(x)
    func(i, n) = u(x(i), t(n));
  endfor
endfor

figure;
[T, X] = meshgrid(t, x);

plot3(X, T, y);






