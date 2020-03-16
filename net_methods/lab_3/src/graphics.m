function graphics(x, y, f)
    [X, Y] = meshgrid(y, x);
    figure;
    hold on;
    grid on;
    surf(X, Y, f);
end


