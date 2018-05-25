function plotPPIRegressionScatterUsingvmPFCROIForResubmission

famDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelReg_PPI\R_HPC\pairMemoryFam\';
nfamDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelReg_PPI\L_HPC\pairMemoryNonFam\';
figDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\JofNeuroscienceResubFigs';
maskDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\masks\';
rois = {'L_vmP.img', 'R_vmP.img'};
yfam2 = getRawY(famDir,[maskDir, rois{2}]);
yfam1 = getRawY(famDir,[maskDir, rois{1}]);
ynfam1 = getRawY(nfamDir,[maskDir, rois{1}]);
ynfam2 = getRawY(nfamDir,[maskDir, rois{2}]);
myFontSize = 8;


load(fullfile(famDir,'SPM.mat'));
figure;
plot(SPM.xX.X(:,4),yfam,'sk','MarkerSize',1.8);
H1=lsline
[a b c d STATS]= regress(yfam,[ones(20,1),SPM.xX.X(:,4)]);
 [B,DEV,STATS] = glmfit(SPM.xX.X(:,2:4),yfam)
 
  [B,DEV,STATS] = glmfit([SPM.xX.X(:,2:3),yfam],SPM.xX.X(:,4))
rsq=['R^2 = ',num2str(roundoff(STATS(1),2))];
if STATS(3)<.001;STATS(3)=.001;end
pv=['p < ',num2str(roundoff(STATS(3),4))];
Hl1 =text(0,0,rsq,'fontsize',fsize);
Hl2= text(0,0,pv,'fontsize',fsize);

load(fullfile(nfamDir,'SPM.mat'));


function y = getRawY(famDir,rois)

    contr_model = mardo(fullfile(famDir, 'SPM.mat'));
    contr_model = cd_images(contr_model, 'D:\myStudy\picpairfMRI');
    save_spm(contr_model);
    roiFile = rois;
    o = maroi_image(struct('vol', spm_vol(roiFile)));
    R=maroi(o);
    
    Y = get_marsy(R,contr_model,'mean');
    y  = summary_data(Y);



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