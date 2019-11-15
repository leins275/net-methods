problem; % setup problem (partically hardcoded in FDM and in FEM)

n = 8; % num of nodes
N = 1000;
x1 = linspace(0, 1, N);

% [v, x, h] = FiniteDiffMethod(n, a, b);
[v, x, h] = FiniteElemMethod(n, a, b);

% normL2_u = my_norm(v, x, u, false);
normL2_du = my_norm(v, x, du, true);
  

%{
for i = 1:4
  [v, x, h] = FiniteElemMethod(n, a, b);
  
  normL2_u = my_norm(v, x, u, false);
  normL2_du = my_norm(v, x, du, true);
  
  hi(i) = h;
  normL2_ui(i) = normL2_u;
  normL2_dui(i) = normL2_du;
  
  h
  normL2_u
  
  n = n .* 2;
endfor
%}

%{
figure;
hold on;
grid on;
axis([min(hi), max(hi), min(normL2_ui), max(normL2_ui)]);
loglog(hi,normL2_ui, 'linewidth', 2);
x2 = [0, 0.01];
y2 = 2 .* x2;
plot(x2, y2, 'r');
%}

%{
figure;
title('Diff, L2 norm hist, h(i+1) = h(i) / 2');
xlabel('step');
ylabel('L2 norm value between real and approx')
bar(normL2_dui);

figure;
title('Function, L2 norm hist, h(i+1) = h(i) / 2');
xlabel('step');
ylabel('L2 norm value between real and approx')
bar(normL2_ui);
%}

% graphics;



