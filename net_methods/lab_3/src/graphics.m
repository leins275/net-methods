function graphics(x, y, f, name)
    [X, Y] = meshgrid(y, x);
    figure;
    title(name);
    hold on;
    grid on;
    surf(X, Y, f);
end


