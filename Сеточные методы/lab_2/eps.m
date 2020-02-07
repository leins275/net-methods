function res = eps(N, x, y, t, h)
  for n = 1:length(t)
    for i = 1:length(x)
      n1(i, n) = abs(y(i, n) - u(x(i), t(n)));
      n2(i, n) = abs(u(x(i), t(n)));
    endfor
    n1_norm(n) = norm(n1(:, n),h,length(x));
    n2_norm(n) = norm(n2(:, n),h,length(x));
  endfor
  
  n1_max = max(n1_norm);
  n2_max = max(n2_norm);
  
  res = n1_max / n2_max;
