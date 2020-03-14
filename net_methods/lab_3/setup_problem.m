function [start, stop, u, q, a, b, f] = setup_problem()
    start = 1;
    stop = 10;
    u = @(x, y) cos(2 * x) * exp(-3 * y );
    q = @(x, y) x^4 * exp(y);
    a = @(x, y) x^2 + y^2;
    b = @(x, y) 1 / (x + y);
    f = @(x, y) 4*x*sin(2*x)*exp(-3*y) - (9*cos(2*x)*exp(-3*y))/(x + y) - ...
        - (3*cos(2*x)*exp(-3*y))/(x + y)^2 + x^4*cos(2*x)*exp(-2*y) + ... 
         + 4*cos(2*x)*exp(-3*y)*(x^2 + y^2);
end