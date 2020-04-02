clear;

N = 100;
EPS = 1e-4;

%plot_errors(N, 28, EPS);

calculate(100, 100, 1e-4 * pi^2*(1/N)^2/2, @jacobi); 
%calculate(100, 100, 1e-4 * pi^2*(1/N)^2, @zeidel); 
%calculate(28, 28, EPS * pi/N, @sor); 

%calculate(52, 52, 3.650002e-06, @jacobi); % EPS=1e-3;
%calculate(28, 28, 1e-9, @zeidel); % EPS=1e-3;
%calculate(100, 100, 1e-7 * pi/ 28, @sor); % EPS=1e-3;

function plot_errors(N, N2, EPS)
    w = 1.5;
    [u, q, a, b, f, x, y] = problem(N, N);
    [A, B, C, D, E, G] = fvm(N, N, x, y, a, b, q, f);
    [v, n, e1] = jacobi(N, N, A, B, C, D, E, G, EPS * pi^2*(1/N)^2/2, x, y, u, w); 
    [v, n, e2] = zeidel(N, N, A, B, C, D, E, G, EPS * pi^2*(1/N)^2, x, y, u, w);     
    
    [u, q, a, b, f, x, y] = problem(N2, N2);
    [A, B, C, D, E, G] = fvm(N2, N2, x, y, a, b, q, f);
    [v, n, e3] = sor(N2, N2, A, B, C, D, E, G, 1e-7 * pi/N2, x, y, u, w); 
    
    x1 = 1:length(e1);
    x2 = 1:length(e2);
    x3 = 1:length(e3);

    figure;
    hold on;
    grid on;
    xlabel('iterations: log(k)');
    ylabel('error: log(||u - v(k)||)');
    set(gca,'FontSize',14);
    plot(log(x1), log(e1), '-r', 'linewidth', 2);
    plot(log(x2), log(e2), '-g','linewidth', 2);
    plot(log(x3), log(e3), '-b','linewidth', 2);
    legend('Jacobi', 'zeidel', 'SOR', 'Location', 'southwest');
    %saveas(gcf, sprintf(sprintf('../pic/%s', 'compare')), 'epsc');
end

function calculate(N, M, epsIter, solver)
    w = 1.5;
    [u, q, a, b, f, x, y] = problem(N, M);
    [A, B, C, D, E, G] = fvm(N, M, x, y, a, b, q, f);
    U = um(x, y, u);
    
    if ~isequal(solver, @sor)
        [v, n] = solver(N, M, A, B, C, D, E, G, epsIter, x, y, u, w);
        MAX = max(max(abs(U - v)));
        fprintf("N = %d, M = %d, epsIter = %d \n", N, M, epsIter);
        fprintf("||u - v|| = %d \n", MAX);
        
        
        l = length(n)-1;
        x1 = zeros(1, l);
        y1 = zeros(1, l);
        for i = 1:l
            x1(i) = i;
            y1(i) = n(i+1) / n(i);
        end
        graphics2(x1, y1, 'zeidelSpectre', false, 'iterations', 'spectral radius');
        
    else
        l = 750;
        s = 1000;
        wi = zeros(1, l);
        ni = zeros(1, l);
        for i = 1:l
            wi(i) = 1 + (i-1) / s;
            [v, n] = solver(N, M, A, B, C, D, E, G, epsIter, x, y, u, wi(i));
            MAX = max(max(abs(U - v)));
            fprintf("n = %d, i = %d \n", n, i);
            fprintf("N = %d, M = %d, epsIter = %d\n", N, M, epsIter);
            fprintf("||u - v|| = %d \n", MAX);
            ni(i) = n;
        end
        graphics2(wi, ni, 'sor', false, 'omega', 'iters');
    end
    %graphics3(x, y, v, sprintf("||u - v|| = %d \n", MAX));
end

function graphics2(x, y, name, save, xl, yl)
    figure;
    %title(name);
    hold on;
    grid on;
    xlabel(xl);
    ylabel(yl);
    set(gca,'FontSize',14);
    plot(x, y, 'linewidth', 3);
    if save
        saveas(gcf, sprintf(sprintf('../pic/%s', name)), 'epsc');
    end
end

function graphics3(x, y, f, name)
    [X, Y] = meshgrid(y, x);
    figure;
    title(name);
    hold on;
    grid on;
    xlabel('x');
    ylabel('y');
    surf(X, Y, f);
end





