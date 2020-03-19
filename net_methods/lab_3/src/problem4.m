function [u, q, a, b, f, x, y] = problem4(N, M)
    x = linspace(0, 1, N);
    y = linspace(0.5, 1, M);
    
    u = @(x, y) exp(x).*(y^4 + 1);
    q = @(x, y) x + exp(y) + 1;
    a = @(x, y) exp(y) + x;
    b = @(x, y) y*exp(x)/4;
    f = @(x, y) -4*y^3*exp(2*x);
end