function makingResultsTablesForPostEncodingRest

outputDir = 'D:\myStudy\picpairfMRI\postEncodingRest\conn_restingConnectivity\results\';
load(['C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\matlabFunctions\',...
    'performanceDataConcatenated.mat']);


% maskFile = ['D:\myStudy\picpairfMRI\postEncodingRest\conn_restingConnectivity\results\secondlevel\lhpc-lsupfront-postivePredictNFamPairmem-mask.img'];
% sourceDir = 'D:\myStudy\picpairfMRI\postEncodingRest\conn_restingConnectivity\results\secondlevel\ANALYSIS_01.SUBJECT_EFFECTS_subjAll.CONDITIONS_preRest(-1.0).postFam(1.0)\AAL.Hippocampus_(L)_1_1\';
% sourceFileName = 'CON_Subj*.nii';
% dataOut = extractMeanUsingRexGeneral(maskFile,sourceDir,sourceFileName)
% memData=replaceOutliers(pairMem.intactFam,2.5,1);
% conData=replaceOutliers(dataOut,2.5,1);
% figure;scatter(conData,memData);



%%%% making results table for post-encoding hpc connectivity
% hpc postfam - postnonfam 
%left hpc
xSPM.swd       = 'D:\myStudy\picpairfMRI\postEncodingRest\conn_restingConnectivity\results\secondlevel\ANALYSIS_01.SUBJECT_EFFECTS_subjAll.CONDITIONS_postFam(1.0).postNonFam(-1.0)\AAL.Hippocampus_(L)_1_1';
xSPM.Ic        = 1; % index of contrast
getTables(xSPM,[outputDir,'lHPC-fam-nfam']);
xSPM.Ic        = 2; % index of contrast
getTables(xSPM,[outputDir,'lHPC-nfam-fam']);

% right hpc
xSPM.swd       = 'D:\myStudy\picpairfMRI\postEncodingRest\conn_restingConnectivity\results\secondlevel\ANALYSIS_01.SUBJECT_EFFECTS_subjAll.CONDITIONS_postFam(1.0).postNonFam(-1.0)\AAL.Hippocampus_(R)_1_1';
xSPM.Ic        = 1; % index of contrast
getTables(xSPM,[outputDir,'rlHPC-fam-nfam']);
xSPM.Ic        = 2; % index of contrast
getTables(xSPM,[outputDir,'rHPC-nfam-fam']);

% 
% % left hpc pre-postfam predicting pairmem in fam
% xSPM.swd       = 'D:\myStudy\picpairfMRI\postEncodingRest\conn_restingConnectivity\results\secondlevel\ANALYSIS_01.SUBJECT_EFFECTS_subjAll(0.0).famIntactPairMemNoOutliers(1.0).CONDITIONS_preRest(-1.0).po\AAL.Hippocampus_(L)_1_1';
% xSPM.Ic        = 1; % index of contrast
% getTables(xSPM,[outputDir,'lHPC-PostFam-pre-posPredict-famPairMem']);
% xSPM.Ic        = 2; % index of contrast
% getTables(xSPM,[outputDir,'lHPC-PostFam-pre-negPredict-famPairMem']);
% 
% % right hpc pre-postfam predicting pairmem in fam
% xSPM.swd       = 'D:\myStudy\picpairfMRI\postEncodingRest\conn_restingConnectivity\results\secondlevel\ANALYSIS_01.SUBJECT_EFFECTS_subjAll(0.0).famIntactPairMemNoOutliers(1.0).CONDITIONS_preRest(-1.0).po\AAL.Hippocampus_(R)_1_1';
% xSPM.Ic        = 1; % index of contrast
% getTables(xSPM,[outputDir,'rHPC-PostFam-pre-posPredict-famPairMem']);
% xSPM.Ic        = 2; % index of contrast
% getTables(xSPM,[outputDir,'rHPC-PostFam-pre-negPredict-famPairMem']);
% 
% 
% % left hpc pre-postNfam predicting pairmem in Nfam
% xSPM.swd       = 'D:\myStudy\picpairfMRI\postEncodingRest\conn_restingConnectivity\results\secondlevel\ANALYSIS_01.SUBJECT_EFFECTS_subjAll(0.0).NfamIntactPairMemNoOutlier(1.0).CONDITIONS_preRest(-1.0).po\AAL.Hippocampus_(L)_1_1';
% xSPM.Ic        = 1; % index of contrast
% getTables(xSPM,[outputDir,'lHPC-PostNFam-pre-posPredict-NfamPairMem']);
% xSPM.Ic        = 2; % index of contrast
% getTables(xSPM,[outputDir,'lHPC-PostNFam-pre-negPredict-NfamPairMem']);
% 
% % right hpc pre-postNfam predicting pairmem in Nfam
% xSPM.swd       = 'D:\myStudy\picpairfMRI\postEncodingRest\conn_restingConnectivity\results\secondlevel\ANALYSIS_01.SUBJECT_EFFECTS_subjAll(0.0).NfamIntactPairMemNoOutlier(1.0).CONDITIONS_preRest(-1.0).po\AAL.Hippocampus_(R)_1_1';
% xSPM.Ic        = 1; % index of contrast
% getTables(xSPM,[outputDir,'rHPC-PostNFam-pre-posPredict-NfamPairMem']);
% xSPM.Ic        = 2; % index of contrast
% getTables(xSPM,[outputDir,'rHPC-PostNFam-pre-negPredict-NfamPairMem']);
% 
% 
% % left hpc postfam-postNfam predicting pairmem fam-Nfam
% xSPM.swd       = 'D:\myStudy\picpairfMRI\postEncodingRest\conn_restingConnectivity\results\secondlevel\ANALYSIS_01.SUBJECT_EFFECTS_subjAll(0.0).fam-nfam_pairIntactMemDiffNoOutlier(1.0).CONDITIONS_postFam\AAL.Hippocampus_(L)_1_1';
% outputDir = 'D:\myStudy\picpairfMRI\postEncodingRest\conn_restingConnectivity\results\';
% xSPM.Ic        = 1; % index of contrast
% getTables(xSPM,[outputDir,'lHPC-Postfam-NFam-pre-posPredict-fam-NfamPairMem']);
% xSPM.Ic        = 2; % index of contrast
% getTables(xSPM,[outputDir,'lHPC-Postfam-NFam-pre-negPredict-fam-NfamPairMem']);
% 
% 
% % right hpc postfam-postNfam predicting pairmem fam-Nfam
% xSPM.swd       = 'D:\myStudy\picpairfMRI\postEncodingRest\conn_restingConnectivity\results\secondlevel\ANALYSIS_01.SUBJECT_EFFECTS_subjAll(0.0).fam-nfam_pairIntactMemDiffNoOutlier(1.0).CONDITIONS_postFam\AAL.Hippocampus_(R)_1_1';
% outputDir = 'D:\myStudy\picpairfMRI\postEncodingRest\conn_restingConnectivity\results\';
% xSPM.Ic        = 1; % index of contrast
% getTables(xSPM,[outputDir,'rHPC-Postfam-NFam-pre-posPredict-fam-NfamPairMem']);
% xSPM.Ic        = 2; % index of contrast
% getTables(xSPM,[outputDir,'rHPC-Postfam-NFam-pre-negPredict-fam-NfamPairMem']);


% left hpc postfam predicting pairmem fam
xSPM.swd       = 'D:\myStudy\picpairfMRI\postEncodingRest\conn_restingConnectivity\results\secondlevel\ANALYSIS_01.SUBJECT_EFFECTS_subjAll(0.0).famIntactPairMemNoOutliers(1.0).CONDITIONS_postFam\AAL.Hippocampus_(L)_1_1';
outputDir = 'D:\myStudy\picpairfMRI\postEncodingRest\conn_restingConnectivity\results\';
xSPM.Ic        = 1; % index of contrast
getTables(xSPM,[outputDir,'lHPC-Postfam-posPredict-famPairMem']);
xSPM.Ic        = 2; % index of contrast
getTables(xSPM,[outputDir,'lHPC-Postfam-negPredict-famPairMem']);


% r hpc postfam predicting pairmem fam
xSPM.swd       = 'D:\myStudy\picpairfMRI\postEncodingRest\conn_restingConnectivity\results\secondlevel\ANALYSIS_01.SUBJECT_EFFECTS_subjAll(0.0).famIntactPairMemNoOutliers(1.0).CONDITIONS_postFam\AAL.Hippocampus_(R)_1_1';
outputDir = 'D:\myStudy\picpairfMRI\postEncodingRest\conn_restingConnectivity\results\';
xSPM.Ic        = 1; % index of contrast
getTables(xSPM,[outputDir,'rHPC-Postfam-posPredict-famPairMem']);
xSPM.Ic        = 2; % index of contrast
getTables(xSPM,[outputDir,'rHPC-Postfam-negPredict-famPairMem']);



% left hpc postnfam predicting pairmem nfam
xSPM.swd       = 'D:\myStudy\picpairfMRI\postEncodingRest\conn_restingConnectivity\results\secondlevel\ANALYSIS_01.SUBJECT_EFFECTS_subjAll(0.0).NfamIntactPairMemNoOutlier(1.0).CONDITIONS_postNonFam\AAL.Hippocampus_(L)_1_1';
outputDir = 'D:\myStudy\picpairfMRI\postEncodingRest\conn_restingConnectivity\results\';
xSPM.Ic        = 1; % index of contrast
getTables(xSPM,[outputDir,'lHPC-Postnfam-posPredict-nfamPairMem']);
xSPM.Ic        = 2; % index of contrast
getTables(xSPM,[outputDir,'lHPC-Postnfam-negPredict-nfamPairMem']);


% r hpc postnfam predicting pairmem nfam
xSPM.swd       = 'D:\myStudy\picpairfMRI\postEncodingRest\conn_restingConnectivity\results\secondlevel\ANALYSIS_01.SUBJECT_EFFECTS_subjAll(0.0).NfamIntactPairMemNoOutlier(1.0).CONDITIONS_postNonFam\AAL.Hippocampus_(R)_1_1';
outputDir = 'D:\myStudy\picpairfMRI\postEncodingRest\conn_restingConnectivity\results\';
xSPM.Ic        = 1; % index of contrast
getTables(xSPM,[outputDir,'rHPC-Postnfam-posPredict-nfamPairMem']);
xSPM.Ic        = 3; % index of contrast
getTables(xSPM,[outputDir,'rHPC-Postnfam-negPredict-nfamPairMem']);

%%%%************************************************************************
%**************************************************************************
% ppa postfam - postnonfam 
%left ppa
xSPM.swd       = 'D:\myStudy\picpairfMRI\postEncodingRest\conn_restingConnectivity\results\secondlevel\ANALYSIS_01.SUBJECT_EFFECTS_subjAll.CONDITIONS_postFam(1.0).postNonFam(-1.0)\L_PPA_1_1';
outputDir = 'D:\myStudy\picpairfMRI\postEncodingRest\conn_restingConnectivity\results\';
xSPM.Ic        = 1; % index of contrast
getTables(xSPM,[outputDir,'lPPA-fam-nfam']);
xSPM.Ic        = 2; % index of contrast
getTables(xSPM,[outputDir,'lPPA-nfam-fam']);

% right ppa
xSPM.swd       = 'D:\myStudy\picpairfMRI\postEncodingRest\conn_restingConnectivity\results\secondlevel\ANALYSIS_01.SUBJECT_EFFECTS_subjAll.CONDITIONS_postFam(1.0).postNonFam(-1.0)\R_PPA_1_1';
outputDir = 'D:\myStudy\picpairfMRI\postEncodingRest\conn_restingConnectivity\results\';
xSPM.Ic        = 1; % index of contrast
getTables(xSPM,[outputDir,'rPPA-fam-nfam']);
xSPM.Ic        = 2; % index of contrast
getTables(xSPM,[outputDir,'rPPA-nfam-fam']);


% left ppa pre-postfam predicting pairmem in fam
xSPM.swd       = 'D:\myStudy\picpairfMRI\postEncodingRest\conn_restingConnectivity\results\secondlevel\ANALYSIS_01.SUBJECT_EFFECTS_subjAll(0.0).famIntactPairMemNoOutliers(1.0).CONDITIONS_preRest(-1.0).po\L_PPA_1_1';
outputDir = 'D:\myStudy\picpairfMRI\postEncodingRest\conn_restingConnectivity\results\';
xSPM.Ic        = 1; % index of contrast
getTables(xSPM,[outputDir,'lPPA-PostFam-pre-posPredict-famPairMem']);
xSPM.Ic        = 2; % index of contrast
getTables(xSPM,[outputDir,'lPPA-PostFam-pre-negPredict-famPairMem']);

% right PPA pre-postfam predicting pairmem in fam
xSPM.swd       = 'D:\myStudy\picpairfMRI\postEncodingRest\conn_restingConnectivity\results\secondlevel\ANALYSIS_01.SUBJECT_EFFECTS_subjAll(0.0).famIntactPairMemNoOutliers(1.0).CONDITIONS_preRest(-1.0).po\R_PPA_1_1';
outputDir = 'D:\myStudy\picpairfMRI\postEncodingRest\conn_restingConnectivity\results\';
xSPM.Ic        = 1; % index of contrast
getTables(xSPM,[outputDir,'rPPA-PostFam-pre-posPredict-famPairMem']);
xSPM.Ic        = 2; % index of contrast
getTables(xSPM,[outputDir,'rPPA-PostFam-pre-negPredict-famPairMem']);


% left PPA pre-postNfam predicting pairmem in Nfam
xSPM.swd       = 'D:\myStudy\picpairfMRI\postEncodingRest\conn_restingConnectivity\results\secondlevel\ANALYSIS_01.SUBJECT_EFFECTS_subjAll(0.0).NfamIntactPairMemNoOutlier(1.0).CONDITIONS_preRest(-1.0).po\L_PPA_1_1';
outputDir = 'D:\myStudy\picpairfMRI\postEncodingRest\conn_restingConnectivity\results\';
xSPM.Ic        = 1; % index of contrast
getTables(xSPM,[outputDir,'lPPA-PostNFam-pre-posPredict-NfamPairMem']);
xSPM.Ic        = 2; % index of contrast
getTables(xSPM,[outputDir,'lPPA-PostNFam-pre-negPredict-NfamPairMem']);

% right PPA pre-postNfam predicting pairmem in Nfam
xSPM.swd       = 'D:\myStudy\picpairfMRI\postEncodingRest\conn_restingConnectivity\results\secondlevel\ANALYSIS_01.SUBJECT_EFFECTS_subjAll(0.0).NfamIntactPairMemNoOutlier(1.0).CONDITIONS_preRest(-1.0).po\R_PPA_1_1';
outputDir = 'D:\myStudy\picpairfMRI\postEncodingRest\conn_restingConnectivity\results\';
xSPM.Ic        = 1; % index of contrast
getTables(xSPM,[outputDir,'rPPA-PostNFam-pre-posPredict-NfamPairMem']);
xSPM.Ic        = 2; % index of contrast
getTables(xSPM,[outputDir,'rPPA-PostNFam-pre-negPredict-NfamPairMem']);

% left PPA postfam-postNfam predicting pairmem fam-Nfam
xSPM.swd       = 'D:\myStudy\picpairfMRI\postEncodingRest\conn_restingConnectivity\results\secondlevel\ANALYSIS_01.SUBJECT_EFFECTS_subjAll(0.0).fam-nfam_pairIntactMemDiffNoOutlier(1.0).CONDITIONS_postFam\L_PPA_1_1';
outputDir = 'D:\myStudy\picpairfMRI\postEncodingRest\conn_restingConnectivity\results\';
xSPM.Ic        = 1; % index of contrast
getTables(xSPM,[outputDir,'lPPA-Postfam-NFam-pre-posPredict-fam-NfamPairMem']);
xSPM.Ic        = 2; % index of contrast
getTables(xSPM,[outputDir,'lPPA-Postfam-NFam-pre-negPredict-fam-NfamPairMem']);


% right PPA postfam-postNfam predicting pairmem fam-Nfam
xSPM.swd       = 'D:\myStudy\picpairfMRI\postEncodingRest\conn_restingConnectivity\results\secondlevel\ANALYSIS_01.SUBJECT_EFFECTS_subjAll(0.0).fam-nfam_pairIntactMemDiffNoOutlier(1.0).CONDITIONS_postFam\R_PPA_1_1';
outputDir = 'D:\myStudy\picpairfMRI\postEncodingRest\conn_restingConnectivity\results\';
xSPM.Ic        = 1; % index of contrast
getTables(xSPM,[outputDir,'rPPA-Postfam-NFam-pre-posPredict-fam-NfamPairMem']);
xSPM.Ic        = 2; % index of contrast
getTables(xSPM,[outputDir,'rPPA-Postfam-NFam-pre-negPredict-fam-NfamPairMem']);




maskDir = 'D:\myStudy\picpairfMRI\postEncodingRest\conn_restingConnectivity\results\secondlevel\';
maskFile = [maskDir,'lhpc-anterior-fameeffects.img'];
[mValHPCL_PFC mValHPCR_PFC] = extractMeanUsingRex(maskFile);
tLhpcPFC =plot3RestingBar(mValHPCL_PFC,'LHPC_PFC');
brainCorr.name1 = 'L_HPC';
brainCorr.name2 = 'R_PFC';
brainCorr.data = mValHPCL_PFC(:,2)-mValHPCL_PFC(:,3);
brainCorr.fameFlag = 'Fam-NFam';
% plot scatter plot bwt brain correlation and associative memory
% performance
plotBrainCorrWithAssociativeMem(brainCorr,pairMem.intactFam-pairMem.intactNFam);



maskDir = 'D:\myStudy\picpairfMRI\postEncodingRest\conn_restingConnectivity\results\secondlevel\';
maskFile = [maskDir,'lhpc-posterior-fameffect.img'];
[mValHPCL_p mValHPCR_p] = extractMeanUsingRex(maskFile);
tLhpcOccip =plot3RestingBar(mValHPCL_p,'LHPC_Occip');
brainCorr.name1 = 'L_HPC';
brainCorr.name2 = 'L_Occip';
brainCorr.data = mValHPCL_p(:,2)-mValHPCL_p(:,3);
brainCorr.fameFlag = 'Fam-NFam';
% plot scatter plot bwt brain correlation and associative memory
% performance
plotBrainCorrWithAssociativeMem(brainCorr,pairMem.intactFam-pairMem.intactNFam);





maskDir = 'D:\myStudy\picpairfMRI\postEncodingRest\conn_restingConnectivity\results\secondlevel\';
maskFile = [maskDir,'lhpc-Precuneus_from_spmT_0001.img'];
[mValHPCL_precu mValHPCR_precu] = extractMeanUsingRex(maskFile);

maskDir = 'D:\myStudy\picpairfMRI\postEncodingRest\conn_restingConnectivity\results\secondlevel\';
maskFile = [maskDir,'rhpc-cigulate-fameeffects.img'];
[mValHPCL_cing mValHPCR_cing] = extractMeanUsingRex(maskFile);
tRhpcCing =plot3RestingBar(mValHPCR_cing,'RHPC_cing');
brainCorr.name1 = 'R_HPC';
brainCorr.name2 = 'R_Cing';
brainCorr.data = mValHPCR_cing(:,2)-mValHPCR_cing(:,3);
brainCorr.fameFlag = 'Fam-NFam';
% plot scatter plot bwt brain correlation and associative memory
% performance
plotBrainCorrWithAssociativeMem(brainCorr,pairMem.intactFam-pairMem.intactNFam);




maskDir = 'D:\myStudy\picpairfMRI\postEncodingRest\conn_restingConnectivity\results\secondlevel\';
maskFile = [maskDir,'rhpc-fusiform-fameeffects.img'];
[mValHPCL_fusi mValHPCR_fusi] = extractMeanUsingRex(maskFile);
tRhpcFusi =plot3RestingBar(mValHPCR_fusi,'RHPC_Fusi');

brainCorr.name1 = 'R_HPC';
brainCorr.name2 = 'L_Fusi';
brainCorr.data = mValHPCR_fusi(:,2)-mValHPCR_fusi(:,3);
brainCorr.fameFlag = 'Fam-NFam';
% plot scatter plot bwt brain correlation and associative memory
% performance
plotBrainCorrWithAssociativeMem(brainCorr,pairMem.intactFam-pairMem.intactNFam);

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


function stat = plot3RestingBar(data,fileName)
outpath = 'C:\Users\Zhongxu\Dropbox\picpair\PicparBehavioralmanuscript\postEncodingfMRIPub\figures\';

s = figure; 
fsize=6;
ss = bar(mean(data,1),'k');
hold on;
errorbar(mean(data,1),std(data,1)/sqrt(20),'k');
hold on;
%     scatter(1.1*ones(20,1),famCorr, 20, randColor);
%         scatter(1.9*ones(20,1),nonfamCorr, 20, randColor);
%      scatter(1.1*ones(20,1),famCorr, 20,'k');
%          scatter(1.9*ones(20,1),nonfamCorr,20,'k'); 
%     hold on;
% for i = 1:20
%     randColor(i,:) = rand(1,3);
%     plot([1.1,1.9],[famCorr(i),nonfamCorr(i)],'Color',randColor(i,:));
% 
%     hold on;
% end

   
ylabel('Connectivity','fontsize',fsize); 
set(gca,'fontsize',fsize);
box off;
set(gcf, 'Color', 'w');
setfigsize(s,6,'Helvetica',6,'Helvetica',4,3);
set(gca,'YLim',[min(mean(data,1))-.05 max(mean(data,1))+.05]);
set(gca, 'XTickLabel', {'Pre-encoding','Post-famous','Post-nonfamous'});
export_fig([outpath fileName],'-pdf');
plot2svg([outpath, fileName,'.svg'],s);
[a b c d]=ttest(data(:,1),data(:,2));
stat.p(1)=b;
stat.t(1)=d.tstat;
[a b c d]=ttest(data(:,1),data(:,3));
stat.p(2)=b;
stat.t(2)=d.tstat;
[a b c d]=ttest(data(:,2),data(:,3));
stat.p(3)=b;
stat.t(3)=d.tstat;


function [mValHPCL mValHPCR] = extractMeanUsingRex(maskFile)
sourceDir = 'D:\myStudy\picpairfMRI\postEncodingRest\conn_restingConnectivity\results\firstlevel\ANALYSIS_01\';
filePreHPCL = dir([sourceDir,'*Condition001_Source037.nii']);
filePreHPCR = dir([sourceDir,'*Condition001_Source038.nii']);
filePostFamHPCL = dir([sourceDir,'*Condition002_Source037.nii']);
filePostFamHPCR = dir([sourceDir,'*Condition002_Source038.nii']);
filePostNFamHPCL = dir([sourceDir,'*Condition003_Source037.nii']);
filePostNFamHPCR = dir([sourceDir,'*Condition003_Source038.nii']);
for i = 1:length(filePreHPCL)
fileNames = [sourceDir,char(filePreHPCL(i).name)];
mValHPCL(i,1) = rex(fileNames,maskFile);

fileNames = [sourceDir,char(filePostFamHPCL(i).name)];
mValHPCL(i,2) = rex(fileNames,maskFile);

fileNames = [sourceDir,char(filePostNFamHPCL(i).name)];
mValHPCL(i,3) = rex(fileNames,maskFile);

fileNames = [sourceDir,char(filePreHPCR(i).name)];
mValHPCR(i,1) = rex(fileNames,maskFile);

fileNames = [sourceDir,char(filePostFamHPCR(i).name)];
mValHPCR(i,2) = rex(fileNames,maskFile);

fileNames = [sourceDir,char(filePostNFamHPCR(i).name)];
mValHPCR(i,3) = rex(fileNames,maskFile);

end

function dataOut = extractMeanUsingRexGeneral(maskFile,sourceDir,sourceFileName)
sourcef = dir([sourceDir,sourceFileName]);
for i = 1:length(sourcef)
fileNames = [sourceDir,char(sourcef(i).name)];
dataOut(i,1) = rex(fileNames,maskFile);
end



function getTables(xSPM,outName)
if xSPM.Ic ==2 && exist([xSPM.swd,'\spmT_0002.img'])==0
 matlabbatch{1}.spm.stats.con.spmmat = {[xSPM.swd,'\SPM.mat']};
matlabbatch{1}.spm.stats.con.consess{1}.tcon.name = 'negContrast';
matlabbatch{1}.spm.stats.con.consess{1}.tcon.convec = '-1';
matlabbatch{1}.spm.stats.con.consess{1}.tcon.sessrep = 'none';
matlabbatch{1}.spm.stats.con.delete = 0;
spm('defaults', 'FMRI');
spm_jobman('run',matlabbatch);
end
    
xSPM.n         = 1; % conjunction number (next update)
xSPM.u         = 0.005;
xSPM.Im        =[]; % if no masking
% if need masking
% xSPM.Im        = {'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelAnalysis\picEffect_Pic-Scramble\L_HPC.img'};
% xSPM.Ex        = 0; % 0 inclusive 1, exclusive
xSPM.thresDesc = 'none'; % 'FWE', or 'FDR'-if using FDR defaults.stats.topFDR need be changed from 1 to 0
xSPM.title     = '';
xSPM.k         = 10;
xSPM.units     = {'mm' 'mm' 'mm'};
defaultCor     = [24 -14 -18]; % for right hippocampus
% encodingFam_nonfam001_10= batchProduceOutputFigAndTable(xSPM,defaultCor,0,'fam-nfam');
encodingFam_nonfam001_10= batchProduceOutputFigAndTable(xSPM,defaultCor,1,outName);

