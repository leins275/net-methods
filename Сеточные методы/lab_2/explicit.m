function res = explicit(a, b, N, d)
  h = (b - a) / N;
  t = 0.999 .* ( h.^2 / 2 );
  x = x_grid(a, b, N);
  
  %  задаём начальные условия
  for i = 1: N + 1
    y(i, 1) = u(x(i), 0);
  endfor
  
  %  сама схема, заполняем внутренние точки
  n = 2;
  while true
    for i = 1:N+1
      if i == 1
        %y(i, n) = u(x(i), t*(n-1));
        tmp = (-3*y(i, n-1) +4*y(i+1,n-1) - y(i+2,n-1)) / 2*h;
        y(i, n) = mu_a((n-1)*t, a) + tmp;
      elseif i == N+1
        %y(i, n) = u(x(i), t*(n-1));
        tmp = (3*y(i, n-1) -4*y(i-1,n-1) + y(i-2,n-1)) / 2*h;
        y(i, n) = mu_b((n-1)*t, b) - tmp;
      else
        tmp = (y(i+1, n-1) - 2.*y(i,n-1) + y(i-1,n-1)) / h.^2;
        y(i, n) = y(i, n - 1) + t .* (f(x(i), (n-1)*t) + q(x(i)).*tmp);
      endif
      n1(i) = abs(u(x(i), (n-1)*t) - sin(e^x(i)));
      n2(i) = sin(e^x(i));
    endfor
    if norm(n1, h, N) / norm(n2, h, N) < d
      break;
    endif
    n += 1;
  endwhile
  
  res = y;
 