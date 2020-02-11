function [x, res, h, t, epsilon] = implicit(a, b, N, d, sigma)
  h = (b - a) / N;
  ts = h^2 / (2 * q(b));
  x = a:h:b;
  [t, K] = t_grid(ts, N, d, x, h);
  
  y = zeros(N+1, K+1);
  %  задаём начальные условия
  for i = 1: N + 1
    y(i, 1) = u(x(i), 0);
  end
 
  n1 = zeros(N+1, 1);
  n2 = zeros(N+1, 1);
  b1 = zeros(N+1, 1);
  c1 = zeros(N+1, 1);
  d1 = zeros(N+1, 1);
  r1 = zeros(N+1, 1);
  n1_norm = zeros(K, 1);
  n2_norm = zeros(K, 1);
  
  %  сама схема, заполняем внутренние точки
  for n = 2:K+1 
    b1(1) = 0;
    d1(N+1) = 0;
    for i = 2:N
      %  заполняем матицу для прогонки  
      gamma = ts * q(x(i)) * sigma / h^2;
      b1(i+1) = gamma;
      c1(i) = -1-2*gamma;
      d1(i-1) = gamma;
      tmp = (y(i+1, n-1) - 2.*y(i,n-1) + y(i-1,n-1)) / h.^2;
      r1(i) = -(y(i, n-1) + ts*(f(x(i), t(n-1) + (1-sigma)*ts) + ...
          q(x(i))*(1-sigma)*tmp));
    end    
    %  граничные условия
    gamma = ts * q(x(2)) * sigma / h^2;
    c1(1) = (3/(2*h)+1) - 1/(2*h);
    b1(2) = -2/h + (1+2*gamma)/(2*h*gamma);
    r1(1) = mu_a(t(n), a) - r1(2) * (1/(2*h*gamma));
    
    gamma = ts * q(x(N)) * sigma / h^2;
    c1(N+1) = (3/(2*h)+1) - 1/(2*h);
    d1(N) = -2/h + (1+2*gamma)/(2*h*gamma);
    r1(N+1) = mu_b(t(n), b) - r1(N) * (1/(2*h*gamma));
    
    yn = TrDiagMatrSolve(b1, c1, d1, r1);
    for i=1:N+1
      y(i, n) = yn(i);
      
      n1(i, n) = abs(y(i, n) - u(x(i), t(n)));
      n2(i, n) = abs(u(x(i), t(n)));
    end
    n1_norm(n) = norm2(n1(:, n),h);
    n2_norm(n) = norm2(n2(:, n),h);
  end
  res = y;
  epsilon = max(n1_norm) / max(n2_norm); 