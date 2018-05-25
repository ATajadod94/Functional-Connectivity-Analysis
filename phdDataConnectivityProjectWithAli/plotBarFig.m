function plotBarFig(my_barvalues,my_errors,myFigTitle,myFontSize,myYLabel,figDir,figSize)
s=figure;

bw_legend={'fam','nfam'};
% x_label{1} = 'Famous';
% x_label{2} = 'NonFamous';
h=barweb(my_barvalues, my_errors, .9, 2, [], [], myYLabel, gray, [], bw_legend, 1, 'axis',0,8);
title(myFigTitle);
lim1 = min(min(my_barvalues))- max(max(my_errors));
if lim1>0 lim1=0;end
lim2 = max(max(my_barvalues))+max(max(my_errors));
 ylim([0 2]);
axis xy
box off 
set(gcf,'Color','w');

set(gca,'LineWidth',1);
% text(1,0.8,0,['p < ' num2str(P),',','t = ',num2str(STATS.tstat)]);
setfigsize(s,myFontSize,'Arial',myFontSize,'Arial',figSize(1),figSize(2));
%save figures
% figDir = pwd;
% figDir = strrep(figDir,'matlabFunctions','barFigsJofNResubmission\');
if ~exist(figDir,'dir')
    mkdir(figDir);
end
% export_fig([figDir,myFigTitle,myYLabel],'-tiff','-r300');
plot2svg([figDir,'\',myFigTitle,myYLabel,'.svg'],s);
