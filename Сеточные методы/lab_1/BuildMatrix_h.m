function y = BuildMatrix_h(x, h)
    n = length(x);
  
  matrix = zeros(3, n);
  
  for i = 1:n
    X = x(i);
    P(i) = p(X);
    Q(i) = q(X);
  end
  
  matrix(1, 1) = -1 / h;
  matrix(2, 1) = 1 / h + 1;
  matrix(3, 1) = 0;
  for i = 2 : n - 1
    matrix(3, i) = -1 / power(h, 2);
    matrix(2, i) = 2 / power(h, 2) + Q(i) - P(i) / h;
    matrix(1, i) = -1 / power(h, 2) + P(i) / h;  
  end
  matrix(1, n) = 0;
  matrix(3, n) = -1 / h;
  matrix(2, n) = 1 /  h  + 1;
  
  y = matrix;
