clear;

% setting up problem

x = 3;
y = f(x);

% build matrix

% calculate integrals

% solve system (jacobi, zeidel, sor)

% functions

function y = f(x)
    y = x .^ 2;
    disp("y = ");
    fprintf("x .^ 2 = %d \n", y);
end