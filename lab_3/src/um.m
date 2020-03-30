function um = um(x, y, f)
    M = length(y);
    N = length(x);
    um = zeros(N, M);
    
    for i = 1:N
        for j = 1:M
            um(i, j) = f(x(i), y(j));
        end
    end    
end