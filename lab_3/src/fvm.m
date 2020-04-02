function [A, B, C, D, E, G] = fvm(N, M, x, y, a, b, q1, f)
    A = zeros(N, M);
    B = zeros(N, M);
    C = zeros(N, M);
    D = zeros(N, M);
    E = zeros(N, M);
    G = zeros(N, M);
    
    hx = x(2) - x(1);
    hy = y(2) - y(1);
    a_inv = @(x, y) 1 ./ a(x,y);
    b_inv = @(x, y) 1 ./ b(x,y);
    
    p = @(i, j) hx*hy / quad2d(a_inv, x(i-1), x(i), y(j)-hy/2, y(j)+hy/2);
    q = @(i, j) hx*hy / quad2d(b_inv, x(i)-hx/2, x(i)+hx/2, y(j-1), y(j));
    
    q_int = @(i, j) quad2d(q1, x(i)-hx/2, x(i)+hx/2, y(j)-hy/2, y(j)+hy/2);
    g = @(i, j) quad2d(f, x(i)-hx/2, x(i)+hx/2, y(j)-hy/2, y(j)+hy/2);
        
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

