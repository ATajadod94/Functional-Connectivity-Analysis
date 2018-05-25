function plotHPCConnectivityPredictPairMemory

dataPath1= 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelReg_PPI_fameOderRegressedoutOfMem\R_HPC\pairMemoryFam';
dataPath2 = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelReg_PPI_fameOderRegressedoutOfMem\R_HPC\pairMemoryNonFam';

s1 = figure;
load(fullfile(dataPath1,'VOI_VOI-R-vmPFC.mat'));
load(fullfile(dataPath1,'SPM.mat'));
plot(mean(xY.y,2),SPM.xX.X(:,4),'s');
a1=lsline
[a b c d e]= regress(SPM.xX.X(:,4),[ones(20,1),mean(xY.y,2)])
xlabel('R-HPC - R-vmPFC connectivity');
ylabel('Associative memory');
ylim([-.4 .6]);
title('famouse condition');


s2 = figure;
load(fullfile(dataPath1,'VOI_VOI-L-TPL.mat'));
load(fullfile(dataPath1,'SPM.mat'));
plot(mean(xY.y,2),SPM.xX.X(:,4),'s');
a=lsline
[a b c d e]= regress(SPM.xX.X(:,4),[ones(20,1),mean(xY.y,2)])
xlabel('R-HPC - L-TPL connectivity');
ylabel('Associative memory');
ylim([-.4 .6]);
title('famouse condition');

s2 = figure;
load(fullfile(dataPath1,'VOI_VOI-R-Occipital.mat'));
load(fullfile(dataPath1,'SPM.mat'));
plot(mean(xY.y,2),SPM.xX.X(:,4),'s');
a=lsline
[a b c d e]= regress(SPM.xX.X(:,4),[ones(20,1),mean(xY.y,2)])
xlabel('R-HPC - R-Occipital connectivity');
ylabel('Associative memory');
ylim([-.4 .6]);
title('famouse condition');

s3 = figure;
load(fullfile(dataPath1,'VOI_VOI-R-Caudate.mat'));
load(fullfile(dataPath1,'SPM.mat'));
plot(mean(xY.y,2),SPM.xX.X(:,4),'*');
a2=lsline
[a b c d e]= regress(SPM.xX.X(:,4),[ones(20,1),mean(xY.y,2)])
xlabel('R-HPC - R-Caudate connectivity');
ylabel('Associative memory');
ylim([-.4 .6]);
title('famouse condition');


s2 = figure;
load(fullfile(dataPath1,'VOI_VOI-R-Occipital.mat'));
load(fullfile(dataPath1,'SPM.mat'));
plot(mean(xY.y,2),SPM.xX.X(:,4),'s');
a=lsline
[a b c d e]= regress(SPM.xX.X(:,4),[ones(20,1),mean(xY.y,2)])
xlabel('R-HPC - R-Occipital connectivity');
ylabel('Associative memory');
ylim([-.4 .6]);
title('famouse condition');






s4= figure;
load(fullfile(dataPath2,'VOI_VOI-L-TPL.mat'));
load(fullfile(dataPath2,'SPM.mat'));
plot(mean(xY.y,2),SPM.xX.X(:,4),'s');
a=lsline
[a b c d e]= regress(SPM.xX.X(:,4),[ones(20,1),mean(xY.y,2)])
xlabel('R-HPC - L-TPL connectivity');
ylabel('Associative memory');
ylim([-.4 .6]);
title('nonfamouse condition');

s4= figure;
load(fullfile(dataPath2,'VOI_VOI-R-BasalGanglia.mat'));
load(fullfile(dataPath2,'SPM.mat'));
plot(mean(xY.y,2),SPM.xX.X(:,4),'s');
a=lsline
[a b c d e]= regress(SPM.xX.X(:,4),[ones(20,1),mean(xY.y,2)])
xlabel('R-HPC - R-BasalGanglia connectivity');
ylabel('Associative memory');
ylim([-.4 .6]);
title('nonfamouse condition');


s4= figure;
load(fullfile(dataPath2,'VOI_VOI-R-Occipital.mat'));
load(fullfile(dataPath2,'SPM.mat'));
plot(mean(xY.y,2),SPM.xX.X(:,4),'s');
a=lsline
[a b c d e]= regress(SPM.xX.X(:,4),[ones(20,1),mean(xY.y,2)])
xlabel('R-HPC - R-Occiptial connectivity');
ylabel('Associative memory');
ylim([-.4 .6]);
title('nonfamouse condition');

s4= figure;
load(fullfile(dataPath2,'VOI_VOI-vmPFCmask.mat'));
load(fullfile(dataPath2,'SPM.mat'));
plot(mean(xY.y,2),SPM.xX.X(:,4),'s');
a=lsline
[a b c d e]= regress(SPM.xX.X(:,4),[ones(20,1),mean(xY.y,2)])
xlabel('R-HPC - L-vmpPFC connectivity');
ylabel('Associative memory');
ylim([-.4 .6]);
title('nonfamouse condition');
