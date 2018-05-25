function statsall = plotEncodingSubseqMemEffectSepRemNonRem(remFam,remNonFam,nonremFam,nonremNonFam,figDir)
% respond to reviewer's comment (rejection reviews)

if ~exist(figDir,'dir') mkdir(figDir);end
famRDir = ['C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelSubsequentMemoryAnalysis_AllSubj\',remFam,'\'];
nfamRDir = ['C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelSubsequentMemoryAnalysis_AllSubj\',remNonFam,'\'];

famFDir = ['C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelSubsequentMemoryAnalysis_AllSubj\',nonremFam,'\'];
nfamFDir = ['C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelSubsequentMemoryAnalysis_AllSubj\',nonremNonFam,'\'];

maskDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\masks\';
rois = { 'L_PPA.img', 'R_PPA.img',...
    'L_FFA.img', 'R_FFA.img','L_HPC.img', 'R_HPC.img', 'L_TPL.img', 'R_TPL.img',...
    'L_vmP.img', 'R_vmP.img'};
yfamRem = getMarsbarROIData(famRDir);
ynfamRem = getMarsbarROIData(nfamRDir);
yfamfg = getMarsbarROIData(famFDir);
ynfamfg = getMarsbarROIData(nfamFDir);
myFontSize = 8;


%     FamLrem = yfamRem(:,1:2:10);
%     FamRrem = yfamRem(:,2:2:10);
%     NFamLrem = ynfamRem(:,1:2:10);
%     NFamRrem =ynfamRem(:,2:2:10);
%
%     FamLfg = yfamfg(:,1:2:10);
%     FamRfg = yfamfg(:,2:2:10);
%     NFamLfg = ynfamfg(:,1:2:10);
%     NFamRfg =ynfamfg(:,2:2:10);

fac1='famous'
fac2='rememforgotten'
fsize=8;lsize=8;

for i = 1:10
    x1=[yfamRem(:,i),yfamfg(:,i)];
    x2=[ynfamRem(:,i),ynfamfg(:,i)];
    figureName=['subseqMemANOVA',rois{i}];
    stats = anova2x2(x1,x2,fac1,fac2,figDir,fsize,lsize,figureName)
    statsall{i}=stats;
end
save([figDir,'subseqMemANOVAReults.mat'],'statsall');
