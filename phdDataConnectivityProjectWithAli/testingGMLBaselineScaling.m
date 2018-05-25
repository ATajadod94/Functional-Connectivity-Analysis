% This is a simple simulation to show how to compute the percentage of
% signal change using the GLM. Importantly, it also shows the effect of
% scaling the regressors.
%
% Cyril Pernet 03 May 2010
% http://www.sbirc.ed.ac.uk/cyril/bold_percentage/BOLD_percentage.html
% Let's make some fake data
cond1 = [89 90 91]; baseline = [99 100 101]; cond2 = [109 110 111];
y = [cond1 cond2 baseline cond1 cond2 baseline cond1 cond2 baseline]';


X1 = [1 1 1 0 0 0 0 0 0 1 1 1 0 0 0 0 0 0 1 1 1 0 0 0 0 0 0; ...
    0 0 0 1 1 1 0 0 0 0 0 0 1 1 1 0 0 0 0 0 0 1 1 1 0 0 0;
    1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1]';
beta1 = single(pinv(X1'*X1)*X1'*y);

figure
subplot(1,3,1); stairs(y,[27:-1:1]); title('Data'); grid on; axis tight
subplot(1,3,2);imagesc(X1);colormap('gray'); title('Proper Design matrix')
subplot(1,3,3);stairs(X1*beta1,[27:-1:1],'r','LineWidth',2); grid on; axis tight
title([{['model with cond1=',num2str(beta1(1))]} ; {['cond2=',num2str(beta1(2)),' and baseline=',num2str(beta1(3))]}]);

X2 = [1 1 1 0 0 0 0 0 0 1 1 1 0 0 0 0 0 0 1 1 1 0 0 0 0 0 0; ...
    0 0 0 1 1 1 0 0 0 0 0 0 1 1 1 0 0 0 0 0 0 1 1 1 0 0 0;
    0 0 0 0 0 0 1 1 1 0 0 0 0 0 0 1 1 1 0 0 0 0 0 0 1 1 1;
    1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1]';
beta2 = single(pinv(X2'*X2)*X2'*y);

figure
subplot(1,3,1); stairs(y,[27:-1:1]); title('Data'); grid on; axis tight
subplot(1,3,2);imagesc(X2);colormap('gray'); title('Wrong Design matrix')
subplot(1,3,3);stairs(X2*beta2,[27:-1:1],'r','LineWidth',2); grid on; axis tight
title([{['model with cond1=',num2str(beta2(1))]} ; {['cond2=',num2str(beta2(2)),' and baseline=',num2str(beta2(3))]}]);



X3 = [2 2 2 0 0 0 0 0 0 2 2 2 0 0 0 0 0 0 2 2 2 0 0 0 0 0 0; ...
    0 0 0 2 2 2 0 0 0 0 0 0 2 2 2 0 0 0 0 0 0 2 2 2 0 0 0;
    1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1]';
beta3 = pinv(X3'*X3)*X3'*y;

% makes figures
figure
subplot(1,3,1); stairs(y,[27:-1:1]); title('Data'); grid on; axis tight
subplot(1,3,2);imagesc(X3);colormap('gray'); title('Right Design matrix but wrong scaling')
subplot(1,3,3);stairs(X3*beta3,[27:-1:1],'r','LineWidth',2); grid on; axis tight
title([{['model with cond1=',num2str(beta3(1))]} ; {['cond2=',num2str(beta3(2)),' and baseline=',num2str(beta3(3))]}]);

% apply the correction
percentage = beta3(1:2)./beta3(3).*max(X3(:)).*100;

% look at the models - all 3 design matrices model the data the same ; t tests and R2 will be the same too
figure; hold on; title('the 3 models')
plot([1:27],X1*beta1,'-ob','LineWidth',2);
plot([1.1:27.1],X2*beta2,'-+g','LineWidth',2);
plot([1.2:27.2],X3*beta3,'-*r','LineWidth',2);
axis([0 28 89 111]);grid on