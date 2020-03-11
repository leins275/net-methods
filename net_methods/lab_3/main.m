clear;

% setting up problem
% -----------------------------------------------------------------------
start = 1;
stop = 10;
N = 10; % N >= 2 !!!!!
x = linspace(start, stop, N);
y = linspace(start, stop, N);

u = @(x, y) cos(2 * x) * exp(-3 * y );
q = @(x, y) x^4 * exp(y);
a = @(x, y) x^2 + y^2;
b = @(x, y) 1 / (x + y);

% calculated with symbolic operaions by matlab
f = @(x, y) 2*cos(x)*(15*cos(2*y)*exp(3*y)*sin(x^2 + 1)^3 - ... 
        - 10*sin(2*y)*exp(3*y)*sin(x^2 + 1)^3) + ...
        + (25*cos(2*y)*exp(3*y)*sin(x^2 + 1)^3 - ...
        - 60*sin(2*y)*exp(3*y)*sin(x^2 + 1)^3)*(2*y*cos(x) - 1/x) + ...
        + 5*cos(2*y)*exp(4*y)*sin(x^2 + 1)^3*(x^4 - 5) - ... 
        - 60*x^2*cos(2*y)*exp(3*y)*cos(x^2 + 1)*sin(x^2 + 1)^2 - ...
        + 30*cos(2*y)*exp(3*y)*cos(x^2 + 1)*sin(x^2 + 1)^2*(x^2 + y^2) + ...
        +60*x^2*cos(2*y)*exp(3*y)*sin(x^2 + 1)^3*(x^2 + y^2) - ...
        -120*x^2*cos(2*y)*exp(3*y)*cos(x^2 + 1)^2*sin(x^2 + 1)*(x^2 + y^2);

% main
% -----------------------------------------------------------------------



r = zeros(N, 1);
for i = 1:N
    r(i) = 
end

