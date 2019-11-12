function y = FiniteDiffMethod(n, a, b, dim, alpha, beta, gamma)  
  h = (b - a) / (n - 1);
  x = a : h : b;
  n = length(x);
  r = zeros(1, n);
  matrix = zeros(3, n);
  
  if dim == 1
    r(1) = gamma(1) * h;
    r(n) = gamma(2) * h;
    matrix(1, 1) = -alpha(1);
    matrix(2, 1) = alpha(1) + alpha(2) * h;
    matrix(3, n) = -beta(1);
    matrix(2, n) = beta(1) + beta(2) * h;
  else
    r(1) = 2 * gamma(1) * h + alpha(1) * (h^2*f(x(2))) / (1 - h*p(x(2))/2);
    r(n) = 2 * gamma(2) * h + beta(1) * h^2 * f(x(n-1)) / (1 + h*p(x(n-1))/2);
    matrix(2, 1) = 3*alpha(1) + 2*h*alpha(2) - alpha(1)*(1 + h*p(x(2))/2)/(1 - h*p(x(2))/2); 
    matrix(1, 1) = alpha(1) * ((2 + (h.^2) * q(x(2)) ) / (1 - h*p(x(2))/2 ) - 4); 
    matrix(3, n) = beta(1)*((2 + h^2*q(x(n-1)))/(1 + h*p(x(n-1))/2) - 4); 
    matrix(2, n) = 3*beta(1) + 2*h*beta(2) - beta(1)*(1 - h*p(x(n-1))/2)/(1 + h*p(x(n-1))/2); 
  end
  
  for i = 2 : n - 1
    matrix(3, i) = - (1 + h * p(x(i)) / 2); % b
    matrix(2, i) = 2 + h^2 * q(x(i)); % c
    matrix(1, i) = -1 + p(x(i)) * h / 2; % d  
    r(i) = h^2 * f(x(i));
  end
  y = TrDiagMatrSolve(matrix(3, :), matrix(2, :), matrix(1, :), r);  
endfunction
