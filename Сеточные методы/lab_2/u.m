function y = u(x, t)
  y = sin(exp(x)) .* (x .* exp(-3 .* t) + 1);