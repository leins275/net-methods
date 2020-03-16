function [u, q, a, b, f, x, y] = problem2(N, M)
    x = linspace(-5, 5, N);
    y = linspace(-5, 5, M);
    
    u = @(x, y) x.^2/4 + y.^2/6;
    q = @(x, y) sin(x - y);
    a = @(x, y) exp(y) * x;
    b = @(x, y) x + y;
    f = @(x, y) x^2*y^3*sin(x - y) - 6*x^2*y*(x + y) - ...
        3*x^2*y^2 - 4*x*y^3*exp(y);
end