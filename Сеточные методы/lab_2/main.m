clear;

%%
%  Задание параметров
a = 0.5; 
b = 2;
E = 1e-3;
d = E * 0.1;
N = 10000;

%while true
  tic
  E
  N
  disp('explicit:');
  [x, y, h, t, epsilon] = explicit(a, b, N, d);
  %disp('implicit:');
  %y = implicit(a, b, N);
  %disp('symmetric:');
  %y = symmetric(a, b, N);
  toc
  
  epsilon
 % if epsilon <= E
  %  break;
  %endif
  %N *= 2;
%endwhile

%  график
figure;
[T, X] = meshgrid(t, x);
plot3(X, T, y);






