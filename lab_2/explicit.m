function [x, res, h, t, epsilon] = explicit(a, b, N, d)
  h = (b - a) / N;
  ts = h^2 / (2 * q(b))+ 1.85e-5;
  x = a:h:b;
  [t, K] = t_grid(ts, N, d, x);
  
  y = zeros(N+1, K+1);
  y(:, 1) = u(x(:), t(1));
  
  n1_norm = zeros(K, 1);
  n2_norm = zeros(K, 1);
  
  for n=2:K+1
    for i = 2:N
      tmp = (y(i+1, n-1) - 2.*y(i,n-1) + y(i-1,n-1)) / h.^2;
      y(i, n) = y(i, n - 1) + ts .* (f(x(i), t(n-1)) + q(x(i)).*tmp);
    end
    y(1, n) = (mu_a(t(n), a) + (4*y(2, n) - y(3, n))/2/h)/(1 + 3/2/h);
    y(N+1, n) = (mu_b(t(n), b) + (4*y(N, n) - y(N-1, n))/2/h)/(1 + 3/2/h);
 
    n1_norm(n) = max(abs(y(:, n) - u(x(:), t(n))));
    n2_norm(n) = max(abs(u(x(:), t(n))));   
  end
  epsilon = max(n1_norm) / max(n2_norm); 
  res = y;
 