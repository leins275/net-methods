function y = u_sym()
    syms func(x,t)
    %func(x,t) = sin(exp(x)) * (1 + x*exp(-3*t));
    func(x,t) = x^2 * (1 + x*exp(-3*t));
    y = func;