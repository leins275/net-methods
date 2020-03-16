clear;

% setup the task
N = 5; 
M = 5;
[u, q, a, b, f, x, y] = problem2(N, M);

U = um(x, y, u);
graphics(x, y, U);


% calculate coefs with fvm method
[A, B, C, D, E, G] = fvm(N, M, x, y, a, b, q, f, u);

% solve 
Eps = 1e-1;
v = jacobi(N, M, A, B, C, D, E, G, Eps, x, y, u);

graphics(x, y, v);
fprintf("%d \n", max(max(abs(U - v))));


function u = um(x, y, f)
    M = length(y);
    N = length(x);
    u = zeros(N, M);
    
    for i = 1:N
        for j = 1:M
            u(i, j) = f(x(i), y(j));
        end
    end    
end














