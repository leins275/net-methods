function [x, res, h, t, epsilon] = implicit(a, b, N, sigma)
  h = (b - a) / N;
  ts = h ^ 2;
  x = a:h:b;
  [t, K] = t_grid(ts, N, 0.1, x, h);
  
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
    d1(1) = ts * q(x(2)) / h^2;
    b1(N+1) = ts * q(x(N)) / h^2;  
    
    %  граничные условия
    c1(1) = 3 + 2 * h;
    b1(2) = -4;
    c1(N+1) = 3 + 2 * h;
    d1(N) = -4;
    r1(1) = mu_a(t(n), a) * 2 * h;
    r1(N+1) = mu_b(t(n), b) * 2 * h;
    
    for i = 2:N
      %  заполняем матицу для прогонки  
      gamma = (ts * q(x(i))*sigma / h^2);
      b1(i+1) = gamma;
      c1(i) = -1-2*gamma;
      d1(i-1) = gamma;
      tmp = (y(i+1, n-1) - 2.*y(i,n-1) + y(i-1,n-1)) / h.^2;
      r1(i) = -(y(i, n-1) + ts*(f(x(i), t(n-1)) + q(x(i))*(1-sigma)*tmp));
    end
    %  приводим матрицу к диагональному виду
    c1(1) = c1(1) + d1(1) * (-1/b1(3));
    b1(2) = b1(2) + c1(2) * (-1/b1(3));
    r1(1) = r1(1) + r1(2) * (-1/b1(3));
    
    d1(N) = d1(N) + c1(N) * (-1/d1(N-1));
    c1(N+1) = c1(N+1) + b1(N+1) * (-1/d1(N-1));
    r1(N+1) = r1(N+1) + r1(N) * (-1/d1(N-1));
    
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