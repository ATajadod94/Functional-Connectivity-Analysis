function picpair2x2Anovafig(data1, data2,groupnames,bw_legend,bw_ylabel,catString,outpath,fsize,lsize)
s=figure;
setfigsize(s,8,'Helvetica',8,'Helvetica',6,4);

data(:,1,:)=reshape(data1,size(data1,1),1,size(data1,2));
data(:,2,:)=reshape(data2,size(data2,1),1,size(data2,2));

mdata=[];
mdata=nanmean(data,3);
erdata=[];
erdata(1,:)=nanstd(squeeze(data(1,:,:))')/sqrt(size(data,3));
erdata(2,:)=nanstd(squeeze(data(2,:,:))')/sqrt(size(data,3));

bw_xlabel=[' ']; 

shw_point=[.8, 1.2,1.8,2.2]; %plot data points on the bar graph, if empty, not plot.

picpairbartable(mdata', erdata',groupnames,bw_legend,bw_xlabel,bw_ylabel,shw_point,data,0,0,'NorthEast');
% ylim([-5 10]);

set(gcf, 'Color', 'w');
export_fig([outpath catString,'.pdf'],'-pdf');
end
