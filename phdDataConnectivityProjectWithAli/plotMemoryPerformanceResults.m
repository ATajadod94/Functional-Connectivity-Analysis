function plotMemoryPerformanceResults
rootDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\';
load([rootDir,'matlabFunctions\performanceDataConcatenated.mat']);
load([rootDir,'matlabFunctions\encodingEasyDiffEvalMTotal.mat']);
myFontSize=8;

faceMem.totalFam = replaceOutliers(faceMem.totalFam,2.5,2);
faceMem.totalNFam = replaceOutliers(faceMem.totalNFam,2.5,2);
faceMem.firstFam = replaceOutliers(faceMem.firstFam,2.5,2);
faceMem.firstNFam = replaceOutliers(faceMem.firstNFam,2.5,2);
faceMem.secondFam = replaceOutliers(faceMem.secondFam,2.5,2);
faceMem.secondNFam = replaceOutliers(faceMem.secondNFam,2.5,2);

houseMem.totalFam = replaceOutliers(houseMem.totalFam,2.5,2);
houseMem.totalNFam = replaceOutliers(houseMem.totalNFam,2.5,2);
houseMem.firstFam = replaceOutliers(houseMem.firstFam,2.5,2);
houseMem.firstNFam = replaceOutliers(houseMem.firstNFam,2.5,2);
houseMem.secondFam = replaceOutliers(houseMem.secondFam,2.5,2);
houseMem.secondNFam = replaceOutliers(houseMem.secondNFam,2.5,2);

pairMem.intactFam = replaceOutliers(pairMem.intactFam,2.5,2);
pairMem.intactNFam = replaceOutliers(pairMem.intactNFam,2.5,2);

pairMem.recomFam = replaceOutliers(pairMem.recomFam,2.5,2);
pairMem.recomNFam = replaceOutliers(pairMem.recomNFam,2.5,2);

pairMem.avgFam = replaceOutliers(pairMem.avgFam,2.5,2);
pairMem.avgNFam = replaceOutliers(pairMem.avgNFam,2.5,2);

my_barvalues = [mean(faceMem.totalFam), mean(faceMem.totalNFam)];
my_errors = [std(faceMem.totalFam), std(faceMem.totalFam)]/sqrt(length(faceMem.totalFam)-1);
[H,P,CI,STATS] = ttest(faceMem.totalFam,faceMem.totalNFam);
plot2BarFig(my_barvalues,my_errors,'FaceMemoryTotal',myFontSize,'Accuracy',P,STATS);

my_barvalues = [mean(faceMem.firstFam), mean(faceMem.firstNFam)];
my_errors = [std(faceMem.firstFam), std(faceMem.firstFam)]/sqrt(length(faceMem.firstFam)-1);
[H,P,CI,STATS] = ttest(faceMem.firstFam,faceMem.firstNFam);
plot2BarFig(my_barvalues,my_errors,'FirstFaceMemory',myFontSize,'Accuracy',P,STATS);

my_barvalues = [mean(faceMem.secondFam), mean(faceMem.secondNFam)];
my_errors = [std(faceMem.secondFam), std(faceMem.secondFam)]/sqrt(length(faceMem.secondFam)-1);
[H,P,CI,STATS] = ttest(faceMem.secondFam,faceMem.secondNFam);
plot2BarFig(my_barvalues,my_errors,'SecondFaceMemory',myFontSize,'Accuracy',P,STATS);

my_barvalues = [mean(houseMem.totalFam), mean(houseMem.totalNFam)];
my_errors = [std(houseMem.totalFam), std(houseMem.totalFam)]/sqrt(length(houseMem.totalFam)-1);
[H,P,CI,STATS] = ttest(houseMem.totalFam,houseMem.totalNFam);
plot2BarFig(my_barvalues,my_errors,'HouseMemoryTotal',myFontSize,'Accuracy',P,STATS);

my_barvalues = [mean(houseMem.firstFam), mean(houseMem.firstNFam)];
my_errors = [std(houseMem.firstFam), std(houseMem.firstFam)]/sqrt(length(houseMem.firstFam)-1);
[H,P,CI,STATS] = ttest(houseMem.firstFam,houseMem.firstNFam);
plot2BarFig(my_barvalues,my_errors,'FirstHouseMemory',myFontSize,'Accuracy',P,STATS);

my_barvalues = [mean(houseMem.secondFam), mean(houseMem.secondNFam)];
my_errors = [std(houseMem.secondFam), std(houseMem.secondFam)]/sqrt(length(houseMem.secondFam)-1);
[H,P,CI,STATS] = ttest(houseMem.secondFam,houseMem.secondNFam);
plot2BarFig(my_barvalues,my_errors,'SecondHouseMemory',myFontSize,'Accuracy',P,STATS);

my_barvalues = [mean(pairMem.intactFam), mean(pairMem.intactNFam)];
my_errors = [std(pairMem.intactFam), std(pairMem.intactNFam)]/sqrt(length(pairMem.intactFam)-1);
[H,P,CI,STATS] = ttest(pairMem.intactFam,pairMem.intactNFam);
plot2BarFig(my_barvalues,my_errors,'AssociativeMemoryIntact',myFontSize,'Accuracy',P,STATS);


my_barvalues = [mean(pairMem.recomFam), mean(pairMem.recomNFam)];
my_errors = [std(pairMem.recomFam), std(pairMem.recomNFam)]/sqrt(length(pairMem.recomFam)-1);
[H,P,CI,STATS] = ttest(pairMem.recomFam,pairMem.recomNFam);
plot2BarFig(my_barvalues,my_errors,'AssociativeMemoryRecombined',myFontSize,'Accuracy',P,STATS);

my_barvalues = [mean(pairMem.avgFam), mean(pairMem.avgNFam)];
my_errors = [std(pairMem.avgFam), std(pairMem.avgNFam)]/sqrt(length(pairMem.avgFam)-1);
[H,P,CI,STATS] = ttest(pairMem.avgFam,pairMem.avgNFam);
plot2BarFig(my_barvalues,my_errors,'AssociativeMemoryAveraged',myFontSize,'Accuracy',P,STATS);


%repeated anova for intactpair, facetotal, housetotal (Cheryl suggestion)
x(:,1) = cat(1,pairMem.intactFam, pairMem.intactNFam, faceMem.totalFam, faceMem.totalNFam,...
    houseMem.totalFam, houseMem.totalNFam);
x(:,2)=repmat([1:20]',6,1);
x(:,3)=cat(1,ones(40,1),ones(40,1)*2,ones(40,1)*3);
x(:,4)=repmat([ones(20,1);ones(20,1)*2],3,1)
  
fac1={'pair','face','house'};
fac2={'famous','nonfamous'};
FACTNAMES={'type','fame'};
stats=rm_anova2(x(:,1),x(:,2),x(:,3),x(:,4),FACTNAMES)

function plot2BarFig(my_barvalues,my_errors,myFigTitle,myFontSize,myYLabel,P,STATS)
s=figure;

bw_legend={'Famous','NonFamous'};
% x_label{1} = 'Famous';
% x_label{2} = 'NonFamous';
h=barweb(my_barvalues, my_errors, .9, [], [], [], myYLabel, gray, [], bw_legend, 1, 'axis',0,8);
title(myFigTitle);
ylim([0,1]);
axis xy
box off 
set(gcf,'Color','w');

set(gca,'LineWidth',1);
text(1,0.8,0,['p < ' num2str(P),',','t = ',num2str(STATS.tstat)]);
setfigsize(s,myFontSize,'Arial',myFontSize,'Arial',8,8);
%save figures
figDir = pwd;
figDir = strrep(figDir,'matlabFunctions','behavioralFigs\');
if ~exist(figDir,'dir')
    mkdir(figDir);
end
% export_fig([figDir,myFigTitle,myYLabel],'-tiff','-r300');
plot2svg([figDir,myFigTitle,myYLabel,'.svg'],s);





