function design = williams(n)
% Ian Nimmo-Smith (MRC CBU) April 2003
cyclic = toeplitz([1,(n:(-1):2)],[1:n]);
cyclic = cyclic([1,(n:(-1):2)],:);
baseperm = [1];
half = floor(n/2);
if n == 2*half    % even
    for j = 1:(half-1)
        baseperm = [baseperm, j+1, n-j+1];
    end
    baseperm = [baseperm, half+1];
else              % odd
    for j = 1:half
        baseperm = [baseperm, j+1, n-j+1];
    end
end
design = cyclic(:,baseperm);
if n ~= 2*half
    design = [design;design(:,(n:(-1):1))];
end  