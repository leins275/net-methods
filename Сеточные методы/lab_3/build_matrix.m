% build matrix
% TODO: reduce sparse matrix indexing
function [m, r] = build_matrix(N, x, y, a, b, q1, f)
    m = sparse(N, N);
    r = zeros(N, 1);
    hx = x(2) - x(1);
    hy = y(2) - y(1);
    
    p = @(i, j) 1/hx/hy * gauss(a, x(i), x(i+1), y(j)-hy/2, y(j)+hy/2, -1);
    q = @(i, j) 1/hx/hy * gauss(b, x(i), x(i+1), y(j)-hy/2, y(j)+hy/2, -1);
    q_int = @(i, j) 1/hx/hy * gauss(q1, x(i)-hx/2, x(i)+hx/2, y(j)-hy/2, y(j)+hy/2, 1);
    g = @(i, j) 1/hx/hy * gauss(f, x(i)-hx/2, x(i)+hx/2, y(j)-hy/2, y(j)+hy/2, 1);
    % edge points
    for i = 1:N
        m(1, i) = u(x(i), y(1));
        m(N, i) = u(x(i), y(N));
        m(i, 1) = u(x(1), y(i));
        m(i, N) = u(x(N), y(i));
        r(1) = f(x(1), y(1));
        r(N) = f(x(N), y(N));
    end
        
    % inner points
    for i = 2:N-1
        for j = 2:N-1
            m(i, j) = - ((p(i+1, j) + p(i, j))/hx^2 + ...
                (q(i+1, j) + q(i, j))/hy^2 + q_int(i, j));
            m(i-1, j) = p(i, j) / hx^2;
            m(i+1, j) = p(i+1, j) / hx^2;
            m(i, j-1) = q(i, j) / hy^2;
            m(i, j+1) = q(i, j+1) / hy^2;
            r(i) = g(i, j);
        end
    end
end

