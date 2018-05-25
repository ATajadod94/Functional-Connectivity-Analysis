function [zpf,pval] = MengTest(a1, b1, b2,n)
%test correlation between a1,a2 differ from corr between a1 b2.within
%participants, a1, b1, and b2 are related
% Meng, X., Rosenthal, R., & Rubin, D. B. (1992). Comparing correlated correlation coefficients. Psychological Bulletin, 111(1), 172–175. https://doi.org/10.1037/0033-2909.111.1.172

x=[a1 b1 b2];
xx = corr(x);
z1=.5*log((1+xx(1,2))/(1-xx(1,2)));
z2=.5*log((1+xx(1,3))/(1-xx(1,3)));
r=xx(2,3);
f = (1-r)/(2*(1-(xx(1,2)^2+xx(1,3)^2)/2));
if f>1 f=1;end

meanR2= (xx(1,2)^2+xx(1,3)^2)/2;
h = 1+ (meanR2/(1-meanR2))*(1-f);
zpf = (z1-z2)*(sqrt((n-3)/(2*(1-r)*h)));
pval = 2*normcdf(-zpf,0,1);