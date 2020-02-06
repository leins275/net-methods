function res = symmetric(a, b, N)
  h = (b - a) / N;
  t = 0.999 .* ( h.^2 / 2 );
  x = x_grid(a, b, N);
  d = 0.1;
  
  %  задаём начальные условия
  for i = 1: N + 1
    y(i, 1) = u(x(i), 0);
  endfor
 
  %  сама схема, заполняем внутренние точки
  n = 2;
  while true
    for i = 1:N+1
      %  заполняем матицу для прогонки
      if i == 1
        b1(i) = 0;
        c1(i) = 1;
        d1(i) = 0;
        r1(i) = mu_a((n-1)*t, a) + (u(a+h, (n-1)*t)-u(a-h, (n-1)*t))/(2*h);
      elseif i == N+1
        b1(i) = 0;
        c1(i) = 1;
        d1(i) = 0;
        r1(i) = mu_b((n-1)*t, b) - (u(b+h, (n-1)*t)-u(b-h, (n-1)*t))/(2*h);
      else
        tmp =  q(x(i)) * t * (y(i-1, n-1) - 2*y(i, n-1) + y(i+1, n-1)) / h^2;
        b1(i) = q(x(i)) * t / (2*h^2);
        c1(i) = - q(x(i)) * (1 + t / h^2);
        d1(i) = q(x(i)) * t / (2*h^2);
        r1(i) = -(y(i, n-1) + t*f(x(i), (n-1)*t) + tmp);
      endif
      n1(i) = abs(u(x(i), (n-1)*t) - sin(e^x(i)));
      n2(i) = sin(e^x(i));
    endfor
    yn = TrDiagMatrSolve(b1, c1, d1, r1);
    for i=1:N+1
      y(i, n) = yn(i);
    endfor
    
    if norm(n1, h, N) / norm(n2, h, N) < d
      break;
    endif
    n += 1;
  endwhile
  
  res = y;