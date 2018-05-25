function [dataAll, orderEffectFam, orderEffectNFam,slopFamNfamDiff,contrEncCorr slopFamDiff] = postencodingRestingHPCcorrelation_orderEffectForDefense
%modified July 30, 2015;
%zhongxu

addpath('C:\Users\Zhongxu\Documents\MATLAB\myMatLabTools\Corr_toolbox_v2');
addpath('C:\Users\Zhongxu\Documents\MATLAB\myMatLabTools\Corr_toolbox_v2\LIBRA');
% plot lffa vs rHPC correlation in postfam nonfam rest
outpath = 'D:\myStudy\picpairfMRI\Documents\picpair\PicparBehavioralmanuscript\PhDDissertation\figurefordefensepresentation\';
load(['C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\matlabFunctions\',...
    'performanceDataConcatenated.mat']);
load(['C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\matlabFunctions\',...
    'reinstatementData.mat']);
rootDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\';
[subjInfo a]=xlsread([rootDir,'matlabFunctions\picpairSubjInfo.xlsx']);
age = subjInfo(:,2);
gender  = subjInfo(:,3);

load([rootDir,'matlabFunctions\prepostRestInterview.mat']);
load('D:\myStudy\picpairfMRI\postEncodingRest\conn_restingConnectivity\results\firstlevel\ANALYSIS_01\resultsROI_Condition001.mat');
% load('C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\EncodingCorr_ControlCov_5ROI_originalData_defense\P_V_Correlations_L-R.mat');

load([rootDir,'matlabFunctions\faceEvalMTotal.mat']);

mindActive=1-prepostRestInterview(:,10:12);
emotionEv=faceEvalMTotal.emotion(:,1);
memoryEv=faceEvalMTotal.memory(:,1);
familiarEv=faceEvalMTotal.familiarity(:,1);
attracEv=faceEvalMTotal.attractiveness(:,1);



%**************************************************************************
%*************************post encoding correlations***********************
%**************************************************************************


roi1={'L_PPA','L_PPA','R_PPA','L_FFA','R_FFA','L_HPC','R_PPA','L_FFA','L_FFA'};
roi2={'L_TMP','R_TMP','L_TMP','L_TMP','L_HPC','L_FFA','R_TMP','R_FFA','R_HPC'};
for i = 1:length(roi1)
[preCorr(:,i) famCorr(:,i) nonfamCorr(:,i)] = getBrainCorrData(roi1{i},roi2{i});
end


%famous condition
%nonfamous condition
clear brainCorr;
brainCorr.name1 = 'L_FFA';
brainCorr.name2 = 'R_HPC';
[preCorr famCorr nonfamCorr] = getBrainCorrData(brainCorr.name1,brainCorr.name2);
orderEffectFam{6} = plotBarsForDifferentOrder(famCorr,'Lffa-Rhpc-fam',outpath,[0 .3])
orderEffectFam{7} = plotBarsForDifferentOrder(nonfamCorr,'Lffa-Rhpc-nfam',outpath,[0 .3])
slopFamNfamDiff{6} = regressionSlopDiff(famCorr, nonfamCorr,pairMem.intactFam,pairMem.intactNFam)
slopFamDiff.PairMem{6} = regressionSlopDiff(famCorr, famCorr,pairMem.intactFam,pairMem.intactNFam);
slopFamDiff.FaceMem{6} = regressionSlopDiff(famCorr, famCorr,pairMem.intactFam,faceMem.totalFam);
slopFamDiff.HouseMem{6} = regressionSlopDiff(famCorr, famCorr,pairMem.intactFam,houseMem.totalFam);


contrEncCorr{6} = controllingForEncodingCorr(brainCorr,famCorrGrpLR,famCorr,pairMem.intactFam)
contrEncCorr{7} = controllingForEncodingCorr(brainCorr,nonfamCorrGrpLR,nonfamCorr,pairMem.intactNFam)
%%% after controlling encoding connectivity, there post-encoding
%%% connectivity still predicted later associativememory performance.!!!!!

%%& results for slope differences are different from the ones reported in
%%thesis, which was calculated using online formular
%%(beta1-beta2)/squrt(sb1^2+sb2^2) but the conclusion is the same.
brainCorr.famdata=famCorr;
brainCorr.nonfamdata=nonfamCorr;
dataAll{6} = brainCorr;
dataAll{7} = 'nonfamCorrOderEff';


clear brainCorr;
brainCorr.name1 = 'L_FFA';
brainCorr.name2 = 'R_HPC';
brainCorr.data = famCorr;
brainCorr.fameFlag = 'Fam';
plotBrainCorrWithAssociativeMemWithOrderSeparated(brainCorr,pairMem.intactFam);
brainCorr.fameFlag = 'Fam-NonFam';
plotBrainCorrWithAssociativeMemWithOrderSeparated(brainCorr,pairMem.intactNFam);

brainCorr.data = nonfamCorr;
brainCorr.fameFlag = 'NonFam';
plotBrainCorrWithAssociativeMemWithOrderSeparated(brainCorr,pairMem.intactNFam);
brainCorr.fameFlag = 'NonFam-Fam';
plotBrainCorrWithAssociativeMemWithOrderSeparated(brainCorr,pairMem.intactFam);



%  figure;scatter(replaceOutliers(famCorr,2.5,2),replaceOutliers(nonfamCorr,2.5,2));
%  figure;scatter(replaceOutliers(pairMem.intactFam,2.5,2),replaceOutliers(pairMem.intactNFam,2.5,2))

%%
associMem = pairMem.intactFam;
% plot rffa vs lHPC correlation in postfam nonfam rest
clear brainCorr;
brainCorr.name1 = 'R_FFA';
brainCorr.name2 = 'L_HPC';
[preCorr famCorr nonfamCorr] = getBrainCorrData(brainCorr.name1,brainCorr.name2);
orderEffectFam{1} = plotBarsForDifferentOrder(famCorr,'Rffa-Lhpc-fam',outpath,[0 .25]);
orderEffectNFam{1} = plotBarsForDifferentOrder(nonfamCorr,'Rffa-Lhpc-nfam',outpath,[0 .25]);

slopFamNfamDiff{1} = regressionSlopDiff(famCorr, nonfamCorr,pairMem.intactFam,pairMem.intactNFam)
slopFamDiff.PairMem{1} = regressionSlopDiff(famCorr, famCorr,pairMem.intactFam,pairMem.intactNFam);
slopFamDiff.FaceMem{1} = regressionSlopDiff(famCorr, famCorr,pairMem.intactFam,faceMem.totalFam);
slopFamDiff.HouseMem{1} = regressionSlopDiff(famCorr, famCorr,pairMem.intactFam,houseMem.totalFam);



contrEncCorr{1} = controllingForEncodingCorr(brainCorr,famCorrGrpLR,famCorr,pairMem.intactFam)

% order effects for conn-memory relation
brainCorr.data = famCorr;
brainCorr.fameFlag = 'Fam';
cstatsFam{1} = plotBrainCorrWithAssociativeMemWithOrderSeparated(brainCorr,associMem);
brainCorr.fameFlag = 'Fam-NonFam';
plotBrainCorrWithAssociativeMemWithOrderSeparated(brainCorr,pairMem.intactNFam);


brainCorr.data = nonfamCorr;
brainCorr.fameFlag = 'NonFam';
cstatsNFam{1}=plotBrainCorrWithAssociativeMemWithOrderSeparated(brainCorr,pairMem.intactNFam);
brainCorr.fameFlag = 'NonFam-Fam';
plotBrainCorrWithAssociativeMemWithOrderSeparated(brainCorr,pairMem.intactFam);
brainCorr.famdata=famCorr;
brainCorr.nonfamdata=nonfamCorr;
dataAll{1} = brainCorr;
%% 
clear brainCorr;
brainCorr.name1 = 'L_PPA';
brainCorr.name2 = 'L_TMP';
[preCorr famCorr nonfamCorr] = getBrainCorrData(brainCorr.name1,brainCorr.name2);
orderEffectFam{2} = plotBarsForDifferentOrder(famCorr,'Lppa-LTPL-fam',outpath,[-.05 .2]);
orderEffectNFam{2} = plotBarsForDifferentOrder(nonfamCorr,'Lppa-LTPL-nfam',outpath,[-.05 .2]);

slopFamNfamDiff{2} = regressionSlopDiff(famCorr, nonfamCorr,pairMem.intactFam,pairMem.intactNFam)
slopFamDiff.PairMem{2} = regressionSlopDiff(famCorr, famCorr,pairMem.intactFam,pairMem.intactNFam);
slopFamDiff.FaceMem{2} = regressionSlopDiff(famCorr, famCorr,pairMem.intactFam,faceMem.totalFam);
slopFamDiff.HouseMem{2} = regressionSlopDiff(famCorr, famCorr,pairMem.intactFam,houseMem.totalFam);
contrEncCorr{2} = controllingForEncodingCorr(brainCorr,famCorrGrpLR,famCorr,pairMem.intactFam)


brainCorr.data = famCorr;
brainCorr.fameFlag = 'Fam';
cstatsFam{2} = plotBrainCorrWithAssociativeMemWithOrderSeparated(brainCorr,associMem);
brainCorr.fameFlag = 'Fam-NonFam';
plotBrainCorrWithAssociativeMemWithOrderSeparated(brainCorr,pairMem.intactNFam);

brainCorr.data = nonfamCorr;
brainCorr.fameFlag = 'NonFam';
cstatsNFam{2}=plotBrainCorrWithAssociativeMemWithOrderSeparated(brainCorr,pairMem.intactNFam);
brainCorr.fameFlag = 'NonFam-Fam';
plotBrainCorrWithAssociativeMemWithOrderSeparated(brainCorr,pairMem.intactFam);
brainCorr.famdata=famCorr;
brainCorr.nonfamdata=nonfamCorr;
dataAll{2} = brainCorr;



%%
clear brainCorr;
brainCorr.name1 = 'R_PPA';
brainCorr.name2 = 'L_TMP';
[preCorr famCorr nonfamCorr] = getBrainCorrData(brainCorr.name1,brainCorr.name2);
orderEffectFam{3} = plotBarsForDifferentOrder(famCorr,'Rppa-LTPL-fam',outpath,[0 .25]);
orderEffectNFam{3} = plotBarsForDifferentOrder(nonfamCorr,'Rppa-LTPL-nfam',outpath,[0 .25]);

slopFamNfamDiff{3} = regressionSlopDiff(famCorr, nonfamCorr,pairMem.intactFam,pairMem.intactNFam)
slopFamDiff.PairMem{3} = regressionSlopDiff(famCorr, famCorr,pairMem.intactFam,pairMem.intactNFam);
slopFamDiff.FaceMem{3} = regressionSlopDiff(famCorr, famCorr,pairMem.intactFam,faceMem.totalFam);
slopFamDiff.HouseMem{3} = regressionSlopDiff(famCorr, famCorr,pairMem.intactFam,houseMem.totalFam);
contrEncCorr{3} = controllingForEncodingCorr(brainCorr,famCorrGrpLR,famCorr,pairMem.intactFam)

brainCorr.data = famCorr;
brainCorr.fameFlag = 'Fam';
cstatsFam{3} = plotBrainCorrWithAssociativeMemWithOrderSeparated(brainCorr,associMem);
brainCorr.fameFlag = 'Fam-NonFam';
plotBrainCorrWithAssociativeMemWithOrderSeparated(brainCorr,pairMem.intactNFam);

brainCorr.data = nonfamCorr;
brainCorr.fameFlag = 'NonFam';
cstatsNFam{3}=plotBrainCorrWithAssociativeMemWithOrderSeparated(brainCorr,pairMem.intactNFam);
brainCorr.fameFlag = 'NonFam-Fam';
plotBrainCorrWithAssociativeMemWithOrderSeparated(brainCorr,pairMem.intactFam);
brainCorr.famdata=famCorr;
brainCorr.nonfamdata=nonfamCorr;
dataAll{3} = brainCorr;

%%
clear brainCorr;
brainCorr.name1 = 'L_FFA';
brainCorr.name2 = 'L_TMP';
[preCorr famCorr nonfamCorr] = getBrainCorrData(brainCorr.name1,brainCorr.name2);
orderEffectFam{4} = plotBarsForDifferentOrder(famCorr,'Lffa-LTPL-fam',outpath,[0 .25]);
orderEffectNFam{4} = plotBarsForDifferentOrder(nonfamCorr,'Lffa-LTPL-nfam',outpath,[0 .25]);

slopFamNfamDiff{4} = regressionSlopDiff(famCorr, nonfamCorr,pairMem.intactFam,pairMem.intactNFam)
slopFamDiff.PairMem{4} = regressionSlopDiff(famCorr, famCorr,pairMem.intactFam,pairMem.intactNFam);
slopFamDiff.FaceMem{4} = regressionSlopDiff(famCorr, famCorr,pairMem.intactFam,faceMem.totalFam);
slopFamDiff.HouseMem{4} = regressionSlopDiff(famCorr, famCorr,pairMem.intactFam,houseMem.totalFam);
contrEncCorr{4} = controllingForEncodingCorr(brainCorr,famCorrGrpLR,famCorr,pairMem.intactFam)

brainCorr.data = famCorr;
brainCorr.fameFlag = 'Fam';
cstatsFam{4} = plotBrainCorrWithAssociativeMemWithOrderSeparated(brainCorr,associMem);
brainCorr.fameFlag = 'Fam-NonFam';
plotBrainCorrWithAssociativeMemWithOrderSeparated(brainCorr,pairMem.intactNFam);

brainCorr.data = nonfamCorr;
brainCorr.fameFlag = 'NonFam';
cstatsNFam{4}=plotBrainCorrWithAssociativeMemWithOrderSeparated(brainCorr,pairMem.intactNFam);
brainCorr.fameFlag = 'NonFam-Fam';
plotBrainCorrWithAssociativeMemWithOrderSeparated(brainCorr,pairMem.intactFam);
brainCorr.famdata=famCorr;
brainCorr.nonfamdata=nonfamCorr;
dataAll{4} = brainCorr;

%%
clear brainCorr;
brainCorr.name1 = 'L_PPA';
brainCorr.name2 = 'R_TMP';
[preCorr famCorr nonfamCorr] = getBrainCorrData(brainCorr.name1,brainCorr.name2);
orderEffectFam{5} = plotBarsForDifferentOrder(famCorr,'Lppa-RTPL-fam',outpath,[0 .15]);
orderEffectNFam{5} = plotBarsForDifferentOrder(nonfamCorr,'Lppa-RTPL-nfam',outpath,[0 .15]);

slopFamNfamDiff{5} = regressionSlopDiff(famCorr, nonfamCorr,pairMem.intactFam,pairMem.intactNFam)
slopFamDiff.PairMem{5} = regressionSlopDiff(famCorr, famCorr,pairMem.intactFam,pairMem.intactNFam);
slopFamDiff.FaceMem{5} = regressionSlopDiff(famCorr, famCorr,pairMem.intactFam,faceMem.totalFam);
slopFamDiff.HouseMem{5} = regressionSlopDiff(famCorr, famCorr,pairMem.intactFam,houseMem.totalFam);
contrEncCorr{5} = controllingForEncodingCorr(brainCorr,famCorrGrpLR,famCorr,pairMem.intactFam)

brainCorr.data = famCorr;
brainCorr.fameFlag = 'Fam';
cstatsFam{5} = plotBrainCorrWithAssociativeMemWithOrderSeparated(brainCorr,associMem);
brainCorr.fameFlag = 'Fam-NonFam';
plotBrainCorrWithAssociativeMemWithOrderSeparated(brainCorr,pairMem.intactNFam);

brainCorr.data = nonfamCorr;
brainCorr.fameFlag = 'NonFam';
cstatsNFam{5}=plotBrainCorrWithAssociativeMemWithOrderSeparated(brainCorr,pairMem.intactNFam);
brainCorr.fameFlag = 'NonFam-Fam';
plotBrainCorrWithAssociativeMemWithOrderSeparated(brainCorr,pairMem.intactFam);
brainCorr.famdata=famCorr;
brainCorr.nonfamdata=nonfamCorr;
dataAll{5} = brainCorr;

%% 
clear brainCorr;
brainCorr.name1 = 'R_HPC';
brainCorr.name2 = 'L_PPA';
[preCorr famCorr nonfamCorr] = getBrainCorrData(brainCorr.name1,brainCorr.name2);
orderEffectFam{2} = plotBarsForDifferentOrder(famCorr,'RHPC-LPPA-fam',outpath,[-.05 .2]);
orderEffectNFam{2} = plotBarsForDifferentOrder(nonfamCorr,'RHPC-LPPA-nfam',outpath,[-.05 .2]);

slopFamNfamDiff{2} = regressionSlopDiff(famCorr, nonfamCorr,pairMem.intactFam,pairMem.intactNFam)
slopFamDiff.PairMem{2} = regressionSlopDiff(famCorr, famCorr,pairMem.intactFam,pairMem.intactNFam);
slopFamDiff.FaceMem{2} = regressionSlopDiff(famCorr, famCorr,pairMem.intactFam,faceMem.totalFam);
slopFamDiff.HouseMem{2} = regressionSlopDiff(famCorr, famCorr,pairMem.intactFam,houseMem.totalFam);
contrEncCorr{2} = controllingForEncodingCorr(brainCorr,famCorrGrpLR,famCorr,pairMem.intactFam)


brainCorr.data = famCorr;
brainCorr.fameFlag = 'Fam';
cstatsFam{2} = plotBrainCorrWithAssociativeMemWithOrderSeparated(brainCorr,associMem);
brainCorr.fameFlag = 'Fam-NonFam';
plotBrainCorrWithAssociativeMemWithOrderSeparated(brainCorr,pairMem.intactNFam);

brainCorr.data = nonfamCorr;
brainCorr.fameFlag = 'NonFam';
cstatsNFam{2}=plotBrainCorrWithAssociativeMemWithOrderSeparated(brainCorr,pairMem.intactNFam);
brainCorr.fameFlag = 'NonFam-Fam';
plotBrainCorrWithAssociativeMemWithOrderSeparated(brainCorr,pairMem.intactFam);
brainCorr.famdata=famCorr;
brainCorr.nonfamdata=nonfamCorr;
dataAll{2} = brainCorr;

%% 
clear brainCorr;
brainCorr.name1 = 'R_HPC';
brainCorr.name2 = 'R_PPA';
[preCorr famCorr nonfamCorr] = getBrainCorrData(brainCorr.name1,brainCorr.name2);
orderEffectFam{2} = plotBarsForDifferentOrder(famCorr,'RHPC-RPPA-fam',outpath,[-.05 .2]);
orderEffectNFam{2} = plotBarsForDifferentOrder(nonfamCorr,'RHPC-RPPA-nfam',outpath,[-.05 .2]);

slopFamNfamDiff{2} = regressionSlopDiff(famCorr, nonfamCorr,pairMem.intactFam,pairMem.intactNFam)
slopFamDiff.PairMem{2} = regressionSlopDiff(famCorr, famCorr,pairMem.intactFam,pairMem.intactNFam);
slopFamDiff.FaceMem{2} = regressionSlopDiff(famCorr, famCorr,pairMem.intactFam,faceMem.totalFam);
slopFamDiff.HouseMem{2} = regressionSlopDiff(famCorr, famCorr,pairMem.intactFam,houseMem.totalFam);
contrEncCorr{2} = controllingForEncodingCorr(brainCorr,famCorrGrpLR,famCorr,pairMem.intactFam)


brainCorr.data = famCorr;
brainCorr.fameFlag = 'Fam';
cstatsFam{2} = plotBrainCorrWithAssociativeMemWithOrderSeparated(brainCorr,associMem);
brainCorr.fameFlag = 'Fam-NonFam';
plotBrainCorrWithAssociativeMemWithOrderSeparated(brainCorr,pairMem.intactNFam);

brainCorr.data = nonfamCorr;
brainCorr.fameFlag = 'NonFam';
cstatsNFam{2}=plotBrainCorrWithAssociativeMemWithOrderSeparated(brainCorr,pairMem.intactNFam);
brainCorr.fameFlag = 'NonFam-Fam';
plotBrainCorrWithAssociativeMemWithOrderSeparated(brainCorr,pairMem.intactFam);
brainCorr.famdata=famCorr;
brainCorr.nonfamdata=nonfamCorr;
dataAll{2} = brainCorr;


function [tval pval pcomp statscomp]= controlEncodingCorrInPostCorrPrediction(brainCorr,pairMem)
[preCorr famCorr nonfamCorr] = getBrainCorrData(brainCorr.name1,brainCorr.name2);
[encodingCorrBeta] = getEncodingBrainCorrData(brainCorr.name1,brainCorr.name2);
[encodingCorr4run] = getEncodingBrainCorrData4runs(brainCorr.name1,brainCorr.name2);
% using beta series correlations
[a b ctemp]=glmfit([famCorr encodingCorrBeta(:,1)],pairMem.intactFam);
tval(:,1) = ctemp.t(2:3);
pval(:,1) = ctemp.p(2:3);

[a b ctemp]=glmfit([famCorr encodingCorrBeta(:,3)],pairMem.intactFam);
tval(:,2) = ctemp.t(2:3);
pval(:,2) = ctemp.p(2:3);

[a b ctemp]=glmfit([famCorr encodingCorrBeta(:,1)+encodingCorrBeta(:,3)],pairMem.intactFam);
tval(:,3) = ctemp.t(2:3);
pval(:,3) = ctemp.p(2:3);

[a b ctemp]=glmfit([famCorr mean(encodingCorrBeta,2)],pairMem.intactFam);
tval(:,4) = ctemp.t(2:3);
pval(:,4) = ctemp.p(2:3);

%using original time series correlations
[a b ctemp]=glmfit([famCorr encodingCorr4run(:,1)],pairMem.intactFam);
tval(:,5) = ctemp.t(2:3);
pval(:,5) = ctemp.p(2:3);

[a b ctemp]=glmfit([famCorr encodingCorr4run(:,2)],pairMem.intactFam);
tval(:,6) = ctemp.t(2:3);
pval(:,6) = ctemp.p(2:3);

[a b ctemp]=glmfit([famCorr mean(encodingCorr4run,2)],pairMem.intactFam);
tval(:,7) = ctemp.t(2:3);
pval(:,7) = ctemp.p(2:3);

[a b c d]=ttest(repmat(encodingCorr4run(:,1),[1,3]),[preCorr,famCorr nonfamCorr]);
pcomp(1,:) = b;
statscomp.fam1 = d;
[a b c d]=ttest(repmat(encodingCorr4run(:,2),[1,3]),[preCorr,famCorr nonfamCorr]);
pcomp(2,:) = b;
statscomp.fam2 = d;
[a b c d]=ttest(repmat(mean(encodingCorr4run,2),[1,3]),[preCorr,famCorr nonfamCorr]);
pcomp(3,:) = b;
statscomp.fam12 = d;






function [mValHPCL mValHPCR] = extractMeanConnUsingRex(maskFile)
sourceDir = 'D:\myStudy\picpairfMRI\postEncodingRest\conn_restingConnectivity\results\firstlevel\ANALYSIS_01\';
filePreHPCL = dir([sourceDir,'*Condition001_Source037.nii']);
filePreHPCR = dir([sourceDir,'*Condition001_Source038.nii']);
filePostFamHPCL = dir([sourceDir,'*Condition002_Source037.nii']);
filePostFamHPCR = dir([sourceDir,'*Condition002_Source038.nii']);
filePostNFamHPCL = dir([sourceDir,'*Condition003_Source037.nii']);
filePostNFamHPCR = dir([sourceDir,'*Condition003_Source038.nii']);
idshuf=[11 13:20,1:10 12]; %change the order of id to 1:20
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
mValHPCL=mValHPCL(idshuf,:);   
mValHPCR=mValHPCR(idshuf,:); 
                 
function [preCorr famCorr nonfamCorr] = getBrainCorrData(roiName1, roiName2)

load('D:\myStudy\picpairfMRI\postEncodingRest\conn_restingConnectivity\results\firstlevel\ANALYSIS_01\resultsROI_Condition001.mat');

ida = FdIndexCellstr(names,roiName1);

    if isempty(ida)
    error('wrong roi names ida');
end
idb = FdIndexCellstr(names2,roiName2);

if isempty(idb)
    error('wrong roi names idb');
end

preCorr=squeeze(Z(ida,idb,:));

load('D:\myStudy\picpairfMRI\postEncodingRest\conn_restingConnectivity\results\firstlevel\ANALYSIS_01\resultsROI_Condition002.mat');
famCorr=squeeze(Z(ida,idb,:));

load('D:\myStudy\picpairfMRI\postEncodingRest\conn_restingConnectivity\results\firstlevel\ANALYSIS_01\resultsROI_Condition003.mat');
nonfamCorr=squeeze(Z(ida,idb,:));

function [encodingCorr] = getEncodingBrainCorrData(roiName1, roiName2)
for i = 1:8
load(['G:\myStudy\picpairfMRI\encodingConnectivityConn_usingBetaSeries_withWMCSFRegressor\conn_eoncodingUsingBetaSeries\results\firstlevel\ANALYSIS_01\resultsROI_Condition00',num2str(i),'.mat']);

ida = FdIndexCellstr(names,roiName1);

    if isempty(ida)
    error('wrong roi names ida');
end
idb = FdIndexCellstr(names2,roiName2);

if isempty(idb)
    error('wrong roi names idb');
end

encodingCorr(:,i)=squeeze(Z(ida,idb,:));

end

function [encodingCorr] = getEncodingBrainCorrData4runs(roiName1, roiName2)
for i = 1:4
load(['G:\myStudy\picpairfMRI\encoding4run\encoding4run\results\firstlevel\ANALYSIS_01\resultsROI_Condition00',num2str(i),'.mat']);

ida = FdIndexCellstr(names,roiName1);

    if isempty(ida)
    error('wrong roi names ida');
end
idb = FdIndexCellstr(names2,roiName2);

if isempty(idb)
    error('wrong roi names idb');
end

encodingCorr(:,i)=squeeze(Z(ida,idb,:));

end

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
outpath = 'D:\myStudy\picpairfMRI\Documents\picpair\PicparBehavioralmanuscript\PhDDissertation\figurefordefensepresentation\';

export_fig([outpath brainCorr.name1,'-',brainCorr.name2, ' correlation',brainCorr.fameFlag],'-pdf');

function cstats = plotBrainCorrWithAssociativeMemWithOrderSeparated(brainCorr,associMem)
s=figure;
fsize=8;
% scatter(brainCorr.data,associMem,10,'ok','filled')
% ll=lsline;
% set(ll,'LineWidth',1.3,'Color','k');
% hold on;

x = replaceOutliers(brainCorr.data,2.5,2);
y = replaceOutliers(associMem,2.5,2);

scatter(x(1:2:length(x)),y(1:2:length(y)),10,'og','filled');
hold on;

scatter(x(2:2:length(x)),y(2:2:length(y)),10,'or','filled');

scatter(x,y,10,'ok')
l1=lsline;
set(l1(1),'LineWidth',1.5,'Color','k','LineStyle','-');
set(l1(2),'LineWidth',1,'Color','r','LineStyle',':');
set(l1(3),'LineWidth',1,'Color','g','LineStyle',':');

% [B,BINT,R,RINT,STATS] = regress(y,[ones(length(x),1),x]);
% t=sqrt(STATS(2));
% p=STATS(3);
dumx=ones(length(x),1);
dumx(1:2:length(x))=-1;
xinter=dumx.*zscore(x);
[a b cstats]=glmfit([x,dumx,xinter],y);
title(['regt= ',num2str(cstats.t(4)),' regp= ',num2str(cstats.p(4))]);
xlabel([brainCorr.name1,'-',brainCorr.name2, ' correlation']);
ylabel('Associative memory');
set(gca,'fontsize',fsize);
box off;
set(gcf, 'Color', 'w');
setfigsize(s,8,'Helvetica',8,'Helvetica',6.5,4.5);
% xlim([min(x)-.05 max(x)+.05]);
xlim([-.2 .61]);
ylim([min(y)-.05 max(y)+.05]);
outpath = 'C:\Users\Zhongxu\OneDrive\Documents\picpair\PicparBehavioralmanuscript\PhDDissertation\figurefordefensepresentation\';
outpath = 'D:\myStudy\picpairfMRI\Documents\picpair\PicparBehavioralmanuscript\PhDDissertation\figurefordefensepresentation\';

export_fig([outpath ' OrderEff ', brainCorr.name1,'-',brainCorr.name2, ' correlation',brainCorr.fameFlag],'-pdf');



function plotBrainCorrWith2AssociativeMems(brainCorr,associMem1, associMem2,memType)
s=figure;
fsize=8;
% scatter(brainCorr.data,associMem,10,'ok','filled')
% ll=lsline;
% set(ll,'LineWidth',1.3,'Color','k');
% hold on;

x1 = replaceOutliers(brainCorr.data,2.5,2);
if isfield(brainCorr,'data2')
    x2=replaceOutliers(brainCorr.data2,2.5,2);
else
    x2=x1;
end

y1 = replaceOutliers(associMem1,2.5,2);
y2 = replaceOutliers(associMem2,2.5,2);
scatter(x1,y1,10,'or','filled');
l1=lsline;
set(l1,'LineWidth',1.3,'Color','r','LineStyle','-');
hold on;
scatter(x2,y2,10,'ob','filled');
l2=lsline;
set(l2,'LineWidth',1.3,'Color','b','LineStyle','-');

[B,BINT,R,RINT,STATS] = regress(y1,[ones(length(x1),1),x1]);
t1=sqrt(STATS(2));
p1=STATS(3);

[B,BINT,R,RINT,STATS] = regress(y2,[ones(length(x2),1),x2]);
t2=sqrt(STATS(2));
p2=STATS(3);
title(['regt= ',num2str(t1),num2str(t2),'regp= ',num2str(p1),num2str(p2)]);
xlabel([brainCorr.name1,'-',brainCorr.name2, ' correlation']);
ylabel('Associative memory');
set(gca,'fontsize',fsize);
box off;
set(gcf, 'Color', 'w');
setfigsize(s,8,'Helvetica',8,'Helvetica',6.5,4.5);
% xlim([min(x)-.05 max(x)+.05]);
xlim([min([x1;x2])-.05 max([x1;x2])+.05]);
ylim([min([y1;y2])-.05 max([y1;y2])+.05]);
outpath = 'C:\Users\Zhongxu\Dropbox\picpair\PicparBehavioralmanuscript\postEncodingfMRIPub\figures\';
outpath = 'D:\myStudy\picpairfMRI\Documents\picpair\PicparBehavioralmanuscript\PhDDissertation\figurefordefensepresentation\';

export_fig([outpath brainCorr.name1,'-',brainCorr.name2, ' correlation',brainCorr.fameFlag,memType,'2mems'],'-pdf');


function plot3BrainCorrWithOnePredictor(brainCorr,x,xName)
s=figure;
fsize=8;
% scatter(brainCorr.data,associMem,10,'ok','filled')
% ll=lsline;
% set(ll,'LineWidth',1.3,'Color','k');
% hold on;

% y1 = replaceOutliers(brainCorr.preCorr,2.5,2);
% y2 = replaceOutliers(brainCorr.famCorr,2.5,2);
% y3 = replaceOutliers(brainCorr.nonfamCorr,2.5,2);

y1 = brainCorr.preCorr;
y2 = brainCorr.famCorr;
y3 = brainCorr.nonfamCorr;

if size(x,2)==1
    x1=x;
    x2=x;
    x3=x;
elseif size(x,2)==3
    x1=x(:,1);
    x2=x(:,2);
    x3=x(:,3);
end


scatter(x1,y1,10,'vk');
l1=lsline;
set(l1,'LineWidth',1.3,'Color','k','LineStyle','-');
hold on;
scatter(x2,y2,10,'or','filled');
l2=lsline;
set(l2,'LineWidth',1.3,'Color','r','LineStyle','-');
scatter(x3,y3,10,'sg','filled');
l3=lsline;
set(l3,'LineWidth',1.3,'Color','g','LineStyle','-');


[B,BINT,R,RINT,STATS] = regress(y1,[ones(length(x1),1),x1]);
t1=sqrt(STATS(2));
p1=STATS(3);

[B,BINT,R,RINT,STATS] = regress(y2,[ones(length(x2),1),x2]);
t2=sqrt(STATS(2));
p2=STATS(3);

[B,BINT,R,RINT,STATS] = regress(y3,[ones(length(x3),1),x3]);
t3=sqrt(STATS(2));
p3=STATS(3);

title(['regt= ',num2str(roundoff(t1,4)),';',num2str(roundoff(t2,4)),';',num2str(roundoff(t3,4)),...
    'regp= ',num2str(roundoff(p1,4)),';',num2str(roundoff(p2,4)),';',num2str(roundoff(p3,4))],...
    'fontsize',5);
ylabel([brainCorr.name1,'-',brainCorr.name2, ' correlation']);
xlabel(xName);
set(gca,'fontsize',fsize);
box off;
set(gcf, 'Color', 'w');
setfigsize(s,8,'Helvetica',8,'Helvetica',5,4);
% xlim([min(x)-.05 max(x)+.05]);
xlim([min([x1;x2;x3])-.05 max([x1;x2;x3])+.05]);
ylim([min([y1;y2;y3])-.05 max([y1;y2;y3])+.05]);
outpath = 'C:\Users\Zhongxu\Dropbox\picpair\PicparBehavioralmanuscript\postEncodingfMRIPub\figures\';
outpath = 'D:\myStudy\picpairfMRI\Documents\picpair\PicparBehavioralmanuscript\PhDDissertation\figurefordefensepresentation\';
export_fig([outpath brainCorr.name1,'-',brainCorr.name2,'with',xName],'-pdf');



function stat = plot3bars(preCorr,famCorr,nonfamCorr,connLabel,outpath)
s = figure; 
fsize=7;
ss = bar(mean([preCorr, famCorr,nonfamCorr],1),.5,'k');
hold on;
errorbar(mean([preCorr, famCorr,nonfamCorr],1),std([preCorr, famCorr,nonfamCorr],1)/sqrt(20),'k');
[a b c d]=ttest(famCorr,nonfamCorr);
stat.p(1)=b;
stat.t(1)=d.tstat;
[a b c d]=ttest(famCorr,preCorr);
stat.p(2)=b;
stat.t(2)=d.tstat;
[a b c d]=ttest(nonfamCorr,preCorr);
stat.p(3)=b;
stat.t(3)=d.tstat;
 
[a b c d]=ttest(preCorr,0);
stat.po(1)=b;
stat.to(1)=d.tstat;

[a b c d]=ttest(famCorr,0);
stat.po(2)=b;
stat.to(2)=d.tstat;

[a b c d]=ttest(nonfamCorr,0);
stat.po(3)=b;
stat.to(3)=d.tstat;

ylabel('Connectivity'); 
set(gca,'fontsize',fsize);
box off;
set(gcf, 'Color', 'w');
setfigsize(s,7,'Helvetica',7,'Helvetica',1.5,2.5);
%  set(gca,'YLim',[0 max(mean([preCorr, famCorr,nonfamCorr]))+ max(std([preCorr, famCorr,nonfamCorr]))]);
% set(gca, 'XTickLabel', {'Pre-encoding','Post-famous','Post-nonfamous'});
export_fig([outpath,connLabel, '3bars'],'-pdf');
% plot2svg([outpath 'lFFAvsRHPC-3bar_withdatapoint.svg'],s);


function stat = plotBarsForDifferentOrder(famCorr,connLabel,outpath,ylimvalue)
s = figure; 
fsize=7;
famCorr=replaceOutliers(famCorr,2.5,2);
ss = bar(mean([famCorr(1:2:20), famCorr(2:2:20)],1),.5,'k');
hold on;
errorbar(mean([famCorr(1:2:20), famCorr(2:2:20)],1),...
    std([famCorr(1:2:20), famCorr(2:2:20)],1)/sqrt(20),'k');

[a b c d]=ttest(famCorr(1:2:20),famCorr(2:2:20));
stat.p(1)=b;
stat.t(1)=d.tstat;
title(['t= ',num2str(stat.t),' p= ',num2str(stat.p)]);
ylabel('Connectivity'); 
ylim(ylimvalue);
set(gca,'fontsize',fsize);
box off;
set(gcf, 'Color', 'w');
ylim([0 .5]);
setfigsize(s,7,'Helvetica',7,'Helvetica',5,5);
%  set(gca,'YLim',[0 max(mean([preCorr, famCorr,nonfamCorr]))+ max(std([preCorr, famCorr,nonfamCorr]))]);
% set(gca, 'XTickLabel', {'Pre-encoding','Post-famous','Post-nonfamous'});
export_fig([outpath,' OrderEff ', connLabel, 'for2Orders'],'-pdf');


function c = controllingForEncodingCorr(brainCorr,famCorrGrpLR,famCorr,memVal)
for i = 1:size(famCorrGrpLR,3)
    famCorrGrpLR(:,:,i) = famCorrGrpLR(:,:,i)+famCorrGrpLR(:,:,i)';
end

roiName{1}= 'L_FFA';
roiName{2}= 'L_PPA';
roiName{3}= 'L_HPC';
roiName{4}= 'L_vmP';
roiName{5}= 'L_TMP';
roiName{6}= 'R_FFA';
roiName{7}= 'R_PPA';
roiName{8}= 'R_HPC';
roiName{9}= 'R_vmP';
roiName{10}= 'R_TMP';
id1 = find(strcmp(roiName,brainCorr.name1)==1);
id2 = find(strcmp(roiName,brainCorr.name2)==1);
encCorr = squeeze(famCorrGrpLR(id2,id1,:));
[a b c]=glmfit([encCorr,famCorr],memVal);

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
% load('D:\myStudy\picpairfMRI\postEncodingRest\conn_restingConnectivity\results\firstlevel\ANALYSIS_01\resultsROI_Condition002.mat');
% names{ida(i)}
% names2{idb(j)}
% famCorr=squeeze(Z(ida(i),idb(j),:));
% load('D:\myStudy\picpairfMRI\postEncodingRest\conn_restingConnectivity\results\firstlevel\ANALYSIS_01\resultsROI_Condition003.mat');
% nonfamCorr=squeeze(Z(ida(i),idb(j),:));
% 
% load('D:\myStudy\picpairfMRI\postEncodingRest\conn_restingConnectivity\results\firstlevel\ANALYSIS_01\resultsROI_Condition001.mat');
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
% load('D:\myStudy\picpairfMRI\postEncodingRest\conn_restingConnectivity\results\firstlevel\ANALYSIS_01\resultsROI_Condition002.mat');
% names{ida(i)}
% names2{idb(j)}
% famCorr=squeeze(Z(ida(i),idb(j),:));
% load('D:\myStudy\picpairfMRI\postEncodingRest\conn_restingConnectivity\results\firstlevel\ANALYSIS_01\resultsROI_Condition003.mat');
% nonfamCorr=squeeze(Z(ida(i),idb(j),:));
% 
% load('D:\myStudy\picpairfMRI\postEncodingRest\conn_restingConnectivity\results\firstlevel\ANALYSIS_01\resultsROI_Condition001.mat');
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
% load('D:\myStudy\picpairfMRI\postEncodingRest\conn_restingConnectivity\results\firstlevel\ANALYSIS_01\resultsROI_Condition002.mat');
% names{ida(i)}
% names2{idb(j)}
% famCorr=squeeze(Z(ida(i),idb(j),:));
% load('D:\myStudy\picpairfMRI\postEncodingRest\conn_restingConnectivity\results\firstlevel\ANALYSIS_01\resultsROI_Condition003.mat');
% nonfamCorr=squeeze(Z(ida(i),idb(j),:));
% 
% load('D:\myStudy\picpairfMRI\postEncodingRest\conn_restingConnectivity\results\firstlevel\ANALYSIS_01\resultsROI_Condition001.mat');
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
