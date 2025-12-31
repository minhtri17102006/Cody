function f = problem00012(n)
tic
  if n <= 2
      f = 1;
  else
      f = fib(n-1)+fib(n-2);
  end
  toc
  %hmtri
end