pathf = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\picPairFigures\';
dataPathFL= 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelReg_PPI\L_HPC\pairMemoryFam';
dataPathNFL = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelReg_PPI\L_HPC\pairMemoryNonFam';


dataPathFR= 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelReg_PPI\R_HPC\pairMemoryFam';
dataPathNFR = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelReg_PPI\R_HPC\pairMemoryNonFam';
dataPath(1:4)= {dataPathFL,dataPathNFL,dataPathFR,dataPathNFR};
lsize=7.5;
fsize = 7.5;
voiFname = {'VOI_VOI-L-BGmask.mat',...
    'VOI_VOI-L-TPLmask.mat',...
    'VOI_VOI-L-vmPFCmask.mat',...
    'VOI_VOI-R-BGmask.mat',...
    'VOI_VOI-R-TPLmask.mat',...
    'VOI_VOI-R-vmPFCmask.mat'};
voiName = {'BG','TPL','vmPFC'};
% HPCName = {'L-HPC','R-HPC'};
% fame = {'Famous','Nonfamous'};
for i = 1:4
if i ==1 || i ==2
    HPCName = 'L-HPC';
elseif i ==3 || i ==4
    HPCName = 'R-HPC';
    
end

if i ==1 || i ==3
    fame = 'Famous condition';
elseif i ==2 || i ==4
    fame = 'Nonfamous condition';    
end


for j = 1:3
    

s = figure;

load(fullfile(dataPathFR,voiFname{j}));
load(fullfile(dataPath{i},'SPM.mat'));
plot(mean(xY.y,2),SPM.xX.X(:,4),'sb','MarkerSize',1.8);
H1=lsline
[a b c d STATS]= regress(SPM.xX.X(:,4),[ones(20,1),mean(xY.y,2)]);
rsq=['R^2 = ',num2str(Roundoff(STATS(1),2))];
if STATS(3)<.001;STATS(3)=.001;end
pv=['p < ',num2str(Roundoff(STATS(3),4))];
Hl1 =text(0,0,rsq,'fontsize',fsize);
Hl2= text(0,0,pv,'fontsize',fsize);

set(Hl1,'Color','b')
set(Hl2,'Color','b')
hold on
clear xY
load(fullfile(dataPath{i},voiFname{j+3}));
plot(mean(xY.y,2),SPM.xX.X(:,4),'or',  'MarkerSize',1.8);
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
 
 xlabel([HPCName,' - ',voiName{j},' connectivity'],'fontsize',lsize)
%   xlim([7 19]);
%   ylim([-9 8]);
ylabel('Associative memory','fontsize',lsize);
rsq=['R^2 = ',num2str(Roundoff(STATS(1),2))];
if STATS(3)<.001;STATS(3)=.001;end
pv=['p < ',num2str(Roundoff(STATS(3),4))];
Hr1 =text(0,0,rsq,'fontsize',fsize);
Hr2= text(0,0,pv,'fontsize',fsize);
set(Hr1,'Color','r')
set(Hr2,'Color','r')
title(fame,'fontsize',fsize);
set(gca,'fontsize',fsize);
setfigsize(s,8,'Helvetica',8,'Helvetica',5,4);

plot2svg([pathf,'PPIRegMem-', fame,'-',HPCName,'-',voiName{j},'.svg'],s);
end
end

%****************
s = figure;

load(fullfile(dataPathFR,'VOI_VOI-R-vmPFC.mat'));
load(fullfile(dataPathFR,'SPM.mat'));
plot(mean(xY.y,2),SPM.xX.X(:,4),'or','MarkerSize',1.8);
H1=lsline
[a b c d STATS]= regress(SPM.xX.X(:,4),[ones(20,1),mean(xY.y,2)]);
rsq=['R^2 = ',num2str(Roundoff(STATS(1),2))];
if STATS(3)<.001;STATS(3)=.001;end
pv=['p < ',num2str(Roundoff(STATS(3),4))];
Hl1 =text(0,0,rsq,'fontsize',fsize);
Hl2= text(0,0,pv,'fontsize',fsize);

set(Hl1,'Color','r')
set(Hl2,'Color','r')

clear xY
 xlabel(['R-HPC - R-vmPFC connectivity'],'fontsize',lsize)
%   xlim([7 19]);
%   ylim([-9 8]);
ylabel('Associative memory','fontsize',lsize);

title('Famous condition','fontsize',fsize);
set(gca,'fontsize',fsize);
setfigsize(s,8,'Helvetica',8,'Helvetica',5,4);

plot2svg([pathf,'PPIRegMem-','Fam','-','R-HPC','-','R-vmPFC','.svg'],s);




%nonfamous, LHPC vs. Lvmpfc
s = figure;

load(fullfile(dataPathNFL,'VOI_VOI-L-vmPFC.mat'));
load(fullfile(dataPathNFL,'SPM.mat'));
plot(mean(xY.y,2),SPM.xX.X(:,4),'sb','MarkerSize',1.8);
H1=lsline
[a b c d STATS]= regress(SPM.xX.X(:,4),[ones(20,1),mean(xY.y,2)]);
rsq=['R^2 = ',num2str(Roundoff(STATS(1),2))];
if STATS(3)<.001;STATS(3)=.001;end
pv=['p < ',num2str(Roundoff(STATS(3),4))];
Hl1 =text(0,0,rsq,'fontsize',fsize);
Hl2= text(0,0,pv,'fontsize',fsize);

set(Hl1,'Color','b')
set(Hl2,'Color','b')

clear xY
 xlabel(['L-HPC - L-vmPFC connectivity'],'fontsize',lsize)
%   xlim([7 19]);
%   ylim([-9 8]);
ylabel('Associative memory','fontsize',lsize);

title('Nonfamous condition','fontsize',fsize);
set(gca,'fontsize',fsize);
setfigsize(s,8,'Helvetica',8,'Helvetica',5,4);

plot2svg([pathf,'PPIRegMem-','NonFam','-','L-HPC','-','L-vmPFC','.svg'],s);


%nonfamous, RHPC vs. Rvmpfc
s = figure;

load(fullfile(dataPathNFR,'VOI_VOI-R-vmPFC.mat'));
load(fullfile(dataPathNFR,'SPM.mat'));
plot(mean(xY.y,2),SPM.xX.X(:,4),'or','MarkerSize',1.8);
H1=lsline
[a b c d STATS]= regress(SPM.xX.X(:,4),[ones(20,1),mean(xY.y,2)]);
rsq=['R^2 = ',num2str(Roundoff(STATS(1),2))];
if STATS(3)<.001;STATS(3)=.001;end
pv=['p < ',num2str(Roundoff(STATS(3),4))];
Hl1 =text(0,0,rsq,'fontsize',fsize);
Hl2= text(0,0,pv,'fontsize',fsize);

set(Hl1,'Color','r')
set(Hl2,'Color','r')

clear xY
 xlabel(['R-HPC - R-vmPFC connectivity'],'fontsize',lsize)
%   xlim([7 19]);
%   ylim([-9 8]);
ylabel('Associative memory','fontsize',lsize);

title('Nonfamous condition','fontsize',fsize);
set(gca,'fontsize',fsize);
setfigsize(s,8,'Helvetica',8,'Helvetica',5,4);

plot2svg([pathf,'PPIRegMem-','NonFam','-','R-HPC','-','R-vmPFC','.svg'],s);