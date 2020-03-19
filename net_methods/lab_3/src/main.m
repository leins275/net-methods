clear;

% setup the task
N = 8; 
M = 6;
[u, q, a, b, f, x, y] = problem3(N, M);

U = um(x, y, u);
graphics(x, y, U, 'origin');


% calculate coefs with fvm method
[A, B, C, D, E, G] = fvm(N, M, x, y, a, b, q, f);

% solve 
Eps = 1e-3;
v = jacobi(N, M, A, B, C, D, E, G, Eps, x, y, u);

graphics(x, y, v, 'approximation');
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














