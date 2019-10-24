function y = MakeTridiag(n, m)  
  delta_0 = - m(3, 1) / m(1, 2);
  
  m(1, 1) = m(2, 2) * delta_0 + m(1, 1);
  m(2, 1) = m(3, 2) * delta_0 + m(2, 1);
  m(3, 1) = m(1, 2) * delta_0 + m(3, 1);
 
  delta_n = - m(1, n) / m(3, n - 1);
  
  m(1, n) = m(3, n - 1) * delta_n + m(1, n);
  m(2, n) = m(1, n - 1) * delta_n + m(2, n);
  m(3, n) = m(2, n - 1) * delta_n + m(3, n);
  
  y = m;