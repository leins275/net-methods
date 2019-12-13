pkg load msh;
clear;

% build mesh
n = 10;
min = 1;
max = 10;
x = linspace(min, max, n);
y = linspace(min, max, n);
p = [0, 0, 0, 0];
s = 3
mesh = msh2m_structured_mesh(x, y, s, p);
msh2p_mesh(mesh);

