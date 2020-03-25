function [v, n, error] = sor(N, M, A, B, C, D, E, G, Eps, x, y, u, w)    
    U = um(x, y, u);
    n = 0;
    v0 = ones(N, M);
    for j = 1:M
        v0(1, j) = u(x(1), y(j));
        v0(N, j) = u(x(N), y(j));
    end
    for i = 1:N
        v0(i, 1) = u(x(i), y(1));
        v0(i, M) = u(x(i), y(M));
    end
    v1 = v0;
    
    error = [];
    while 1
        n = n + 1;
        for i = 2:N-1
            for j = 2:M-1
                v1(i, j) =  (G(i, j) - ...
                  C(i, j)*v1(i, j-1) - D(i, j)*v1(i-1, j) - ...
                  B(i, j)*v0(i+1, j) - E(i, j)*v0(i, j+1)) / A(i, j);
            end
        end
        
        v1 = v0 + w * (v1 - v0);
        error = [error, max(max(abs(U - v0)))];
        
        if max(max(abs(v1 - v0))) < Eps 
            break;
        end
        v0 = v1;
    end
    v = v1; 
end

