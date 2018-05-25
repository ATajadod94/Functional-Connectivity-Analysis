function [zpf,pval] = ZPFTest(a1, a2, b1, b2,n)
%test correlation between a1,a2 differ from corr between b1 b2.within
%participants, and a1 b1 can be related and a2 b2 can be related ZPF test
% Raghunathan,Rosenthal, Rubin: Comparing correlated but nonoverlapping correlations, psychologyical methods, 1996, 1,178-183 
x=[a1 a2 b1 b2];
xx = corr(x);
k = (xx(1,3)-xx(2,3)*xx(1,2))*(xx(2,4)-xx(2,3)*xx(3,4)) + ...
    (xx(1,4)-xx(1,3)*xx(3,4))*(xx(2,3)-xx(1,3)*xx(1,2)) + ...
    (xx(1,3)-xx(1,4)*xx(3,4))*(xx(2,4)-xx(1,4)*xx(1,2)) + ...
    (xx(1,4)-xx(1,2)*xx(2,4))*(xx(2,3)-xx(2,4)*xx(3,4));

z1=.5*log((1+xx(1,2))/(1-xx(1,2)));
z2=.5*log((1+xx(3,4))/(1-xx(3,4)));
zpf = sqrt((n-3)/2)*(z1-z2)/sqrt(1-(k/(2*(1-xx(1,2)^2)*(1-xx(3,4)^2))));
pval = 2*normcdf(-zpf,0,1);