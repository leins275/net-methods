function y = MakeTridiag(m)
  n = size(m, 1);
  
  delta_0 = - m(1, 3) / m(2, 3);
  delta_n = - m(n, n - 2) / m(n - 1, n - 2);
  
  m(1, 1) = m(2, 1) * delta_0 + m(1, 1);
  m(1, 2) = m(2, 2) * delta_0 + m(1, 2);
  m(1, 3) = m(2, 3) * delta_0 + m(1, 3);
  
  m(n, n) = m(n - 1, n) * delta_n + m(n, n);
  m(n, n - 1) = m(n - 1, n - 1) * delta_n + m(n, n - 1);
  m(n, n - 2) = m(n - 1, n - 2) * delta_n + m(n, n - 2);

  y = m;