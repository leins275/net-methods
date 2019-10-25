function y = h2(n, a, b)
  h = (b - a) / n;
  x = a : h : b;
  n = length(x);

  m = BuildMatrix_h2(x, h);
  r = zeros(1, n);
  
  r(1) = -e ^ 0.5 * cos(e ^ 0.5) + sin(e ^ 0.5)% sin(1) - cos(1);
  r(n) = (e ^ 2) * cos(e ^ 2) + sin(e ^ 2);
  for i = 2:n - 1, r(i) = f(x(i)); end
  r = UpdateF(n, m, r);

  m = MakeTridiag(n, m);

  y = TrDiagMatrSolve(m(3, :), m(2, :), m(1, :), r);  
  
