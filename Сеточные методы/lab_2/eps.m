function res = eps(K, N, x, y, step, h)
  for n = 1:K
    for i = 1:N + 1
      delta_i(i, n) = abs(y(i, n) - u(x(i), (n-1)*step));
      u_i(i, n) = abs(u(x(i), (n-1)*step));
    endfor
  endfor
  delta = 0;
  max_u = 0;
  for n = 1:K
    if delta < norm(delta_i(2:10, n), h, N);
    delta = norm(delta_i(2:10,n), h, N);
  endif
  if max_u < norm(u_i(2:10,n), h, N);
    max_u = norm(u_i(2:10,n), h, N);
  endif  
  endfor
  
  res = delta / max_u;