clear;
a = 0.5; 
b = 2;
E = 1e-3; 
d = E * 0.1;
N = 100000; %136984;

%{
tic
[x, y, h, t, epsilon] = explicit(a, b, N, d);
disp('Explicit');
fprintf("tau:%d, h:%d, N:%d, eps:%d\n", t(2) - t(1), h, N, epsilon);
toc

clear;
a = 0.5; 
b = 2;
E = 1e-3; 
d = E * 0.1;
N = 160000; %136984;

tic
[x1, y1, h, t, epsilon] = implicit(a, b, N, d, 1);
disp('Implicit');
fprintf("tau:%d, h:%d, N:%d, eps:%d\n", t(2) - t(1), h, N, epsilon);
toc

clear;
a = 0.5; 
b = 2;
E = 1e-3; 
d = E * 0.1;
N = 160000; %136984;

tic
[x2, y2, h, t, epsilon] = implicit(a, b, N, d, 0.5);
disp('Symmetric');
fprintf("tau:%d, h:%d, N:%d, eps:%d\n", t(2) - t(1), h, N, epsilon);
toc
fprintf("\n");
%}  

tic
[x, y, h, t, epsilon] = explicit(a, b, N, d);
fprintf("tau:%d, h:%d, N:%d, eps:%d\n", t(2) - t(1), h, N, epsilon);
toc

%{
h1 = (b-a) / N;
ts = h1^2 / q(b) / 2;
tsm = [ts];
epsm = [];
while true
    tic
    [x, y, h, t, epsilon] = implicit(ts, a, b, N, d, 0.5);
    toc
    fprintf("tau:%d, h:%d, N:%d, eps:%d\n", t(2) - t(1), h, N, epsilon);
    
    epsm = [epsm, epsilon];
    if epsilon >= E 
        break;
    else
        ts = ts * 1.5;
        tsm = [tsm, ts];
    end
end
%}

%{
%  поиск M_0 методом половинного деления в явной схеме
N1 = 120000;
N2 = 150000;
is_left = true;
fprintf('E: %d \n\n', E);
[x, y, h, t, epsilon2] = explicit(a, b, N2, d);
while true
  tic  
  disp('explicit:');
  
  if is_left
    [x, y, h, t, epsilon1] = explicit(a, b, N1, d);
  else
    [x, y, h, t, epsilon2] = explicit(a, b, N2, d);
  end
  toc
  
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
end
%}








