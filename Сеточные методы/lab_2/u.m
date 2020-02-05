function y = u(x, t)
  y = sin(e .^ x) .* (x .* e .^ (-3 .* t) + 1);