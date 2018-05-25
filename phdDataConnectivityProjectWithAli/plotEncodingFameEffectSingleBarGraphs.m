function plotEncodingFameEffectSingleBarGraphs

famDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelAnalysis\famEffect_Fam-NonFam\';
% nfamDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelAnalysis\NFam1+NFam2\';
figDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\JofNeuroscienceResubFigs';
maskDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\masks\';
rois = { 'L_PPA.img', 'R_PPA.img',...
    'L_FFA.img', 'R_FFA.img','L_HPC.img', 'R_HPC.img', 'L_TPL.img', 'R_TPL.img',...
    'L_vmP.img', 'R_vmP.img'};
yfam = getRawY(famDir);
% ynfam = getRawY(nfamDir);
myFontSize = 8;

   FamL = yfam(:,1:2:10);
    FamR = yfam(:,2:2:10);
    
    [a b c d]=ttest(FamL, FamR)
    data = .5*(FamL + FamR);
    [a b c d]=ttest(data,0)

% for i = 1:2:10
%     FamL = yfam(:,i);
%     FamR = yfam(:,i+1);
% %     NFamL = ynfam(:,i);
% %     NFamR =ynfam(:,i+1);
%     
%     my_barvalues = [mean(FamL),mean(FamR)];
%     my_errors =  [std(FamL)/sqrt(20),std(FamR)/sqrt(20)];
%     plotBarFig(my_barvalues',my_errors',[rois{i},'_fameEffectsinglebar'],myFontSize,'beta',figDir,[4,4]);
%     
% end
my_barvalues = [mean(yfam(:,1:2:10));mean(yfam(:,2:2:10))];

my_errors =  [std(yfam(:,1:2:10))/sqrt(20);std(yfam(:,2:2:10))/sqrt(20)];
plotBarFig(my_barvalues',my_errors','fameEffectsinglebar',myFontSize,'beta',figDir,[6,3]);


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