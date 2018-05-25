function plotROI_PPI_PLS_matrix(contrastfam,contrastnfam)
figDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\encodingResubmissionFigures\';

load(['C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\matlabFunctions\',...
    'PPI_PLS_AllROIs-',contrastfam,'-',contrastnfam,'_nonrotate.mat']);
id=(mean(datamat_list{:})==1);
datamat_list{1}(:,id)=0;
dataf=datamat_list{1}(1:20,:);
datanf=datamat_list{1}(21:40,:); 
bootscore=reshape(resultRotatedall.boot_result.compare_u(:,1),[10,10]);
data1=bootscore;
data2=data1;
data2(abs(data2)<1.65)= 0;
plot2matrix(reshape(mean(dataf),10,10),reshape(mean(datanf),10,10),figDir,contrastfam,[contrastnfam,'-raw'],[-.5 .5])
plot2matrix(data1,data2,figDir,contrastfam,[contrastnfam,'-pls_diff'],[-2.5 2.5]);

% load(['C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\matlabFunctions\',...
%     'PPI_PLS_AllROIs-','fam1','-','nonfam1','_nonrotate.mat']);
% datamat_list1=datamat_list;
% load(['C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\matlabFunctions\',...
%     'PPI_PLS_AllROIs-','fam2','-','nonfam2','_nonrotate.mat']);
% datamat_list{1}=cat(1,datamat_list1{:},datamat_list{:});
% num_subj_lst = 20;
%     num_cond =4;
%     option.method = 2; %rotated
%     option.num_perm = 1000;
%     option.num_boot = 1000;
%     option.clim = 95;
%     option.meancentering_type = 0;
%     option.stacked_designdata = [1,-1 1,-1;1 1 -1 -1]';
%     addpath C:\Users\Zhongxu\Documents\MATLAB\myMatLabTools\majorNeuroImagingTools\plscmd
%     resultRotatedall = pls_analysis(datamat_list, num_subj_lst, num_cond,option);
%     bootscore=reshape(resultRotatedall.boot_result.compare_u(:,1),[10,10]);

    

function plot2matrix(data1,data2,figDir,contrastfam,contrastnfam,clim)
    s=figure;

    subplot(1,2,1)
    imagesc(data1);
    set(gca,'YTick',[1:10],'YTickLabel',{'LPPA','RPPA','LFFA','RFFA','LHPC','RHPC',...
        'LaTPL','RaTPL','LvmPFC','RvmPFC'});
    set(gca,'xTick',[1:10]) ;
    caxis(clim);
    subplot(1,2,2)
    
    imagesc(data2);
    set(gca,'XTick',[1:10]) ;    
%     set(gca,'YTick',[1:10],'YTickLabel',{'LPPA','RPPA','LFFA','RFFA','LHPC','RHPC',...
%         'LaTPL','RaTPL','LvmPFC','RvmPFC'})
set(gca,'YTick',[1:10]); 
    caxis(clim);
    set(gcf,'Color','w');
    setfigsize(s,8,'Arial',8,'Arial',12,5);
    plot2svg([figDir,'\','PPI_PLS_AllROIs-',contrastfam,'-',contrastnfam,'.svg'],s);
    