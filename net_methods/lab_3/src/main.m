clear;

% setup the task
N = 10; 
M = 300;
[u, q, a, b, f, x, y] = problem(N, M);

U = um(x, y, u);
graphics(x, y, U, 'origin');

% calculate coefs with fvm method
[A, B, C, D, E, G] = fvm(N, M, x, y, a, b, q, f);

% solve 
epsIter = 1e-9;
v = jacobi(N, M, A, B, C, D, E, G, epsIter, x, y, u);

graphics(x, y, v, 'approximation');
fprintf("||u - v|| = %d \n", max(max(abs(U - v))));

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














