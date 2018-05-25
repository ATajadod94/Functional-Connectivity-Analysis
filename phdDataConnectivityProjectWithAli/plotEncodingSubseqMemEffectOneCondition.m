function plotEncodingSubseqMemEffectOneCondition(memdir,fgdir,figDir)
% respond to reviewer's comment (rejection reviews)

if ~exist(figDir,'dir') mkdir(figDir);end
famRDir = ['C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelSubsequentMemoryAnalysis_AllSubj\',memdir,'\'];

famFDir = ['C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelSubsequentMemoryAnalysis_AllSubj\',fgdir,'\'];

maskDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\masks\';
rois = { 'L_PPA.img', 'R_PPA.img',...
    'L_FFA.img', 'R_FFA.img','L_HPC.img', 'R_HPC.img', 'L_TPL.img', 'R_TPL.img',...
    'L_vmP.img', 'R_vmP.img'};
yfamRem = getMarsbarROIData(famRDir);
yfamfg = getMarsbarROIData(famFDir);
myFontSize = 8;


     FamLrem = yfamRem(:,1:2:10);
     FamRrem = yfamRem(:,2:2:10);
%     NFamLrem = ynfamRem(:,1:2:10);
%     NFamRrem =ynfamRem(:,2:2:10);
%
     FamLfg = yfamfg(:,1:2:10);
     FamRfg = yfamfg(:,2:2:10);
%     NFamLfg = ynfamfg(:,1:2:10);
%     NFamRfg =ynfamfg(:,2:2:10);

% fac1='famous'
% fac2='rememforgotten'
% fsize=8;lsize=8;
% 
% for i = 1:10
%     x1=[yfamRem(:,i),yfamfg(:,i)];
%     x2=[ynfamRem(:,i),ynfamfg(:,i)];
%     figureName=['subseqMemANOVA',rois{i}];
%     stats = anova2x2(x1,x2,fac1,fac2,figDir,fsize,lsize,figureName)
%     statsall{i}=stats;
% end
my_barvalues = [mean(FamLrem);mean(FamLfg)];

my_errors =  [std(FamLrem)/sqrt(size(FamLrem,1));std(FamLfg)/sqrt(size(FamLfg,1))];
plotBarFig(my_barvalues',my_errors',['SubsequentMemEffect_left-',memdir,'-',fgdir],myFontSize,'beta',figDir,[7,4]);

my_barvalues = [mean(FamRrem);mean(FamRfg)];

my_errors =  [std(FamRrem)/sqrt(size(FamRrem,1));std(FamRfg)/sqrt(size(FamRfg,1))];
plotBarFig(my_barvalues',my_errors',['SubsequentMemEffect_right-',memdir,'-',fgdir],myFontSize,'beta',figDir,[7,4]);


[hFL12,pFL12,ciFL12,statsFL12]=ttest(FamLrem,FamLfg);
[hFR12,pFR12,ciFR12,statsFR12]=ttest(FamRrem,FamRfg);


pfdr1=mafdr([pFL12,pFR12],'BHFDR',true);


dataTab(1,2:11) = num2cell([pFL12,pFR12]);
dataTab(2,2:11) = num2cell(pfdr1);
dataTab(3,2:11) = num2cell([statsFL12.tstat,statsFR12.tstat]);

dataTab(1:3,1)={'P','FDR','t'};
dataTab(4,2:11)={ 'L_PPA', 'L_FFA', 'L_HPC', 'L_TPL', 'L_vmP',...
    'R_PPA','R_FFA','R_HPC', 'R_TPL' 'R_vmP'};
  xlswrite([figDir,'\fameEffect-', memdir,'-',fgdir, '.xls'],dataTab);