function y = du(x, t)
  y = sin(exp(x)).*exp(-3.*t) + cos(exp(x)).*exp(x).*(x.*exp(-3.*t) + 1);
 