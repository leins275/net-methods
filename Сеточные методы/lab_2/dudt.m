function y = dudt(x, t)
  y = sin(e.^x) .*x .* (-3) .* e .^ (-3.*t);