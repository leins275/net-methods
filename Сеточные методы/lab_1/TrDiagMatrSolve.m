function y = TrDiagMatrSolve(b, c, d, r)
  v = [];
  beta = [];
  alpha = [];
  
  n = length(r);
  
  for i = 1:n, v(i) = 0; end
 
  new_alpha = r(1) / c(1);
  new_beta = - d(1) / c(1);
  alpha = [alpha, new_alpha];
  beta = [beta, new_beta];
  for i = 2 : n
    new_alpha = - d(i) / (c(i) + b(i) * alpha(i - 1));
    new_beta = (r(i) - b(i) * beta(i - 1)) / (c(i) + b(i) * alpha(i - 1));
      
    alpha = [alpha, new_alpha];
    beta = [beta, new_beta];
  end
  
  % countion v values
  v(n) = (r(n) - b(n) * beta(n - 1)) / (c(n) + b(n) * alpha(n - 1));
  for i = n - 1 : -1: 1
    v(i) = alpha(i) * v(i + 1) + beta(i);
  end
  
  y = v;
  