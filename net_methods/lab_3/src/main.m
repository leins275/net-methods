clear;

N = 100;
EPS = 1e-4;
%calculate(N, N, EPS*pi^2*(1/N)^2/2, @jacobi); % 100 1e-4
%calculate(N, N, EPS*pi^2*(1/N)^2, @zeidel); %100 1e-4
%calculate_sor(N, N, EPS*pi/N); % 28, 1e-7

%calculate(N, N, EPS*pi^2*(1/N, @sor); 

plot_errors(N, EPS)

function plot_errors(N, EPS)
    [u, q, a, b, f, x, y] = problem(N, N);
    [A, B, C, D, E, G] = fvm(N, N, x, y, a, b, q, f);
    U = print_u(x, y, u);
    [v, e1] = jacobi(N, N, A, B, C, D, E, G, EPS*pi^2*(1/N)^2/2, x, y, u, U); 
    [v, e2] = zeidel(N, N, A, B, C, D, E, G, EPS*pi^2*(1/N)^2, x, y, u, U);     
    
    N=28;
    [u, q, a, b, f, x, y] = problem(N, N);
    [A, B, C, D, E, G] = fvm(N, N, x, y, a, b, q, f);
    U = print_u(x, y, u);
    [v, e3] = sor(N, N, A, B, C, D, E, G, 1e-7*pi/N, x, y, u, 1.5, U); 
    
    l1 = length(e1);
    x1 = zeros(1, l1);
    y1 = zeros(1, l1);
    for i=1:l1
        x1(i) = i;
        y1(i) = e1(i);
    end
    for i=1:length(e2)
        x2(i) = i;
        y2(i) = e2(i);
    end
    
    for i=1:length(e3)
        x3(i) = i;
        y3(i) = e3(i);
    end
    
    figure;
    hold on;
    grid on;
    xlabel('iterations (k)');
    ylabel('error (||u - v(k)||)');
    set(gca,'FontSize',14);
    axis([0, 4000, 0, 1]);
    plot(x1, y1, '-r', 'linewidth', 3);
    plot(x2, y2, '-g','linewidth', 3);
    plot(x3, y3, '-b','linewidth', 3);
    legend('Jacobi', 'zeidel', 'SOR');
    %saveas(gcf, sprintf(sprintf('../pic/%s', 'aaa')), 'epsc');
end

function um = print_u(x, y, f)
    M = length(y);
    N = length(x);
    um = zeros(N, M);
    
    for i = 1:N
        for j = 1:M
            um(i, j) = f(x(i), y(j));
        end
    end    
    % graphics3(x, y, um, 'origin');
end

function calculate(N, M, epsIter, solver)
    [u, q, a, b, f, x, y] = problem(N, M);
    [A, B, C, D, E, G] = fvm(N, M, x, y, a, b, q, f);
    U = print_u(x, y, u);
    [v, n] = solver(N, M, A, B, C, D, E, G, epsIter, x, y, u);
    MAX = max(max(abs(U - v)));
    fprintf("N = %d, M = %d, epsIter = %d \n", N, M, epsIter);
    fprintf("||u - v|| = %d \n", MAX);
    % graphics3(x, y, v, sprintf("||u - v|| = %d \n", MAX));
    
    l = length(n)-1;
    x1 = zeros(1, l);
    y1 = zeros(1, l);
    for i = 1:l
        x1(i) = i;
        y1(i) = n(i+1) / n(i);
    end
    %graphics2(x1, y1, 'zeidelSpectre', false, 'iterations', 'spectral radius');
    %graphics3(x, y, v, sprintf("||u - v|| = %d \n", MAX));
end

function calculate_sor(N, M, epsIter)
    [u, q, a, b, f, x, y] = problem(N, M);
    [A, B, C, D, E, G] = fvm(N, M, x, y, a, b, q, f);
    U = print_u(x, y, u);
    
    %l = 75;
    %s = 100;
    %wi = zeros(1, l);
    %ni = zeros(1, l);
    %for i = 1:l
    %    wi(i) = 1 + (i-1) / s;
        [v, n] = sor(N, M, A, B, C, D, E, G, epsIter, x, y, u, 1.73);
        MAX = max(max(abs(U - v)));
        fprintf("i = %d, n = %d, epsIter = %d \n", 1, n, epsIter);
        fprintf("||u - v|| = %d \n", MAX)
    %    ni(i) = n;
    %end
    %graphics2(wi, ni, 'sor', false, 'omega', 'iterations');
    %graphics3(x, y, U, sprintf("||u - v|| = %d \n", MAX));
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





