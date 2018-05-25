pathf = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\picPairFigures\';
dataPathFL= 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelReg_PPI\L_HPC\pairMemoryFam';
dataPathNFL = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelReg_PPI\L_HPC\pairMemoryNonFam';


dataPathFR= 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelReg_PPI\R_HPC\pairMemoryFam';
dataPathNFR = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelReg_PPI\R_HPC\pairMemoryNonFam';
dataPath(1:4)= {dataPathFL,dataPathNFL,dataPathFR,dataPathNFR};
lsize=7.5;
fsize = 7.5;

% voiFname = {'VOI_VOI-L-BGmask.mat',...
%     'VOI_VOI-L-TPLmask.mat',...
%     'VOI_VOI-L-vmPFCmask.mat',...
%     'VOI_VOI-R-BGmask.mat',...
%     'VOI_VOI-R-TPLmask.mat',...
%     'VOI_VOI-R-vmPFCmask.mat'}; % these roi files were extracted at p =
%     .05 using masks


%these roi fies extracted at p = .005 using 6mm sphere
voiFname = {'VOI_rcaudate20166.mat',...
    'VOI_VOI-L-TPLmask.mat',...
    'VOI_rvmpfc818-12.mat',...
    'VOI_rcaudate24-1822.mat',...
    'VOI_VOI-R-TPLmask.mat',...
    'VOI_lvmpfc-612-14.mat',...
    'VOI_VOI-lvmpf-416-16'};
voiName = {'BG','TPL','vmPFC'};
% HPCName = {'L-HPC','R-HPC'};
% fame = {'Famous','Nonfamous'};
i = 3
HPCName = 'R-HPC';
fame = 'Famous condition';
s = figure;

% load(fullfile(dataPath{3},voiFname{6}));
load(fullfile(dataPath{3},'SPM.mat'));
% plot(mean(xY.y,2),SPM.xX.X(:,4),'sb','MarkerSize',1.8);
% H1=lsline
% [a b c d STATS]= regress(SPM.xX.X(:,4),[ones(20,1),mean(xY.y,2)]);
% rsq=['R^2 = ',num2str(roundoff(STATS(1),2))];
% if STATS(3)<.001;STATS(3)=.001;end
% pv=['p < ',num2str(roundoff(STATS(3),4))];
% Hl1 =text(0,0,rsq,'fontsize',fsize);
% Hl2= text(0,0,pv,'fontsize',fsize);
%
% set(Hl1,'Color','b')
% set(Hl2,'Color','b')
% hold on
% clear xY
load(fullfile(dataPath{3},voiFname{3}));
scatter(mean(xY.y,2),SPM.xX.X(:,4),5,'k','filled');
H2=lsline
[a b c d STATS]= regress(SPM.xX.X(:,4),[ones(20,1),mean(xY.y,2)])
clear xY
% xlabel('R-HPC - R-vmPFC connectivity');
% ylabel('Associative memory');
% ylim([-.4 .6]);
% title('famouse condition');
% H1=lsline;
% set(H1,'LineWidth',1.5);
% set(H1,'Color','b');

xlabel([HPCName,' - ',voiName{3},' connectivity'],'fontsize',lsize)
xlim([-1.2 1.2]);
ylim([-.4 .8]);
ylabel('Associative memory','fontsize',lsize);
rsq=['R^2 = ',num2str(roundoff(STATS(1),2))];
if STATS(3)<.001;STATS(3)=.001;end
pv=['p < ',num2str(roundoff(STATS(3),4))];
Hr1 =text(0,0,rsq,'fontsize',fsize);
Hr2= text(0,0,pv,'fontsize',fsize);
set(Hr1,'Color','r')
set(Hr2,'Color','r')
title(fame,'fontsize',fsize);
set(gca,'fontsize',fsize);
setfigsize(s,8,'Helvetica',8,'Helvetica',4,3.5);

plot2svg([pathf,'PPIRegMem-', fame,'-',HPCName,'-',voiName{3},'-sphere-jofnresub.svg'],s);

fame = 'Nonfamous condition';
HPCName = 'L-HPC';

s = figure;

load(fullfile(dataPath{2},voiFname{7}));
load(fullfile(dataPath{2},'SPM.mat'));
scatter(mean(xY.y,2),SPM.xX.X(:,4),5,'k');
H1=lsline
[a b c d STATS]= regress(SPM.xX.X(:,4),[ones(20,1),mean(xY.y,2)]);
rsq=['R^2 = ',num2str(roundoff(STATS(1),2))];
if STATS(3)<.001;STATS(3)=.001;end
pv=['p < ',num2str(roundoff(STATS(3),4))];
Hl1 =text(0,0,rsq,'fontsize',fsize);
Hl2= text(0,0,pv,'fontsize',fsize);

set(Hl1,'Color','b')
set(Hl2,'Color','b')
hold on
clear xY
% load(fullfile(dataPath{4},voiFname{6}));
% plot(mean(xY.y,2),SPM.xX.X(:,4),'or',  'MarkerSize',2);
% H2=lsline
% [a b c d STATS]= regress(SPM.xX.X(:,4),[ones(20,1),mean(xY.y,2)])
% clear xY
% % xlabel('R-HPC - R-vmPFC connectivity');
% % ylabel('Associative memory');
% % ylim([-.4 .6]);
% % title('famouse condition');
% % H1=lsline;
% % set(H1,'LineWidth',1.5);
% set(H1,'Color','b');

xlabel([HPCName,' - ',voiName{3},' connectivity'],'fontsize',lsize)
xlim([-1.5 1.5]);
ylim([-.4 .5]);
ylabel('Associative memory','fontsize',lsize);
rsq=['R^2 = ',num2str(roundoff(STATS(1),2))];
if STATS(3)<.001;STATS(3)=.001;end
pv=['p < ',num2str(roundoff(STATS(3),4))];
Hr1 =text(0,0,rsq,'fontsize',fsize);
Hr2= text(0,0,pv,'fontsize',fsize);
set(Hr1,'Color','r')
set(Hr2,'Color','r')
title(fame,'fontsize',fsize);
set(gca,'fontsize',fsize);
setfigsize(s,8,'Helvetica',8,'Helvetica',4,3.5);

plot2svg([pathf,'PPIRegMem-', fame,'-',HPCName,'-',voiName{1},'-sphere-jofnresub.svg'],s);

