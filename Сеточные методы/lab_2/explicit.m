function [x, res, h, t, epsilon] = explicit(a, b, N, d)
  h = (b - a) / N;
  ts = min(h, h^2 / (2 * q(b))) ;
  x = a:h:b;
  [t, K] = t_grid(ts, N, d, x, h);
  
  y = zeros(N+1, K+1);
  %  задаём начальные условия
  for i = 1: N + 1
    y(i, 1) = u(x(i), 0);
  end
  
  n1 = zeros(N+1, 1);
  n2 = zeros(N+1, 1);
  n1_norm = zeros(K, 1);
  n2_norm = zeros(K, 1);
  %  сама схема
  for n=2:K+1
    for i = 2:N
      %  заполняем внутренние точки
      tmp = (y(i+1, n-1) - 2.*y(i,n-1) + y(i-1,n-1)) / h.^2;
      y(i, n) = y(i, n - 1) + ts .* (f(x(i), t(n-1)) + q(x(i)).*tmp);
      
      n1(i, n) = abs(y(i, n) - u(x(i), t(n)));
      n2(i, n) = abs(u(x(i), t(n)));
    end
    %  задаём точки на границе
    y(1, n) = (mu_a(t(n), a) + (4*y(2, n) - y(3, n))/2/h)/(1 + 3/2/h);
    y(N+1, n) = (mu_b(t(n), b) + (4*y(N, n) - y(N-1, n))/2/h)/(1 + 3/2/h);
    
    n1(1, n) = abs(y(1, n) - u(x(1), t(n)));
    n2(N+1, n) = abs(u(x(N+1), t(n)));
 
    n1_norm(n) = max(n1(:, n));
    n2_norm(n) = max(n2(:, n));   
  end
  epsilon = max(n1_norm) / max(n2_norm); 
  res = y;
 