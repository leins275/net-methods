function [y, x, h] = FiniteDiffMethod(n, a, b, dim, alpha, beta, gamma, p, q, f)  
  h = (b - a) / (n - 1);
  x = linspace(a, b, n);
  n = length(x);
  
  r = zeros(1, n);
  B = zeros(1, n);
  C = zeros(1, n);
  D = zeros(1, n);
  
  B(1) = 0;
  D(n) = 0;
  if dim == 1
    r(1) = gamma(1) * h;
    r(n) = gamma(2) * h;
    D(1) = -alpha(1);
    C(1) = alpha(1) + alpha(2) * h;
    B(n) = -beta(1);
    C(n) = beta(1) + beta(2) * h;
  else
    r(1) = 2 .* gamma(1) .* h + alpha(1) .* (h.^2*f(x(2))) / (1 - h.*p(x(2))/2);
    r(n) = 2 .* gamma(2) .* h + beta(1) .* h^2 .* f(x(n-1)) / (1 + h.*p(x(n-1))/2);
    C(1) = 3.*alpha(1) + 2.*h.*alpha(2) - alpha(1).*(1 + h.*p(x(2))/2)/(1 - h.*p(x(2))/2); 
    D(1) = alpha(1) .* ((2 + (h.^2) * q(x(2)) ) / (1 - h.*p(x(2))/2 ) - 4); 
    B(n) = beta(1).*((2 + h.^2.*q(x(n-1)))/(1 + h.*p(x(n-1))/2) - 4); 
    C(n) = 3.*beta(1) + 2.*h.*beta(2) - beta(1).*(1 - h.*p(x(n-1))/2)/(1 + h.*p(x(n-1))/2); 
  end
  
  for i = 2:n-1
    pi = p(x(i));
    qi = q(x(i));
    fi = f(x(i));
    
    D(i) = - 1 + h*pi/2;
    C(i) = 2 + (h.^2)*qi;
    B(i) = - (1 + h*pi/2);
    r(i) = h^2 * fi;
  end
  y = TrDiagMatrSolve(B, C, D, r);  
endfunction
