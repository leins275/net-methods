function [x, res, h, t, epsilon] = implicit(a, b, N, d, sigma)
  h = (b - a) / N;
  ts = h^2 / (2 * q(b));
  x = a:h:b;
  [t, K] = t_grid(ts, N, d, x);
  y = zeros(N+1, K+1);
  for i = 1: N + 1
    y(i, 1) = u(x(i), 0);
  end
  n1 = zeros(N+1, 1);
  n2 = zeros(N+1, 1);
  B = zeros(1, N+1);
  C = zeros(1, N+1);
  D = zeros(1, N+1);
  R = zeros(N+1, 1);
  for n = 2:K+1
    for i = 2:N
      gamma = ts * q(x(i)) / h^2;
      D(i-1) = gamma;
      C(i) = -(1 + 2*gamma);
      B(i+1) = gamma;
      R(i) = -(y(i, n-1) + ts * f(x(i), t(n))); 
    end
    
    C(1) = (3 + 2*h) - D(1) / B(3);
    B(2) = -4  - C(2) / B(3);
    R(1) = 2*h*mu_a(t(n-1), a) - R(2) / B(3);
    C(N+1) = (3 + 2*h) - B(N+1) / D(N-1);
    D(N) = -4 - C(N) / D(N-1);
    R(N+1) = 2*h*mu_b(t(n-1), b) - R(N) / D(N-1);
    
    yn = TrDiagMatrSolve(B, C, D, R);
    y(:, n) = yn;
    n1(n) = max(abs(y(:, n) - u(x(:), t(n))));
    n2(n) = max(abs(u(x(:), t(n))));
  end
  res = y;
  epsilon = max(n1) / max(n2); 
  
  