function graphics(x, y, f, name)
    [X, Y] = meshgrid(y, x);
    figure;
    title(name);
    hold on;
    grid on;
    xlabel('x');
    ylabel('y');
    surf(X, Y, f);
end


