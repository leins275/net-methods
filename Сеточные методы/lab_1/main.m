n = 1280;
dim = 1;
errCur_1 = 10;
errPrew_1 = 100;
errCur_2 = 10;
i = 1;

% for original func graph
x = linspace(a, b, 1000);
y = u(x);

% O(h), 20
[v_1_20, x_1_20, h] = FiniteDiffMethod(20, a, b, 1, alpha, beta, gamma, p, q, f);
% O(h), 100
[v_1_100, x_1_100, h] = FiniteDiffMethod(100, a, b, 1, alpha, beta, gamma, p, q, f);
% O(h^2), 20
[v_2_20, x_2_20, h] = FiniteDiffMethod(20, a, b, 2, alpha, beta, gamma, p, q, f);
% O(h^2), 100
[v_2_100, x_2_100, h] = FiniteDiffMethod(100, a, b, 2, alpha, beta, gamma, p, q, f);

hi_1 = [];
hi_2 = [];
delta_1 = [];
delta_1 = [];
while true  
  % for loglog graph O(h)
  if (errCur_1 < errPrew_1)
    [v_log_1, x_log_1, h_1] = ... 
    FiniteDiffMethod(n, a, b, 1, alpha, beta, gamma, p, q, f);
    errPrew_1 = errCur_1;
    errCur_1 = norm(abs(v_log_1 - u(x_log_1)), h_1, n);
    delta_1(i) = errCur_1;
    hi_1(i) = h_1;
  endif

  % for loglog graph O(h^2)
  [v_log_2, x_log_2, h_2] = ... 
  FiniteDiffMethod(n, a, b, 2, alpha, beta, gamma, p, q, f);
  errPrew_2 = errCur_2;
  errCur_2 = norm(abs(v_log_2 - u(x_log_2)), h_2, n);
  delta_2(i) = errCur_2;
  hi_2(i) = h_2;
  
  i = i + 1;
  n = n * 2;
  if (errCur_2 >= errPrew_2)
    break;
  end
end


