function y = BuildMatrix_h2(x, h)
  n = length(x);
  
  matrix = zeros(3, n);
  
  for i = 1:n
    X = x(i);
    P(i) = p(X);
    Q(i) = q(X);
  end
  
  matrix(1, 1) = -2 / h;
  matrix(2, 1) = 3 / (2 * h) + 1;
  matrix(3, 1) = 1 / (2 * h);
  for i = 2 : n - 1
    matrix(3, i) = -1 / power(h, 2) - P(i) / (2 * h);
    matrix(2, i) = 2 / power(h, 2) + Q(i);
    matrix(1, i) = -1 / power(h, 2) + P(i) / (2 * h);  
  end
  matrix(1, n) = 1 / (2 * h);
  matrix(3, n) = -2 / h;
  matrix(2, n) = 3 / (2 * h)  + 1;
  
  y = matrix;
  