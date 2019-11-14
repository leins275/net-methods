problem;
n = 1280;
dim = 1;
errCur = 10;
i = 1;

while true  
  [v, x, h] = ... 
  FiniteDiffMethod(n, a, b, dim, alpha, beta, gamma, p, q, f);
  
  errPrew = errCur;
  errCur = norm(abs(v - u(x)), h, n);
  delta(i) = errCur;
  hi(i) = h;
  
  i = i + 1;
  n = n * 2;
  if (errCur >= errPrew)
    break;
  end
end


