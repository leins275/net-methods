clear;

start = 1;
stop = 10;
N = 10; % N >= 2 !!!!!
x = linspace(start, stop, N);
y = linspace(start, stop, N);


% functions definitions
% -----------------------------------------------------------------------

% build matrix
% A B C 0 0  ...
% D A B C 0  ...
% E D A B C  ...
% 0 E D A B  ...
% ..............

function y = build_matrix(N, x, y)
    A = zeros(1, N);
    B = zeros(1, N-1);
    C = zeros(1, N-2);
    D = zeros(1, N-1);
    E = zeros(1, N-2);
    
    m = sparse(N, N);
    
    % edge points
    for i = 1:N
        m(1, i) = u(x(i), y(1));
        m(N, i) = u(x(i), y(N));
        m(i, 1) = u(x(1), y(i));
        m(i, N) = u(x(N), y(i));
    end
        
    m = sparse(N, N);
    y = m;
end
% calculate integrals

% solve system (jacobi, zeidel, sor)

% setting up problem
function y = u(x, y)
    y = (5 .* (sin(x.^2 + 1)).^3) .* (cos(2.*y) .* exp(3.*y));
end
function y = q(x, y)
    y = (x.^4 - 5) .* exp(y);
end
function y = a(x, y)
    y = x.^2 + y.^2;
end
function y = b(x, y)
    y = 1 ./ x - 2.*y.*cos(x);
end
% calculated with symbolic operaions by matlab
function y = f(x, y)
    y = 2*cos(x)*(15*cos(2*y)*exp(3*y)*sin(x^2 + 1)^3 - ... 
        - 10*sin(2*y)*exp(3*y)*sin(x^2 + 1)^3) + ...
        + (25*cos(2*y)*exp(3*y)*sin(x^2 + 1)^3 - ...
        - 60*sin(2*y)*exp(3*y)*sin(x^2 + 1)^3)*(2*y*cos(x) - 1/x) + ...
        + 5*cos(2*y)*exp(4*y)*sin(x^2 + 1)^3*(x^4 - 5) - ... 
        - 60*x^2*cos(2*y)*exp(3*y)*cos(x^2 + 1)*sin(x^2 + 1)^2 - ...
        + 30*cos(2*y)*exp(3*y)*cos(x^2 + 1)*sin(x^2 + 1)^2*(x^2 + y^2) + ...
        +60*x^2*cos(2*y)*exp(3*y)*sin(x^2 + 1)^3*(x^2 + y^2) - ...
        -120*x^2*cos(2*y)*exp(3*y)*cos(x^2 + 1)^2*sin(x^2 + 1)*(x^2 + y^2);
end