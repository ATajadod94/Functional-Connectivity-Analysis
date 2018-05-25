function statsall = plotEncodingfamNfamRun12Anova
% respond to reviewer's comment (rejection reviews)

figDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\encodingResubmissionFigures\';

dataDir='C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelAnalysis\';
fam1Dir = [dataDir,'Fam1\'];
nfam1Dir =[dataDir,'NonFam1\'];
fam2Dir = [dataDir,'Fam2\'];
nfam2Dir =[dataDir,'NonFam2\'];
maskDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\masks\';
rois = { 'L_PPA.img', 'R_PPA.img',...
    'L_FFA.img', 'R_FFA.img','L_HPC.img', 'R_HPC.img', 'L_TPL.img', 'R_TPL.img',...
    'L_vmP.img', 'R_vmP.img'};
yfam1 = getMarsbarROIData(fam1Dir);
ynfam1 = getMarsbarROIData(nfam1Dir);
yfam2 = getMarsbarROIData(fam2Dir);
ynfam2 = getMarsbarROIData(nfam2Dir);
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
fac2='blocks'
fsize=8;lsize=8;

for i = 1:10
    x1=[yfam1(:,i),yfam2(:,i)];
    x2=[ynfam1(:,i),ynfam2(:,i)];
    figureName=['EncodingFamByRunANOVA',rois{i}];
    stats = anova2x2(x1,x2,fac1,fac2,figDir,fsize,lsize,figureName)
    statsall{i}=stats;
%     ylim([ylimvalue(i,1),ylimvalue(i,2)]);
end
save([figDir,'EncodingFamByRunANOVAReults.mat'],'statsall');
