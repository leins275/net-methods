function y = norm(x, h, n)
  sum = 0;
  for i=1:n, sum += power(x(i), 2); end
  y = sqrt(h * sum);

