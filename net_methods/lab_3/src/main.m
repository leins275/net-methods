clear;

EPS = 1e-4; % const

solver = @jacobi;
N = 112;
M = 100;
epsIter = 9e-7;

[u, q, a, b, f, x, y] = problem(N, M);
[A, B, C, D, E, G] = fvm(N, M, x, y, a, b, q, f);
U = print_u(x, y, u);
v = solver(N, M, A, B, C, D, E, G, epsIter, x, y, u);
MAX = max(max(abs(U - v)));
fprintf("N = %d, M = %d, epsIter = %d \n", N, M, epsIter);
fprintf("||u - v|| = %d \n", MAX);
% graphics(x, y, v, sprintf("||u - v|| = %d \n", MAX));
    
function um = print_u(x, y, f)
    M = length(y);
    N = length(x);
    um = zeros(N, M);
    
    for i = 1:N
        for j = 1:M
            um(i, j) = f(x(i), y(j));
        end
    end    
    % graphics(x, y, um, 'origin');
end










