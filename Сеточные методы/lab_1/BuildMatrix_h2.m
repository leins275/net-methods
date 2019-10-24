function y = BuildMatrix_h2(x, h)
  n = length(x);
  
  matrix = zeros(3, n, "single");
  
  for i = 1:n
    X = x(i);
    P(i) = p(X);
    Q(i) = q(X);
  end
  % Q = q(x);
  % P = p(x);
  
  matrix(1, 1) = 3 / (2 * h) + 1;
  matrix(1, 2) = -2 / h;
  matrix(1, 3) = 1 / (2 * h);
  for i = 2 : n - 1
    matrix(i, i - 1) = -1 / power(h, 2) - P(i) / (2 * h);
    matrix(i, i) = 2 / power(h, 2) + Q(i);
    matrix(i, i + 1) = -1 / power(h, 2) + P(i) / (2 * h);  
  end
  matrix(n, n) = 3 / (2 * h)  + 1;
  matrix(n, n - 1) = -2 / h;
  matrix(n, n - 2) = 1 / (2 * h);
  
  y = matrix;
  