function y = du(x, t)
  y = ((e.^(-3.*t)).*sin(e.^x) + (e.^x).*cos(e.^x).*(x.*e.^(-3.*t) + 1));