function [u, q, a, b, f, x, y] = problem3(N, M)
    x = linspace(-5, 5, N);
    y = linspace(-5, 5, M);
    
    u = @(x, y) x * y.^2;
    q = @(x, y) 0;
    a = @(x, y) 1;
    b = @(x, y) 1;
    f = @(x, y) - 2*x;
end