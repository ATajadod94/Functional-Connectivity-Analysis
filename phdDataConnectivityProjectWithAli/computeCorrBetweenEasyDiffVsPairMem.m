datadir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\matlabFunctions\';
load([datadir,'performanceData.mat']);
load([datadir,'encodingEasyDiffEvalMTotal.mat']);
load([datadir,'easyDiffiPicScrmbleIncludedSubj.mat']);

for i= 1:20
  pairMem(i)= performanceData{i}.pair.intactFam +performanceData{i}.pair.intactNFam ;
  pairMemavg(i)= performanceData{i}.pair.avgFam +performanceData{i}.pair.avgNFam ;
end

pairMem = pairMem(idIncluded);
easiness=sum(picsEvalMTotal(idIncluded,:),2);

[a b]=corr(pairMem',easiness)
scatter(pairMem',easiness)

pairMemavg = pairMemavg(idIncluded);
easiness=sum(picsEvalMTotal(idIncluded,:),2);

[a b]=corr(pairMemavg',easiness)
scatter(pairMemavg',easiness)