function [yfam, fh] = plotEasyDiffPicVsScrambleBarGraphsFHOnlyFamNfamSeparate(condName,dataDir, isplot)
if nargin<2
    isplot=1;
end
famDir = ['C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelPmodAnalysis\',condName,'\',dataDir,'\'];
figDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\easyDiffFigures';
maskDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\masks\';
rois = { 'L_HPC.img', 'R_HPC.img','L_PPA.img', 'R_PPA.img','L_FFA.img', 'R_FFA.img'};
% rois = { 'L_vmP.img', 'R_vmP.img'};
addpath C:\Users\Zhongxu\Documents\MATLAB\myMatLabTools\majorNeuroImagingTools\marsbar-0.43

yfam = getRawY(famDir);


[yfam,xRm,idRm,idRmi]=replaceOutliers(yfam,2.5,2);


[a fh.p fh.ic fh.stats]=ttest(yfam,0);

fh.m=mean(yfam);



myFontSize = 8;

% for i = 1:2:length(rois)
%     FamL = yfam(:,i);
%     FamR = yfam(:,i+1);
%     NFamL = ynfam(:,i);
%     NFamR =ynfam(:,i+1);
%     
%     my_barvalues = [mean(FamL),mean(FamR);mean(NFamL),mean(NFamR)];
%     my_errors =  [std(FamL)/sqrt(16),std(FamR)/sqrt(16);std(NFamL)/sqrt(16),std(NFamR)/sqrt(16)];
%     if isplot==1
%         plotBarFig(my_barvalues',my_errors',rois{i},myFontSize,'beta',figDir,[4,4]);
%         plotNotBoxPlot([FamL, NFamL, FamR, NFamR],figDir,['easydiffEncoding-',rois{i},rois{i+1}],2)
%     end
% end
my_barvalues = [mean(yfam(:,1:2:length(rois)));mean(yfam(:,2:2:length(rois)))];

my_errors =  [std(yfam(:,1:2:length(rois)))/sqrt(16);std(yfam(:,2:2:length(rois)))/sqrt(16)];
if isplot==1
    plotBarFig(my_barvalues',my_errors',[dataDir,condName],myFontSize,'beta',figDir,[8,5]);
%     plotNotBoxPlot(yfam,[dataDir,figDir],condName,2);
end



function y = getRawY(famDir)
maskDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\masks\';
% rois = { 'L_PPA.img', 'R_PPA.img',...
%     'L_FFA.img', 'R_FFA.img','L_HPC.img', 'R_HPC.img',...
%     'L_vmP.img', 'R_vmP.img'};

rois = { 'L_HPC.img', 'R_HPC.img','L_PPA.img', 'R_PPA.img','L_FFA.img', 'R_FFA.img'};
% rois = { 'L_vmP.img', 'R_vmP.img'};
for i = 1:length(rois)
    marsbar('on');
    contr_model = mardo(fullfile(famDir, 'SPM.mat'));
    %     contr_model = cd_images(contr_model, 'D:\myStudy\picpairfMRI');
    save_spm(contr_model);
    roiFile = fullfile(maskDir,rois{i});
    o = maroi_image(struct('vol', spm_vol(roiFile)));
    R{i}=maroi(o);
    
    Y = get_marsy(R{i},contr_model,'mean');
    y(:,i)  = summary_data(Y);
end

function plotNotBoxPlot(data,outDir,figureName,plotDataPoints)
if nargin < 4
    plotDatapoints ==1;
end
s = figure;
% errorbar(mean([FH_Easy,FH_Diffi]),...
%     std([FH_Easy,FH_Diffi],1),'color','K','linestyle','none');
% hold on;
h=bar(mean(data,1));
hold on;
if plotDataPoints ==1
    notBoxPlot(data,[],0,'line');
else
    notBoxPlotNoDataPoint(data,[],0,'line');
end

set(h,'facecolor','k');
ylabel('beta');
% ylim([-1 2]);
set(gcf,'Color','w');
axis xy
box off
% set(gca,'Xtick',1:2,'XTickLabel',{'FH-EASY', 'FH-DIFF'});
setfigsize(s,8,'Arial',8,'Arial',10,7.5);
plot2svg([outDir,figureName,'.svg'],s);


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
%     for j = 1:length(rois)
%         yfam(i,j)=rex(fdata,[maskDir,rois{j}]);
%         ynfam(i,j)=rex(nfdata,[maskDir,rois{j}]);
%     end
% end