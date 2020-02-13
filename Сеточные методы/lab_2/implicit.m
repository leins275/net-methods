function [x, res, h, t, epsilon] = implicit(a, b, N, d, sigma)
  h = (b - a) / N;
  ts = max(h, h^2 / (2 * q(b)));
  x = a:h:b;
  [t, K] = t_grid(ts, N, d, x);
  y = zeros(N+1, K+1);
  for i = 1: N + 1
    y(i, 1) = u(x(i), 0);
  end
  n1 = zeros(N+1, 1);
  n2 = zeros(N+1, 1);
  n1_norm = zeros(K, 1);
  n2_norm = zeros(K, 1);
  B = zeros(1, N+1);
  C = zeros(1, N+1);
  D = zeros(1, N+1);
  R = zeros(1, N+1);
  for n = 2:K+1
    for i = 2:N
      gamma = ts * q(x(i)) / h^2;
      D(i-1) = gamma;
      C(i) = -(1 + 2*gamma);
      B(i+1) = gamma;
      R(i) = -(y(i, n-1) + ts * f(x(i), t(n))); 
    end
    
    %{
    C(1) = (3 + 2*h) - D(1) / B(3);
    B(2) = -4  - C(2) / B(3);
    R(1) = 2*h*mu_a(t(n-1), a) - R(2) / B(3);
    
    C(N+1) = (3 + 2*h) - B(N+1) / D(N-1);
    D(N) = -4 - C(N) / D(N-1);
    R(N+1) = 2*h*mu_b(t(n-1), b) - R(N) / D(N-1);
    %}    
    
    C(1) = 1;
    B(2) = 0;
    R(1) = u(x(1), t(n));
    
    C(N+1) = 1;
    D(N) = 0;
    R(N+1) = u(x(N+1), t(n));
    
    
    %{
    i = [1:N+1, 2:N+1, 1:N];
    j = [1:N+1, 1:N, 2:N+1];
    v = [C, B(2:N+1), D(1:N)] ;
    S = sparse(i, j, v);
    yn = S \ R;
    %}
    yn = TrDiagMatrSolve(B, C, D, R);
    for i=1:N+1
      y(i, n) = yn(i);
      
      n1(i, n) = abs(y(i, n) - u(x(i), t(n)));
      n2(i, n) = abs(u(x(i), t(n)));
    end
    n1_norm(n) = max(n1(:, n));
    n2_norm(n) = max(n2(:, n));
  end
  res = y;
  epsilon = max(n1_norm) / max(n2_norm); 
  
  