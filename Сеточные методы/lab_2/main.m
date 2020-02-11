%%
%  Задание параметров
a = 0.5; 
b = 2;
E = 1e-3; 
d = E * 0.1;

%{
N1 = 120000;
N2 = 130000;
is_left = true;

fprintf('E: %d \n\n', E);
[x, y, h, t, epsilon2] = explicit(a, b, N2, d);
while true
  %tic  
  disp('explicit:');
  
  if is_left
    [x, y, h, t, epsilon1] = explicit(a, b, N1, d);
  else
    [x, y, h, t, epsilon2] = explicit(a, b, N2, d);
  end
  
  fprintf('N1: %d, epsilon1: %d \n\n', N1, epsilon1);
  fprintf('N2: %d, epsilon2: %d \n\n', N2, epsilon2);
  
  if N2 - N1 < 2
      break; 
  end
  
  if abs(E - epsilon1) < abs(E - epsilon2)
      N2 = N2 - ceil((N2 - N1) / 2);
      is_left = false;
  else 
      N1 = N1 + floor((N2 - N1) / 2);
      is_left = true;
  end
  
  %disp('implicit:');
  %[x, y, h, t, epsilon] = implicit(a, b, N, d, 1);
  %disp('symmetric:');
  %[x, y, h, t, epsilon] = implicit(a, b, N, d, 0.5);
  %toc
end
%}

N = 10;% 126502;
tic
[x, y, h, t, epsilon] = implicit(a, b, N, d, 1);
toc

% график
figure;
set(gca,'FontSize',20);
grid on;
% [T, X] = meshgrid(t(1:50:length(t)), x(1:100:length(x)));
[T, X] = meshgrid(t, x);
y1 = y(1:100:length(x), 1:50:length(t));
plot3(X, T, y);
xlabel('x');
ylabel('t');
zlabel('v');






