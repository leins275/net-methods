function y = norm2(x, h)
  sum = 0;
  
  for i=2:length(x)-1
    sum = sum + (x(i).^2)*h;
  end
  
  y = sqrt(sum);

