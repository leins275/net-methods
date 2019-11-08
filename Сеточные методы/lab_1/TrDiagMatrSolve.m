function y = TrDiagMatrSolve(b, c, d, r)
  n = length(r);
  alpha(1) = r(1) / c(1);
  beta(1) = - d(1) / c(1);
  for i = 2 : n
    alpha(i) = - d(i) / (c(i) + b(i) * alpha(i - 1));
    beta(i) = (r(i) - b(i) * beta(i - 1)) / (c(i) + b(i) * alpha(i - 1));
  end
  y(n) = beta(n);
  for i = n - 1 : -1: 1
    y(i) = alpha(i) * y(i + 1) + beta(i);
  end
  