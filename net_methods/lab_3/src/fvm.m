function [A, B, C, D, E, G] = fvm(N, M, x, y, a, b, q1, f)
    A = zeros(N, M);
    B = zeros(N, M);
    C = zeros(N, M);
    D = zeros(N, M);
    E = zeros(N, M);
    G = zeros(N, M);
    
    hx = x(2) - x(1);
    hy = y(2) - y(1);
    
    p = @(i, j) hx*hy / gauss(a, x(i-1), x(i), y(j)-hy/2, y(j)+hy/2, -1);
    q = @(i, j) hx*hy / gauss(b, x(i)-hx/2, x(i)+hx/2, y(j-1), y(j), -1);
    
    q_int = @(i, j) gauss(q1, x(i)-hx/2, x(i)+hx/2, y(j)-hy/2, y(j)+hy/2,1);
    g = @(i, j) gauss(f, x(i)-hx/2, x(i)+hx/2, y(j)-hy/2, y(j)+hy/2,1);
        
    for i = 2:N-1
        for j = 2:M-1
            A(i, j) = ((p(i+1, j) + p(i, j))/hx^2 + ...
                (q(i, j+1) + q(i, j))/hy^2 + q_int(i, j)/hx/hy);
            D(i, j) = - p(i, j) / hx^2;
            B(i, j) = - p(i+1, j) / hx^2;
            C(i, j) = - q(i, j) / hy^2; 
            E(i, j) = - q(i, j+1) / hy^2;
            G(i, j) = g(i, j)/hx/hy;
        end
    end
end

