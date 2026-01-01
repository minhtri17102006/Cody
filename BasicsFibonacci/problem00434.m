function y = problem00434(N)
tic
  y = fibo(N);
    function y = fibo(n)
        y = [1 1];
        
        while y(end) < n
            y(end+1) = y(end) + y(end-1);
        end
        if y(end) >= n
            y(end) = [];
        end
    end
toc
%tu
end