function y = du(x, t)
  y = ((exp(-3.*t)).*sin(exp(x)) + (exp(x)).*cos(exp(x)).*(x.*exp(-3.*t) + 1));