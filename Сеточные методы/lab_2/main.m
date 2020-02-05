clear;

%%
%  setting up problem
a = 0.5; %  edges of intervalq
b = 2;
T = 1; %  time interval
N = 20;

y = explicit(a, b, T, N);
x = x_grid(a, b, N);
h = (b - a) / N;
step = 0.999 .* ( h.^2 / 2 );
K = length(y(1,:));
for i = 1:length(y(1,:))
  t(i) = step*(i-1); 
endfor

%  смотрим ошибку
for n = 1:K
  for i = 1:N + 1
    delta_i(i, n) = abs(y(i, n) - u(x(i), (n-1)*step));
    u_i(i, n) = abs(u(x(i), (n-1)*step));
  endfor
endfor
delta = 0;
max_u = 0;
for n = 1:K
  if delta < norm(delta_i(2:10, n), h, N);
    delta = norm(delta_i(2:10,n), h, N);
  endif
  if max_u < norm(u_i(2:10,n), h, N);
    max_u = norm(u_i(2:10,n), h, N);
  endif  
endfor
  
eps = delta / max_u

for n=1:length(t)
  for i=1:length(x)
    func(i, n) = u(x(i), t(n));
  endfor
endfor

figure;
[T, X] = meshgrid(t, x);

plot3(X, T, y);






