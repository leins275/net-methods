function [u, q, a, b, f, x, y] = problem(N, M)
    x = linspace(1, 4, N);
    y = linspace(1, 3, M);
    
    u = @(x, y) cos(2 .* x) .* exp(-3 .* y );
    q = @(x, y) x^4 * exp(y);
    a = @(x, y) x^2 + y^2;
    b = @(x, y) 1 + x*y;
    f = @(x, y) 3*x*cos(2*x)*exp(-3*y) + 4*x*sin(2*x)*exp(-3*y) - ...
        9*cos(2*x)*exp(-3*y)*(x*y + 1) + x^4*cos(2*x)*exp(-2*y) + ...
        4*cos(2*x)*exp(-3*y)*(x^2 + y^2);
end