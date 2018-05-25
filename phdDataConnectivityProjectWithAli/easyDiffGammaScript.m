load('C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\matlabFunctions\easyDiffiPicScrmbleIncludedSubj.mat');
load('performanceDataConcatenated.mat');
load('easyDiffGamma.mat');
[yfam, ynfam fh sc fh_sc] = plotEasyDiffPicVsScrambleBarGraphs(0);
pairM = pairMem.intactFam+pairMem.intactNFam;
pairM = pairM(idIncluded);
[a b]=corr(pairM,g')
figure;scatter(pairM,g');
[a b]=corr(pairMem.intactFam(idIncluded),g')
[a b]=corr(pairMem.intactNFam(idIncluded),g')
[a b]=corr(pairM,yfam(:,1))
figure;scatter(pairM,yfam(:,1));

[a b]=corr(pairM,yfam(:,2))
figure;scatter(pairM,yfam(:,2));

[a b]=corr(pairM,yfam(:,2)+yfam(:,1))
figure;scatter(pairM,yfam(:,2)+yfam(:,1));

[a b]=corr(g',yfam(:,2))
figure;scatter(g',yfam(:,2));

[a b]=corr(g',yfam(:,1))
figure;scatter(g',yfam(:,1));