function plotEncodingFameEffectBarGraphs_separateRuns



fam1Dir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelAnalysis\Fam1\';
fam2Dir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelAnalysis\Fam2\';

nfam1Dir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelAnalysis\NonFam1\';
nfam2Dir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelAnalysis\NonFam2\';

figDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\encodingResubmissionFigures';
maskDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\masks\';
rois = { 'L_PPA.img', 'R_PPA.img',...
    'L_FFA.img', 'R_FFA.img','L_HPC.img', 'R_HPC.img', 'L_TPL.img', 'R_TPL.img',...
    'L_vmP.img', 'R_vmP.img'};
yfam1 = getMarsbarROIData(fam1Dir);
yfam2 = getMarsbarROIData(fam2Dir);
ynfam1 = getMarsbarROIData(nfam1Dir);
ynfam2 = getMarsbarROIData(nfam2Dir);
myFontSize = 8;



    FamL1 = yfam1(:,1:2:10);
    FamR1 = yfam1(:,2:2:10);
    NFamL1 = ynfam1(:,1:2:10);
    NFamR1 =ynfam1(:,2:2:10);
    
    FamL2 = yfam2(:,1:2:10);
    FamR2 = yfam2(:,2:2:10);
    NFamL2 = ynfam2(:,1:2:10);
    NFamR2 =ynfam2(:,2:2:10);
    
% comparing left and right
[hF1,pF1,ciF1,statsF1]=ttest(FamL1,FamR1);
[hF2,pF2,ciF2,statsF2]=ttest(FamL2,FamR2);
[hNF1,pNF1,ciNF1,statsNF1]=ttest(NFamL1,NFamR1);
[hNF2,pNF2,ciNF2,statsNF2]=ttest(NFamL2,NFamR2);

% comparing block 1 and 2
[hFL12,pFL12,ciFL12,statsFL12]=ttest(FamL1,FamL2);
[hFR12,pFR12,ciFR12,statsFR12]=ttest(FamR1,FamR2);
[hNFL12,pNFL12,ciNFL12,statsNFL12]=ttest(NFamL1,NFamL2);
[hNFR12,pNFR12,ciNFR12,statsNFR12]=ttest(NFamR1,NFamR2);



function plotSingleBlockLeftRightBarsSeparately(FamL, FamR, NFamL, NFamR, rois, myFontSize, figDir)

my_barvalues = [mean(yfam(:,1:2:10));mean(ynfam(:,1:2:10))];

my_errors =  [std(yfam(:,1:2:10))/sqrt(20);std(ynfam(:,1:2:10))/sqrt(20)];
plotBarFig(my_barvalues',my_errors','left_fameEffect',myFontSize,'beta',figDir,[6,3]);

my_barvalues = [mean(yfam(:,2:2:10));mean(ynfam(:,2:2:10))];

my_errors =  [std(yfam(:,2:2:10))/sqrt(20);std(ynfam(:,2:2:10))/sqrt(20)];
plotBarFig(my_barvalues',my_errors','right_fameEffect',myFontSize,'beta',figDir,[6,3]);




% it is weird, only for tpl and vmpfc, the rex produced different results
% than marshbar
% maskDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\masks\';
% rois = {'L_HPC.img', 'R_HPC.img', 'L_PPA.img', 'R_PPA.img',...
%     'L_FFA.img', 'R_FFA.img', 'L_TPL.img', 'R_TPL.img',...
%     'L_vmP.img', 'R_vmP.img'}
% for i = 1:20
%     %fam
%     fdata= ['D:\myStudy\picpairfMRI\s',sprintf('%03d',i),'\encoding\analysis-performancePmod-0\con_0003.img'];
%     nfdata= ['D:\myStudy\picpairfMRI\s',sprintf('%03d',i),'\encoding\analysis-performancePmod-0\con_0007.img'];
%
%     for j = 1:10
%         yfam(i,j)=rex(fdata,[maskDir,rois{j}]);
%         ynfam(i,j)=rex(nfdata,[maskDir,rois{j}]);
%     end
% end