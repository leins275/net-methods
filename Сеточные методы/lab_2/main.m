clear;
%%
%  Задание параметров
a = 0.5; 
b = 2;
E = 1e-3; 
d = E * 0.1;
N = 80000; 

fprintf('E: %d \n\n', E);
while true
  tic
  fprintf('N: %d \n', N);
  
  disp('explicit:');
  [x, y, h, t, epsilon] = explicit(a, b, N, d);
  %disp('implicit:');
  %[x, y, h, t, epsilon] = implicit(a, b, N, 1);
  %disp('symmetric:');
  %[x, y, h, t, epsilon] = implicit(a, b, N, 0.5);
  toc
  
  fprintf('epsilon: %d \n\n', epsilon);
  if epsilon <= E
    break;
  end
  N = N * 2;
end

%  график
%figure;
%[T, X] = meshgrid(t, x);
%plot3(X, T, y);






