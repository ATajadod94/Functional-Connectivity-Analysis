function results = regressionSlopDiff(x1,x2,y1,y2)
x1=replaceOutliers(x1,2.5,2);
x2=replaceOutliers(x2,2.5,2);
y1=replaceOutliers(y1,2.5,2);
y2=replaceOutliers(y2,2.5,2);
xdum = zeros(length(x1)+length(x2),1);
xdum(1:length(x1))=1;
xnew = cat(1,x1,x2);
ynew = cat(1,y1,y2);
xinter = zscore(xdum).*zscore(xnew);

[a b resultsMeth1]=glmfit([xnew,xdum,xinter],ynew);

% method 2
%http://www.danielsoper.com/statcalc3/calc.aspx?id=103
% Soper, D.S. (2015). Significance of the Difference between Two Slopes Calculator [Software]. Available from http://www.danielsoper.com/statcalc
% Cohen, J., Cohen, P., West, S.G., and Aiken, L.S. (2003). Applied Multiple Regression/Correlation Analysis for the Behavioral Sciences (3rd edition). page 46-47  Mahwah, NJ: Lawrence Earlbaum Associates.
% 

[a1 b1 c1]=glmfit(x1,y1);
[a2 b2 c2]=glmfit(x2,y2);

tval = (c1.beta(2)-c2.beta(2))/sqrt(c1.se(2)^2+c2.se(2)^2);
pval = 1*(1-tcdf(abs(tval),length(x1)*2-4)); % one tail
resultsMeth2.slope1 = c1;
resultsMeth2.slope2 = c2;
resultsMeth2.slopeDifft = tval;
resultsMeth2.slopeDiffp = pval;

results.method1=resultsMeth1;
results.method2=resultsMeth2;