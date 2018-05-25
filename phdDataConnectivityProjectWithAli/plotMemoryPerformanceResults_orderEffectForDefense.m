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

[a b c d]=ttest2(pairMem.intactFam(1:2:20), pairMem.intactFam(2:2:20))
[a b c d]=ttest2(pairMem.intactNFam(1:2:20), pairMem.intactNFam(2:2:20))
[a b c d]=ttest2(pairMem.intactFam(1:2:20)-pairMem.intactNFam(1:2:20),...
    pairMem.intactFam(2:2:20)-pairMem.intactNFam(2:2:20))
[a b c d]=ttest2(pairMem.intactFam(1:2:20)+pairMem.intactNFam(1:2:20),...
    pairMem.intactFam(2:2:20)+pairMem.intactNFam(2:2:20))
dataall=[pairMem.intactFam(1:2:20) pairMem.intactFam(2:2:20) pairMem.intactNFam(1:2:20), pairMem.intactNFam(2:2:20)];
figure;
bar(mean(dataall));
hold on;
errorbar(mean(dataall),std(dataall,[],1))
ylim([0 1]);

x(:,1)= reshape(dataall,10*4,1)
x(:,2)=ones(1:40,1);
x(11:20,2)=2;
x(31:40,2)=2;
x(:,3)=1;
x(1:20,3)=2;

x(1:10,4)=1:10
x(21:30,4)=1:10
x(11:20,4)=11:20
x(31:40,4)=11:20
[P1 P2 P3] = BWAOVPicpair(x,.05)