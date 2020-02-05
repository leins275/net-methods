function y = f(x, t)
  y = dudt(x, t) - q(x) .* d2u(x, t);