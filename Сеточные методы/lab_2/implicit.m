function [x, res, h, t, epsilon] = implicit(a, b, N, d, sigma)
  %{  
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
  %}
    
  h = (b - a) / N;
  x = a:h:b;
  ts = h^2 / q(b) / 2; 
  [t, K] = t_grid(ts, N, d, x); 
  
  y = zeros(N+1, K+1);
  y(:, 1) = u(x(:), t(1));
  
  B = zeros(1, N+1);
  C = zeros(1, N+1);
  D = zeros(1, N+1);
  R = zeros(N+1, 1);
  n1 = zeros(K, 1);
  n2 = zeros(K, 1);
  
  for n = 2:K+1
    for i = 2:N
      gamma = ts * q(x(i)) * sigma / h^2;
      B(i+1) = gamma;
      C(i) = -(1 + 2*gamma);
      D(i-1) = gamma;
      tmp = (y(i+1, n-1) - 2*y(i, n-1) + y(i+1, n-1))/h^2;
      R(i) = - (y(i, n-1) + ts*f(x(i), t(n) + (1-sigma)*ts)) - ...
          (1 - sigma)*ts*q(x(i))*tmp;
    end
    C(1) = (1.5/h + 1) - D(1) / (B(3)*2*h);
    B(2) = -2/h - C(2) / (B(3)*2*h);
    R(1) = mu_a(t(n), a) - R(2) / (B(3)*2*h);
    C(N+1) = (1.5/h + 1) - B(N+1) / (D(N-1)*2*h);
    D(N) = -2/h - C(N) / (D(N-1)*2*h);
    R(N+1) = mu_b(t(n), b) - R(N) / (D(N-1)*2*h);
    
    i = [1:N+1, 2:N+1, 1:N];
    j = [1:N+1, 1:N, 2:N+1];
    v = [C, D(1:N), B(2:N+1)];
    S = sparse(i, j, v);
    yn = S \ R;
    y(:, n) = yn;    
    n1(n - 1) = max(abs(u(x(:), t(n)) - y(:, n)));
    n2(n - 1) = max(abs(u(x(:), t(n))));
  end
  epsilon = max(n1) / max(n2);
  res = y;
end  

  
  
  
  
  
  
  
  
  
  
  
  
  