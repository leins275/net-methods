function y = UpdateF(m, r)
  % m should be before MakeTriag !!!
  n = length(r);
  delta_0 = - m(1, 3) / m(2, 3);
  delta_n = - m(n, n - 2) / m(n - 1, n - 2);
  
  r(1) = r(2) * delta_0  + r(1);
  r(n) = r(n - 1) * delta_n  + r(n);
  
  y = r;
  