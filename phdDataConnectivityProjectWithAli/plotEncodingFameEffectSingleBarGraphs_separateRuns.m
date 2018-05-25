function plotEncodingFameEffectSingleBarGraphs_separateRuns

famDir1 = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelAnalysis\Fam1-NFam1\';

famDir2 = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelAnalysis\Fam2-NFam2\';
% nfamDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelAnalysis\NFam1+NFam2\';
figDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\encodingResubmissionFigures';
maskDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\masks\';
rois = { 'L_PPA.img', 'R_PPA.img',...
    'L_FFA.img', 'R_FFA.img','L_HPC.img', 'R_HPC.img', 'L_TPL.img', 'R_TPL.img',...
    'L_vmP.img', 'R_vmP.img'};
yfam1 = getRawY(famDir1);
yfam2 = getRawY(famDir2);
myFontSize = 8;


    FamL1 = yfam1(:,1:2:10);
    FamR1 = yfam1(:,2:2:10);
    FamL2 = yfam2(:,1:2:10);
    FamR2 = yfam2(:,2:2:10);
    
% comparing left and right
[hF1,pF1,ciF1,statsF1]=ttest(FamL1,FamR1);
[hF2,pF2,ciF2,statsF2]=ttest(FamL2,FamR2);

% comparing block 1 and 2
[hFL12,pFL12,ciFL12,statsFL12]=ttest(FamL1,FamL2);
[hFR12,pFR12,ciFR12,statsFR12]=ttest(FamR1,FamR2);

[hfnf1 pfnf1 c statsfnf1]=ttest([FamL1 FamR1],0);
pfdr1=mafdr(pfnf1,'BHFDR',true)

[hfnf2 pfnf2 c statsfnf2]=ttest([FamL2 FamR2],0);
pfdr2=mafdr(pfnf2,'BHFDR',true)
tvalue =[statsfnf1.tstat,statsfnf1.tstat]
dataTab(1,2:11) = num2cell(pfnf1);
dataTab(2,2:11) = num2cell(pfdr1);
dataTab(3,2:11) = num2cell(statsfnf1.tstat);
dataTab(4,2:11) = num2cell(pfnf2);
dataTab(5,2:11) = num2cell(pfdr2);
dataTab(6,2:11) = num2cell(statsfnf2.tstat);
dataTab(1:6,1)={'run1P','run1FDR','run1t','run2P','run2FDR','run2t'};
dataTab(7,2:11)={ 'L_PPA', 'L_FFA', 'L_HPC', 'L_TPL', 'L_vmP',...
    'R_PPA','R_FFA','R_HPC', 'R_TPL' 'R_vmP'};
  xlswrite([figDir,'\fameEffectRun1Run2Separated.xls'],dataTab);

plotSingleBlockBarsSeparately(yfam1, myFontSize, figDir,'run1');
plotSingleBlockBarsSeparately(yfam2, myFontSize, figDir,'run2');

function plotSingleBlockBarsSeparately(yfam, myFontSize, figDir,blocknum)

my_barvalues = [mean(yfam(:,1:2:10));mean(yfam(:,2:2:10))];

my_errors =  [std(yfam(:,1:2:10))/sqrt(20);std(yfam(:,2:2:10))/sqrt(20)];
plotBarFig(my_barvalues',my_errors',['fameEffectsinglebar-',blocknum,'-'],myFontSize,'beta',figDir,[6,3]);


function y = getRawY(famDir)
maskDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\masks\';
rois = { 'L_PPA.img', 'R_PPA.img',...
    'L_FFA.img', 'R_FFA.img','L_HPC.img', 'R_HPC.img', 'L_TPL.img', 'R_TPL.img',...
    'L_vmP.img', 'R_vmP.img'};
for i = 1:10
    marsbar('on');
    contr_model = mardo(fullfile(famDir, 'SPM.mat'));
    contr_model = cd_images(contr_model, 'D:\myStudy\picpairfMRI');
    save_spm(contr_model);
    roiFile = fullfile(maskDir,rois{i});
    o = maroi_image(struct('vol', spm_vol(roiFile)));
    R{i}=maroi(o);
    
    Y = get_marsy(R{i},contr_model,'mean');
    y(:,i)  = summary_data(Y);
end


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