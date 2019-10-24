function y = UpdateF(n, m, r)
  delta_0 = - m(3, 1) / m(1, 2);
  delta_n = - m(1, n) / m(3, n - 1);
  
  r(1) = r(2) * delta_0  + r(1);
  r(n) = r(n - 1) * delta_n  + r(n);
  
  y = r;
  