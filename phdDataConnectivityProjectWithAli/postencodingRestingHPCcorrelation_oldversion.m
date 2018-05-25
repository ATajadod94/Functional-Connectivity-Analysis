function postencodingRestingHPCcorrelation

addpath('C:\Users\Zhongxu\Documents\MATLAB\myMatLabTools\Corr_toolbox_v2');
addpath('C:\Users\Zhongxu\Documents\MATLAB\myMatLabTools\Corr_toolbox_v2\LIBRA');
% plot lffa vs rHPC correlation in postfam nonfam rest
outpath = 'C:\Users\Zhongxu\Dropbox\picpair\PicparBehavioralmanuscript\postEncodingfMRIPub\figures\';
load(['C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\matlabFunctions\',...
    'performanceDataConcatenated.mat']);

%**************************************************************************
%*************************post encoding correlations***********************
%**************************************************************************
%famous condition
brainCorr.name1 = 'L_FFA';
brainCorr.name2 = 'R_HPC';
[preCorr famCorr nonfamCorr] = getBrainCorrData(brainCorr.name1,brainCorr.name2);

brainCorr.data = famCorr;
brainCorr.fameFlag = 'Fam';
% plot scatter plot bwt brain correlation and associative memory
% performance
plotBrainCorrWithAssociativeMem(brainCorr,pairMem.intactFam);


%nonfamous condition
brainCorr.name1 = 'L_FFA';
brainCorr.name2 = 'R_HPC';
[preCorr famCorr nonfamCorr] = getBrainCorrData(brainCorr.name1,brainCorr.name2);

brainCorr.data = nonfamCorr;
brainCorr.fameFlag = 'NFam';
% plot scatter plot bwt brain correlation and associative memory
% performance
plotBrainCorrWithAssociativeMem(brainCorr,pairMem.intactNFam);

% plot bar graph for brain correlations in the two fame condition
s = figure; 
fsize=8;
ss = bar(mean([famCorr,nonfamCorr],1),'k');
hold on;
errorbar(mean([famCorr,nonfamCorr],1),std([famCorr,nonfamCorr],1)/sqrt(19),'k');
hold on;
%     scatter(1.1*ones(20,1),famCorr, 20, randColor);
%         scatter(1.9*ones(20,1),nonfamCorr, 20, randColor);
     scatter(1.1*ones(20,1),famCorr, 20,'k');
         scatter(1.9*ones(20,1),nonfamCorr,20,'k'); 
    hold on;
for i = 1:20
    randColor(i,:) = rand(1,3);
    plot([1.1,1.9],[famCorr(i),nonfamCorr(i)],'Color',randColor(i,:));

    hold on;
end

   
ylabel('L-FFA - R-HPC'); 
set(gca,'fontsize',fsize);
box off;
set(gcf, 'Color', 'w');
setfigsize(s,8,'Helvetica',8,'Helvetica',6,5);
set(gca,'YLim',[-.16 .81]);
set(gca, 'XTickLabel', {'Post-famous','Post-nonfamous'});
export_fig([outpath 'lFFAvsRHPC-bar_withdatapoint'],'-pdf');
plot2svg([outpath 'lFFAvsRHPC-bar_withdatapoint.svg'],s);

% plot rffa vs lHPC correlation in postfam nonfam rest
brainCorr.name1 = 'R_FFA';
brainCorr.name2 = 'L_HPC';
[preCorr famCorr nonfamCorr] = getBrainCorrData(brainCorr.name1,brainCorr.name2);

brainCorr.data = famCorr;
brainCorr.fameFlag = 'Fam';
% plot scatter plot bwt brain correlation and associative memory
% performance
plotBrainCorrWithAssociativeMem(brainCorr,pairMem.intactFam);


% plot rffa vs lHPC correlation in postfam nonfam rest
brainCorr.name1 = 'L_PPA';
brainCorr.name2 = 'L_TMP';
[preCorr famCorr nonfamCorr] = getBrainCorrData(brainCorr.name1,brainCorr.name2);

brainCorr.data = famCorr;
brainCorr.fameFlag = 'Fam';
% plot scatter plot bwt brain correlation and associative memory
% performance
plotBrainCorrWithAssociativeMem(brainCorr,pairMem.intactFam);

brainCorr.name1 = 'L_PPA';
brainCorr.name2 = 'R_TMP';
[preCorr famCorr nonfamCorr] = getBrainCorrData(brainCorr.name1,brainCorr.name2);

brainCorr.data = famCorr;
brainCorr.fameFlag = 'Fam';
% plot scatter plot bwt brain correlation and associative memory
% performance
plotBrainCorrWithAssociativeMem(brainCorr,pairMem.intactFam);

%**************************************************************************
%*******Controlling pre, post-encoding correlations predict memory*********
%**************************************************************************
brainCorr.name1 = 'R_FFA';
brainCorr.name2 = 'L_HPC';
[preCorr famCorr nonfamCorr] = getBrainCorrData(brainCorr.name1,brainCorr.name2);

brainCorr.data = famCorr-preCorr;
brainCorr.fameFlag = 'Fam-controlPre';
% plot scatter plot bwt brain correlation and associative memory
% performance
plotBrainCorrWithAssociativeMem(brainCorr,pairMem.intactFam);
% corrResults = robust_correlation(brainCorr.data,pairMem.intactFam-pairMem.intactNFam);

brainCorr.name1 = 'L_PPA';
brainCorr.name2 = 'L_TMP';
[preCorr famCorr nonfamCorr] = getBrainCorrData(brainCorr.name1,brainCorr.name2);

brainCorr.data = famCorr-preCorr;
brainCorr.fameFlag = 'Fam-controlPre';
% plot scatter plot bwt brain correlation and associative memory
% performance
plotBrainCorrWithAssociativeMem(brainCorr,pairMem.intactFam);
% corrResults = robust_correlation(brainCorr.data,pairMem.intactFam-pairMem.intactNFam);


%**************************************************************************
%******* post-encoding correlation diff predict memory diff *********
%**************************************************************************
brainCorr.name1 = 'R_PPA';
brainCorr.name2 = 'L_TMP';
[preCorr famCorr nonfamCorr] = getBrainCorrData(brainCorr.name1,brainCorr.name2);

brainCorr.data = famCorr-nonfamCorr;
brainCorr.fameFlag = 'Fam-NFam';
% plot scatter plot bwt brain correlation and associative memory
% performance
plotBrainCorrWithAssociativeMem(brainCorr,pairMem.intactFam-pairMem.intactNFam);
% corrResults = robust_correlation(brainCorr.data,pairMem.intactFam-pairMem.intactNFam);
x1=brainCorr.data;
x2=pairMem.intactFam-pairMem.intactNFam
x1(10)=[];
x2(10)=[];
[h p]=corr(x1,x2)


brainCorr.name1 = 'R_PPA';
brainCorr.name2 = 'R_TMP';
[preCorr famCorr nonfamCorr] = getBrainCorrData(brainCorr.name1,brainCorr.name2);

brainCorr.data = famCorr-nonfamCorr;
brainCorr.fameFlag = 'Fam-NFam';
% plot scatter plot bwt brain correlation and associative memory
% performance
plotBrainCorrWithAssociativeMem(brainCorr,pairMem.intactFam-pairMem.intactNFam);
x1=brainCorr.data;
x2=pairMem.intactFam-pairMem.intactNFam;



brainCorr.name1 = 'L_HPC';
brainCorr.name2 = 'L_vmP';
[preCorr famCorr nonfamCorr] = getBrainCorrData(brainCorr.name1,brainCorr.name2);

brainCorr.data = famCorr-nonfamCorr;
brainCorr.fameFlag = 'Fam-NFam';
% plot scatter plot bwt brain correlation and associative memory
% performance
plotBrainCorrWithAssociativeMem(brainCorr,pairMem.intactFam-pairMem.intactNFam);
% corrResults = robust_correlation(brainCorr.data,pairMem.intactFam-pairMem.intactNFam);


brainCorr.name1 = 'R_PPA';
brainCorr.name2 = 'R_HPC';
[preCorr famCorr nonfamCorr] = getBrainCorrData(brainCorr.name1,brainCorr.name2);

brainCorr.data = famCorr-nonfamCorr;
brainCorr.fameFlag = 'Fam-NFam';
% plot scatter plot bwt brain correlation and associative memory
% performance
plotBrainCorrWithAssociativeMem(brainCorr,pairMem.intactFam-pairMem.intactNFam);
% corrResults = robust_correlation(brainCorr.data,pairMem.intactFam-pairMem.intactNFam);


brainCorr.name1 = 'L_PPA';
brainCorr.name2 = 'L_TMP';
[preCorr famCorr nonfamCorr] = getBrainCorrData(brainCorr.name1,brainCorr.name2);

brainCorr.data = famCorr-nonfamCorr;
brainCorr.fameFlag = 'Fam-NFam';
% plot scatter plot bwt brain correlation and associative memory
% performance
plotBrainCorrWithAssociativeMem(brainCorr,pairMem.intactFam-pairMem.intactNFam);
% corrResults = robust_correlation(brainCorr.data,pairMem.intactFam-pairMem.intactNFam);

nodeDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\matlabFunctions\';
roiDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelAnalysis\picEffect_Pic-Scramble\';
BrainNet_MapCfg('BrainMesh_ICBM152_tal.nv',[roiDir,'allFunctionalROI.img'],[nodeDir,'postEncodingFamPredictMem.node'],...
    [nodeDir,'postEncodingFamPredictMem.edge'],[nodeDir,'postEncodingBrainNetNewSetupOption_anteriorTop.mat'],...
    [outpath,'postEncodingFamPredictMem.jpg']);



BrainNet_MapCfg('BrainMesh_ICBM152_tal.nv',[roiDir,'allFunctionalROI.img'],[nodeDir,'postEncodingDiff.node'],...
    [nodeDir,'postEncodingDiff.edge'],[nodeDir,'postEncodingBrainNetNewSetupOption_anteriorTop.mat'],...
    [outpath,'postEncodingFamNfamDiff.jpg']);

BrainNet_MapCfg('BrainMesh_ICBM152_tal.nv',[roiDir,'allFunctionalROI.img'],[nodeDir,'postEncodingNonFamPredictMem.node'],...
    [nodeDir,'postEncodingNonFamPredictMem.edge'],[nodeDir,'postEncodingBrainNetNewSetupOption_anteriorTop.mat'],...
    [outpath,'postEncodingNonFamPredictMem.jpg']);

BrainNet_MapCfg('BrainMesh_ICBM152_tal.nv',[roiDir,'allFunctionalROI.img'],[nodeDir,'postEncodingFamPredictMemControlPre.node'],...
    [nodeDir,'postEncodingFemPredictMemControlPre.edge'],[nodeDir,'postEncodingBrainNetNewSetupOption_anteriorTop.mat'],...
    [outpath,'postEncodingFamPredictMemControlPre.jpg']);


BrainNet_MapCfg('BrainMesh_ICBM152_tal.nv',[roiDir,'allFunctionalROI.img'],[nodeDir,'postEncodingConnectDiffPredictMemDiff_novmpfc.node'],...
    [nodeDir,'postEncodingConnectDiffPredictMemDiff_novmpfc.edge'],[nodeDir,'postEncodingBrainNetNewSetupOption.mat'],...
    [outpath,'postEncodingConnectDiffPredictMemDiff_novmpfc.jpg']);


 BrainNet_MapCfg('BrainMesh_ICBM152_tal.nv',[roiDir,'allFunctionalROI.img'],[nodeDir,'postEncodingBrainNetNewSetupOption_anteriorTop.mat'],...
     [outpath,'ROIs.jpg']);



function [preCorr famCorr nonfamCorr] = getBrainCorrData(roiName1, roiName2)

load('D:\myStudy\picpairfMRI\restingConnectivityConn_SessionAsConditions-filter00801-addMotionCovDespike\conn_restingConnectivity\results\firstlevel\ANALYSIS_01\resultsROI_Condition001.mat');

ida = FdIndexCellstr(names,roiName1);
idb = FdIndexCellstr(names2,roiName2);

preCorr=squeeze(Z(ida,idb,:));

load('D:\myStudy\picpairfMRI\restingConnectivityConn_SessionAsConditions-filter00801-addMotionCovDespike\conn_restingConnectivity\results\firstlevel\ANALYSIS_01\resultsROI_Condition002.mat');
famCorr=squeeze(Z(ida,idb,:));

load('D:\myStudy\picpairfMRI\restingConnectivityConn_SessionAsConditions-filter00801-addMotionCovDespike\conn_restingConnectivity\results\firstlevel\ANALYSIS_01\resultsROI_Condition003.mat');
nonfamCorr=squeeze(Z(ida,idb,:));

function plotBrainCorrWithAssociativeMem(brainCorr,associMem)
s=figure;
fsize=8;
% scatter(brainCorr.data,associMem,10,'ok','filled')
% ll=lsline;
% set(ll,'LineWidth',1.3,'Color','k');
% hold on;

x = replaceOutliers(brainCorr.data,2.5,2);
y = replaceOutliers(associMem,2.5,2);
scatter(x,y,10,'ok','filled')
l2=lsline;
set(l2,'LineWidth',1.3,'Color','k','LineStyle','-');
[B,BINT,R,RINT,STATS] = regress(y,[ones(length(x),1),x]);
t=sqrt(STATS(2));
p=STATS(3);
title(['regt= ',num2str(t),'regp= ',num2str(p)]);
xlabel([brainCorr.name1,'-',brainCorr.name2, ' correlation']);
ylabel('Associative memory');
set(gca,'fontsize',fsize);
box off;
set(gcf, 'Color', 'w');
setfigsize(s,8,'Helvetica',8,'Helvetica',6.5,4.5);
% xlim([min(x)-.05 max(x)+.05]);
xlim([-.2 .61]);
ylim([min(y)-.05 max(y)+.05]);
outpath = 'C:\Users\Zhongxu\Dropbox\picpair\PicparBehavioralmanuscript\postEncodingfMRIPub\figures\';
export_fig([outpath brainCorr.name1,'-',brainCorr.name2, ' correlation',brainCorr.fameFlag],'-pdf');


% 
% % ida = [131:134 117,118,127,128];
% % idb = [131:134 117,118,127,128];
% ida = [131:134 ];
% idb = [117,118,127,128];
% pvalFam=[]; fvalNfam=[];
% for i = 1:4
%     for j = 1:4
%         
% outpath = 'C:\Users\Zhongxu\Dropbox\picpair\PicparBehavioralmanuscript\postEncodingfMRIPub\figures\';
% load('D:\myStudy\picpairfMRI\restingConnectivityConn_SessionAsConditions-filter00801-addMotionCovDespike\conn_restingConnectivity\results\firstlevel\ANALYSIS_01\resultsROI_Condition002.mat');
% names{ida(i)}
% names2{idb(j)}
% famCorr=squeeze(Z(ida(i),idb(j),:));
% load('D:\myStudy\picpairfMRI\restingConnectivityConn_SessionAsConditions-filter00801-addMotionCovDespike\conn_restingConnectivity\results\firstlevel\ANALYSIS_01\resultsROI_Condition003.mat');
% nonfamCorr=squeeze(Z(ida(i),idb(j),:));
% 
% load('D:\myStudy\picpairfMRI\restingConnectivityConn_SessionAsConditions-filter00801-addMotionCovDespike\conn_restingConnectivity\results\firstlevel\ANALYSIS_01\resultsROI_Condition001.mat');
% preCorr=squeeze(Z(ida(i),idb(j),:));
% 
%  [B,BINT,R,RINT,STATS] = regress(pairMem.intactFam-pairMem.intactNFam,[ones(20,1) famCorr - nonfamCorr]);
%  fvalFamNfam(i,j) = STATS(2);
%  pvalFamNfam(i,j)= STATS(3);
%     end
% end
% % indx = LowerTriangleIndex(4);
% % pp=pval(indx);
% ppFamNfam=reshape(pvalFamNfam,16,1);
% [fdrFamNfam] = mafdr(ppFamNfam, 'BHFDR', true);
% fdrFamNfam = reshape(fdrFamNfam,4,4);
% 
% 
% ida = [131:134 ];
% idb = [117,118,127,128];
% pvalPreFam=[]; fvalPreFam=[];
% for i = 1:4
%     for j = 1:4
%         
% outpath = 'C:\Users\Zhongxu\Dropbox\picpair\PicparBehavioralmanuscript\postEncodingfMRIPub\figures\';
% load('D:\myStudy\picpairfMRI\restingConnectivityConn_SessionAsConditions-filter00801-addMotionCovDespike\conn_restingConnectivity\results\firstlevel\ANALYSIS_01\resultsROI_Condition002.mat');
% names{ida(i)}
% names2{idb(j)}
% famCorr=squeeze(Z(ida(i),idb(j),:));
% load('D:\myStudy\picpairfMRI\restingConnectivityConn_SessionAsConditions-filter00801-addMotionCovDespike\conn_restingConnectivity\results\firstlevel\ANALYSIS_01\resultsROI_Condition003.mat');
% nonfamCorr=squeeze(Z(ida(i),idb(j),:));
% 
% load('D:\myStudy\picpairfMRI\restingConnectivityConn_SessionAsConditions-filter00801-addMotionCovDespike\conn_restingConnectivity\results\firstlevel\ANALYSIS_01\resultsROI_Condition001.mat');
% preCorr=squeeze(Z(ida(i),idb(j),:));
% 
%  [B,BINT,R,RINT,STATS] = regress(pairMem.intactFam,[ones(20,1) famCorr-preCorr]);
%  fvalPreFam(i,j) = STATS(2);
%  pvalPreFam(i,j)= STATS(3);
%  BPreFam(i,j) = B(2);
%     end
% end
% % indx = LowerTriangleIndex(4);
% % pp=pval(indx);
% ppPreFam=reshape(pvalPreFam,16,1);
% [fdrPreFam] = mafdr(ppPreFam, 'BHFDR', true);
% fdrPreFam = reshape(fdrPreFam,4,4);
% 
% ida = [131:134 ];
% idb = [117,118,127,128];
% pvalPreNfam=[]; fvalPreNfam=[];
% for i = 1:4
%     for j = 1:4
%         
% outpath = 'C:\Users\Zhongxu\Dropbox\picpair\PicparBehavioralmanuscript\postEncodingfMRIPub\figures\';
% load('D:\myStudy\picpairfMRI\restingConnectivityConn_SessionAsConditions-filter00801-addMotionCovDespike\conn_restingConnectivity\results\firstlevel\ANALYSIS_01\resultsROI_Condition002.mat');
% names{ida(i)}
% names2{idb(j)}
% famCorr=squeeze(Z(ida(i),idb(j),:));
% load('D:\myStudy\picpairfMRI\restingConnectivityConn_SessionAsConditions-filter00801-addMotionCovDespike\conn_restingConnectivity\results\firstlevel\ANALYSIS_01\resultsROI_Condition003.mat');
% nonfamCorr=squeeze(Z(ida(i),idb(j),:));
% 
% load('D:\myStudy\picpairfMRI\restingConnectivityConn_SessionAsConditions-filter00801-addMotionCovDespike\conn_restingConnectivity\results\firstlevel\ANALYSIS_01\resultsROI_Condition001.mat');
% preCorr=squeeze(Z(ida(i),idb(j),:));
% 
%  [B,BINT,R,RINT,STATS] = regress(pairMem.intactFam,[ones(20,1) nonfamCorr-preCorr]);
%  fvalPreNfam(i,j) = STATS(2);
%  pvalPreNfam(i,j)= STATS(3);
%  BPreNfam(i,j) = B(2);
%     end
% end
% % indx = LowerTriangleIndex(4);
% % pp=pval(indx);
% ppPreNfam=reshape(pvalPreNfam,16,1);
% [fdrPreNfam] = mafdr(ppPreNfam, 'BHFDR', true);
% fdrPreNfam = reshape(fdrPreNfam,4,4);


% PLS analysis
% rootDir='C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\similarityAnalysis\dataUsingGroupROIs\';
% 
% for subj = 1:20
%     
%     disp(subj)
%     
%     %dataset 1 - encoding time series
%          
%         load([rootDir,'restingTimeSeriesData_groupROIs\subject-', sprintf('%03d',subj),...
%             '-condition-', sprintf('%03d',2),'.mat']);
%        datafam(:,:,subj) = corr(roiTimeSeriesData(:,a)); 
%                load([rootDir,'restingTimeSeriesData_groupROIs\subject-', sprintf('%03d',subj),...
%             '-condition-', sprintf('%03d',3),'.mat']);
%        datanfam(:,:,subj) = corr(roiTimeSeriesData(:,a)); 
%         
% end
% 
% for i = 1:size(datafam,1)
%     for j = 1:i
%     [a p c f] = ttest(squeeze(datafam(i,j,:)),squeeze(datanfam(i,j,:)));
%     
%     t(i,j)=f.tstat;
%     end
% end
% t(abs(t)<5)=0;
% imagesc(t)
% 
% lowTriagDataIndx = LowerTriangleIndex(size(datafam,1));
% 
% 
% %stack the low triagle matrix data into a row
% for i = 1:20
% temp1 = datafam(:,:,i);
% preEnco10Stack(i,:)= temp1(lowTriagDataIndx);   
%     
% temp2 = datanfam(:,:,i);
% postFamEnco10Stack(i,:)= temp2(lowTriagDataIndx);
% 
% % temp3 = postNonFamEncoRest(roiIndx, roiIndx,i);
% % postNonFamEnco10Stack(i,:)= temp3(lowTriagDataIndx);
% % clear temp1 temp2 temp3
% end
% 
% % making input data for commend line pls: concatenating 3 resting data
% % together
% datamat_list{1} = cat(1, preEnco10Stack,postFamEnco10Stack);
% % specify other parameter for pls analysis
% num_subj_lst = 20;
% num_cond = 2;
% option.method = 2; %non-rotated
% option.num_perm = 500;
% option.num_boot = 500;
% option.clim = 95;
% option.stacked_designdata = [1 -1]'; % I only have 2 contrast
% 
% result = pls_analysis(datamat_list, num_subj_lst, num_cond,option);
% 
% % Comparing postfam vs. postnonfam
% temp1=result.boot_result.compare_u(:,1);
% dataForPlot = zeros(length(roiIndx));
% dataForPlot(lowTriagDataIndx)= temp1;
% figure;
% imagesc(dataForPlot);
% figure;
% dataForPlot(abs(dataForPlot)<3)=0;
% imagesc(dataForPlot);
