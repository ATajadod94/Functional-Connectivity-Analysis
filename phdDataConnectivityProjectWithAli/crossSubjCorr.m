function crossSubjCorr
%this is to calculate how associative memory fame effect with brain fame effects 
rootDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\';
load([rootDir,'matlabFunctions\performanceDataConcatenated.mat']);
maskDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelPmodAnalysisNew\masksForBrainBahavior\';
maskFiles = dir([maskDir,'*.img']);
faceFam_NFam = faceMem.totalFam - faceMem.totalNFam;
houseFam_NFam = houseMem.totalFam - houseMem.totalNFam;
pairFam_NFam = pairMem.avgFam - pairMem.avgNFam;
contrastNum=2; % fame effect contrast from first level univariate analysis
memData = pairFam_NFam;
memNameStr = 'pairMemory';
outputPath = 'secondLevelReg\singleReg\pairFameEffect';
subjDir=dir([rootDir,'s0*.*']);
for n = 1:length(subjDir)
    imgF(n,:)= [rootDir,subjDir(n).name,'\encoding\analysis\con_',sprintf('%04d',contrastNum),'.img'];
    % Factorial design specification: Scans - cfg_files
end
[subjInfo a]=xlsread([rootDir,'matlabFunctions\picpairSubjInfo.xlsx']);
fameOrder = zeros(size(subjInfo,1),1);
fameOrder(1:2:end,1) = 1;
age = subjInfo(:,2);
gender  = subjInfo(:,3);
% [a b pairFam_NFam]=regress(pairFam_NFam,[ones(size(subjInfo,1),1),...
%     fameOrder]);

for i = 1:size(maskFiles,1)
coVariables = [fameOrder,age,gender];%,faceFam_NFam, houseFam_NFam
maskNames = [maskDir,maskFiles(i).name];
[r p]=fameEffectCorr(imgF, maskNames,rootDir,coVariables,pairFam_NFam,maskNames)
end

% maskFiles = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelReg\singleReg\pairFameEffect\L_IFG.img';
% fameEffectCorr(imgF, maskFiles,rootDir,coVariables,pairFam_NFam,'L-IFG');
% 
% maskFiles = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelReg\singleReg\pairFameEffect\R_PAL.img';
% fameEffectCorr(imgF, maskFiles,rootDir,coVariables,pairFam_NFam,'R-PAL');
% 
% maskFiles = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelReg\singleReg\pairFameEffect\R_VMP.img';
% fameEffectCorr(imgF, maskFiles,rootDir,coVariables,pairFam_NFam,'R-VMP');

% using predefined large area masks gives no signficant correlations, some
% even seem negative


function [r,p]=fameEffectCorr(imgF, maskFiles,rootDir,coVariables,pairFam_NFam,maskName)
R_MTG = rex(imgF, maskFiles,'select_clusters',0);
if ~isempty(coVariables)
[B,BINT,R_MTG] = regress(R_MTG,[ones(size(coVariables,1),1),coVariables]);
end
[r p]=corr(R_MTG,pairFam_NFam);
figure;
scatter(R_MTG,pairFam_NFam);
plot(R_MTG,pairFam_NFam,'*');
xlim([-2 4]);
ylim([-.2 .8]);
lsline
xlabel('Bold Beta contrast: Fame effect');
ylabel('Associative Memory fame effect');
title(['Brain region: ',maskName]);
