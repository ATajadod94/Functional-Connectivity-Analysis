
%not working, p = .3 but patterns are similar to PPI results 
% roiIndx = [117 118 127:134] for 10 rois, no significant results
% for 90rois, pre compared to post yield signficant results. main
% contribution comging from fam - pre (medial temporal lobe stronger,
% fusiform, inferir occiipital and temporal regions
% connectivity with other regions, espcially supermarginal, pariental
% precuneous in post fam, weaking. superior occipital, cuneous, showed weaker in post than pre,no extra infomration added to rois analysis)
figDir = 'C:\Users\Zhongxu\Dropbox\picpair\PicparBehavioralmanuscript\postEncodingfMRIPub\figures\rawfigs\';

 roiIndx = [1:90] 
load('D:\myStudy\picpairfMRI\postEncodingRest\conn_restingConnectivity\results\firstlevel\ANALYSIS_01\resultsROI_Condition001.mat')  
zpre=Z(roiIndx,roiIndx,:);
load('D:\myStudy\picpairfMRI\postEncodingRest\conn_restingConnectivity\results\firstlevel\ANALYSIS_01\resultsROI_Condition002.mat')  
zfam=Z(roiIndx,roiIndx,:);
load('D:\myStudy\picpairfMRI\postEncodingRest\conn_restingConnectivity\results\firstlevel\ANALYSIS_01\resultsROI_Condition003.mat')  
znfam=Z(roiIndx,roiIndx,:);


lowTriagDataIndx = LowerTriangleIndex(length(roiIndx));
roiNames = names([roiIndx]); roiNames2=names2([roiIndx]);

%stack the low triagle matrix data into a row
for i = 1:20
temp1 = zpre(:,:,i);
zpreall(i,:)= temp1(lowTriagDataIndx)';   
    
temp2 = zfam(:,:,i);
zfamall(i,:)= temp2(lowTriagDataIndx)';

temp3 = znfam(:,:,i);
znfamall(i,:)= temp3(lowTriagDataIndx)';

end


%plot connectivity matrix

data{1} =mean(zfam1Stack,1);
data{2} =mean(zfam2Stack,1);
data{3} =mean(znfam1Stack,1);



x1=rand(20,1000);
x2=x1+2;
clear datamat_list;
datamat_list{1} = cat(1, zfamall,znfamall,zpreall);
% 
addpath C:\Users\Zhongxu\Documents\MATLAB\myMatLabTools\majorNeuroImagingTools\plscmd
% % specify other parameter for pls analysis
% 
% 
% %%%%% non-rotated PLS (predefined contrasts) %%%%%
num_subj_lst = 20;
num_cond = 3;
option.method = 1; %non-rotated
option.num_perm = 500;
option.num_boot = 500;
option.clim = 95;
%  option.meancentering_type=1;
%  option.stacked_designdata = [1 -1]'; % I have 3 contrasts
result = pls_analysis(datamat_list, num_subj_lst, num_cond,option);
bootscore=zeros(90,90);

 bootscore(lowTriagDataIndx)=result.boot_result.compare_u(:,1);
    s=figure;
caxis([-3 3]);
    subplot(1,2,1)
    imagesc(bootscore);
%     set(gca,'XTick',[1:10]);
%     set(gca,'YTick',[1:90]) ;
    %       ['PPA','FFA','HPC','aTPL','vmPFC','PPA','FFA','HPC','aTPL','vmPFC']);
    subplot(1,2,2)
    bootscore(abs(bootscore)<1.65)= 1;
    imagesc(bootscore);
%     set(gca,'XTick',[1:10]) ;
%     
%     set(gca,'YTick',[1:10]) ;
 caxis([-3 3]);
    set(gcf,'Color','w');
    setfigsize(s,8,'Arial',8,'Arial',12,5);
        plot2svg([figDir,'\','PPI_PLS_AllROIs-pre-famnfam.svg'],s);
