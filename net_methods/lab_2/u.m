function y = u(x, t)
  y = sin(exp(x)) .* (1 + x.*exp(-3.*t));