% calculate integrals
function y = gauss(func, x0, x1, y0, y1, is_inv)
    elem = 1 / sqrt(3);
    ksi = [-elem, -elem, elem, elem];
    eta = [-elem, elem, -elem, elem];
    det = (x1 - x0)*(y1 - y0)/4;
    sum = 0;
    for i = 1:4
        xi = x0 + (ksi(i)+1)*(x1-x0)/2;
        yi = x0 + (eta(i)+1)*(y1-y0)/2;
        sum = sum + (func(xi, yi))^(is_inv);
    end
    y = det * sum;
end
