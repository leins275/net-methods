function y = d2u(x, t)
  y = 2.*e.^(-3.*t+x).*cos(e.^x) + e.^x .* (cos(e.^x) - e.^x .* sin(e.^x));