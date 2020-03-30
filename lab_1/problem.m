clear;
pkg load symbolic;  

u = inline('sin(e .^ x)');
du = inline('e.^x * cos(e .^ x)');
p = inline('e^x');
q = inline('(sin(x)).^2 + 1');
f = inline('-e ^ x * cos(e ^ x) + e ^ (2 * x) * sin(e ^ x) + p(x) * e ^ (x) * cos(e ^ x) + sin(e ^ x) * q(x)');

%%%
% specify params for task
%%%
a = 0.5;
b = 2.0;
alpha = [1, 1]; 
beta = [1, 1];
gamma = [-alpha(1)*du(a) + beta(1)*u(a), alpha(2)*du(b) + beta(2)*u(b)];

