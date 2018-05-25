function plotEasyDiffPredictionDistributions

load('faceEvalPredictEasyDiff.mat');
surrogatebval = mean(surrogatebval,4);

close all;
for i = 1:4
    if i ==1 | i ==4
   x(:,i) = squeeze(mean(surrogatebval(i,1:2,:),2));
   x1(i)=mean(mean(bval(i,1:2,:),2),3);
    else
        
       x(:,i) = squeeze(mean(surrogatebval(i,1:2,:),2));
       x1(i)=mean(mean(bval(i,1:2,:),2),3);
    end
    
% figure;
hist(x(:,i),30);
hold on;
h=line([x1(i) x1(i)],[0,2000]);
set(h,'Color','r');
ci1(i)=nearest(sort(x(:,i)),x1(i));
ci2(i)=nearest(sort(x(:,i)),-1*x1(i));
p(i) = 1- abs(ci2(i)-ci1(i))/size(x,1);
end


load(['C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\matlabFunctions\picEasyDiffInterSubjCorr.mat']);

figure;
hist(surrogateCorr,20);
mf = nanmean(faceCorr);
mh = nanmean(houseCorr);
hold on;
xx1=[cat(1,mf',mh'),cat(1,mf',mh')];
xx2 = [zeros(8,1),ones(8,1)*2500];
for i = 1:8
line(xx1(i,:),xx2(i,:));
ci1(i)=nearest(sort(surrogateCorr),xx1(i,1));
ci2(i)=nearest(sort(surrogateCorr),-1*xx1(i,1));
p2(i) = 1-  abs(ci2(i)-ci1(i))/length(surrogateCorr);
end


a=squeeze(mean(bval(1,1:4,:),2));
a(abs(zscore(a))>2)=0




nanmean(nanmean(surrogateCorr))
std(surrogateCorr,[],2)