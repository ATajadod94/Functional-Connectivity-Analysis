function [p t famCorrGrpLR nonfamCorrGrpLR] = ...
    EncodingCorrUsingOriginalData5ROIs(subjID,dataName,isHemiLR,isControlCov,filterBand,isDeletScramble)
if nargin <6
    filterBand=[];
    isDeletScramble=0;
end
projDir = 'D:\myStudy\picpairfMRI\';
figOutPath = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\EncodingCorr_5ROI_originalData_defense\';
if isControlCov==1
    figOutPath = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\EncodingCorr_ControlCov_5ROI_originalData_defense\';
end

if ~exist(figOutPath,'dir')
    mkdir(figOutPath)
end

includePilots =0;
FisherTrans =1;
isDetrend =isControlCov;
isCovaryMotion =isControlCov;
isCovaryWMCSF=isControlCov;



numTR=287;

for i =1: length(subjID)
    subjDir{i} = [projDir,'s', sprintf('%03d',i),'\encoding\'];
end

% if includePilots ==1
%     subjDir{length(subjID)+1} = [projDir,'pilot001\encoding\'];
%     subjDir{length(subjID)+2} = [projDir,'pilot002\encoding\'];
% end

for i = 1:length(subjDir)
    load([subjDir{i},dataName]);
    motionDataDir = [subjDir{i},'taskRunsConcatenate\'];
    [fam1CorrGrpL(:,:,i),fam1CorrGrpR(:,:,i),fam1CorrGrpLR(:,:,i)] = ...
        computeCorr(fam1,FisherTrans, isDetrend,numTR,filterBand, isCovaryMotion,motionDataDir,1,isDeletScramble);
    
    [fam2CorrGrpL(:,:,i),fam2CorrGrpR(:,:,i),fam2CorrGrpLR(:,:,i)] = ...
        computeCorr(fam2,FisherTrans, isDetrend,numTR,filterBand, isCovaryMotion,motionDataDir,2,isDeletScramble);
    
    [nonfam1CorrGrpL(:,:,i),nonfam1CorrGrpR(:,:,i),nonfam1CorrGrpLR(:,:,i)] = ...
        computeCorr(nonfam1,FisherTrans, isDetrend,numTR,filterBand, isCovaryMotion,motionDataDir,3,isDeletScramble);
    
    [nonfam2CorrGrpL(:,:,i),nonfam2CorrGrpR(:,:,i),nonfam2CorrGrpLR(:,:,i)] = ...
        computeCorr(nonfam2,FisherTrans, isDetrend,numTR,filterBand, isCovaryMotion,motionDataDir,4,isDeletScramble);
    
end

famCorrGrpL=.5*(fam1CorrGrpL + fam2CorrGrpL);
nonfamCorrGrpL=.5*(nonfam1CorrGrpL + nonfam2CorrGrpL);

famCorrGrpR=.5*(fam1CorrGrpR + fam2CorrGrpR);
nonfamCorrGrpR=.5*(nonfam1CorrGrpR + nonfam2CorrGrpR);

famCorrGrpLR=.5*(fam1CorrGrpLR + fam2CorrGrpLR);
nonfamCorrGrpLR=.5*(nonfam1CorrGrpLR + nonfam2CorrGrpLR);

if FisherTrans == 1
    colorLim = [-1 1];
else
    colorLim = [-1 1];
end
% labelR = {'R_FFA','R_PPA','R_HPC','R_vmP','R_TPL','R_Cdt'};
% labelL = {'L_FFA','L_PPA','L_HPC','L_vmP','L_TPL','L_Cdt'};

if isHemiLR ==0
famCorrGrpLR = .5* (famCorrGrpL + famCorrGrpR);
nonfamCorrGrpLR = .5* (nonfamCorrGrpL + nonfamCorrGrpR);

labelLR = {'FFA','PPA','HPC','vmP','TPL'};
hemiSide ='LRM';

elseif isHemiLR ==1 % L
famCorrGrpLR = famCorrGrpL;
nonfamCorrGrpLR = nonfamCorrGrpL ;
labelLR = {'L-FFA','PPA','HPC','vmP','TPL'};
hemiSide ='L';

elseif isHemiLR ==2 %r  
famCorrGrpLR = famCorrGrpR;
nonfamCorrGrpLR = nonfamCorrGrpR ;
labelLR = {'R-FFA','PPA','HPC','vmP','TPL'};
hemiSide ='R';

elseif isHemiLR==3 %both L R hemispheres
famCorrGrpLR = famCorrGrpLR;
nonfamCorrGrpLR = nonfamCorrGrpLR;
  
labelLR = {'L-FFA','L-PPA','L-HPC','L-vmP','L-TPL',...
           'R-FFA','R-PPA','R-HPC','R-vmP','R-TPL'}; 
hemiSide ='L-R';
end
    
Fam_NonFamLR = famCorrGrpLR - nonfamCorrGrpLR;

nRoi = length(labelLR);
%ttest
famCorrGrpLR(find(famCorrGrpLR==inf))=0;
nonfamCorrGrpLR(find(nonfamCorrGrpLR==inf))=0;


% %average brain correlation
% for i = 1:length(subjID)
%     nonfamCorrMLR(i) = mean(mean(tril(nonfamCorrGrpLR(:,:,i))));
%     postNonFamCorrMLR(i) = mean(mean(tril(postNonFamCorrGrpLR(:,:,i))));
% end
% [a pcorrM] = ttest(nonfamCorrMLR,  postNonFamCorrMLR);

for i = 1:nRoi
    for j = 1:nRoi
        [a p(i,j) ci stats]=ttest(famCorrGrpLR(i,j,:),nonfamCorrGrpLR(i,j,:));
        tval(i,j) = stats.tstat;
        df(i,j) = stats.df;
    end
end

%change p from two tailed to one tailed

ts = tval(~isnan(tval));
p_1 = 1-tcdf(ts,df(~isnan(tval)));
pOneTail = p;
pOneTail(~isnan(tval))=p_1;

%false detection control .05 and .1
pFdr_05 = pOneTail;
tFdr_05 = tval;
pNoCorrection = pOneTail;
tNoCorrection = tval;
pFdrTrend = pOneTail;
tFdrTrend = tval;
id =find(~isnan(pOneTail));
q = conn_fdr(pOneTail(~isnan(pOneTail)));
% .05 level fdr
idfdr = find(q>.0501);
pFdr_05(id(idfdr)) = nan;
tFdr_05(id(idfdr)) = 0; 
% trend level fdr
idfdr = find(q>.1);
pFdrTrend(id(idfdr)) = nan;
tFdrTrend(id(idfdr)) = 0; 


% no correction .05
q = pOneTail(~isnan(pOneTail));
idNoFdr = find(q>.05);
pNoCorrection(id(idNoFdr)) = nan;
tNoCorrection(id(idNoFdr)) = 0;

p.p = p;
p.oneTail = pOneTail;
p.fdr_05 = pFdr_05;
p.fdrTrend = pFdrTrend;
p.noCorrection_05=pNoCorrection;

t.t = tval;
t.df = df;
t.fdr_05=tFdr_05;
t.fdrTrend = tFdrTrend;
t.noCorrection_05=tNoCorrection;

save([figOutPath,'P_V_Correlations_',hemiSide,'.mat'],...
    'p','t','famCorrGrpLR', 'nonfamCorrGrpLR');

%plot
axisFontSize = 8;
figAxisFont  = 'Helvetica';
textFontSize = 8;
figTextFont  = 'Helvetica';
figWidth = 16;
figHight = 10;

s=figure;
figTitle = {['Fam - Nonfam correlations',hemiSide]};
setfigsize(s,axisFontSize,figAxisFont,textFontSize,figTextFont,figWidth,figHight);
colormap(jet);
imagesc(mean(Fam_NonFamLR,3));
caxis([-.35 .35]);
title(figTitle);
set(gca,'XTick',[1 : nRoi],'YTick',[1 : nRoi]);
set(gca,'XTickLabel',labelLR,'YTickLabel',labelLR);
set(gcf,'color','w');
colorbar;
export_fig([figOutPath,'Fam-Nonfam_',hemiSide],'-tiff','-r300');
% plot2svg([figOutPath,'PostFam_NonFam_',hemiSide,'.svg'],s);


%left side
% subplot(1,3,1)
s =figure;
figTitle = {'Fam'};
colormap(jet);
imagesc(mean(famCorrGrpLR,3));
caxis(colorLim);
set(gca,'XTick',[1 : nRoi],'YTick',[1 : nRoi]);
set(gca,'XTickLabel',labelLR,'YTickLabel',labelLR);
set(gcf,'color','w');
colorbar;
title(figTitle);
setfigsize(s,axisFontSize,figAxisFont,textFontSize,figTextFont,figWidth,figHight);
if isHemiLR ==3
hold on;
plotAFrame(nRoi/2);
end
% plot2svg([figOutPath,'fam_',hemiSide,'.svg'],s);
export_fig([figOutPath,'fam_',hemiSide],'-tiff','-r300');

s=figure;
setfigsize(s,axisFontSize,figAxisFont,textFontSize,figTextFont,figWidth,figHight);
% subplot(1,3,2)
colormap(jet);
imagesc(mean(nonfamCorrGrpLR,3));
caxis(colorLim);
title('NonFam');
set(gca,'XTick',[1 : nRoi],'YTick',[1 : nRoi]);
set(gca,'XTickLabel',labelLR,'YTickLabel',labelLR);
set(gcf,'color','w');
colorbar;
if isHemiLR ==3
hold on;
plotAFrame(nRoi/2);
end
export_fig([figOutPath,'nonfam_',hemiSide],'-tiff','-r300');


% s=figure;
% % subplot(1,3,3)
% setfigsize(s,axisFontSize,figAxisFont,textFontSize,figTextFont,figWidth,figHight);
% colormap(jet);
% imagesc(mean(postNonFamCorrGrpLR,3));
% caxis(colorLim);
% title('Post-nonfamous rest');
% set(gca,'XTick',[1 : nRoi],'YTick',[1 : nRoi]);
% set(gca,'XTickLabel',labelLR,'YTickLabel',labelLR);
% set(gcf,'color','w');
% colorbar;
% if isHemiLR ==3
% hold on;
% plotAFrame(nRoi/2);
% end
% plot2svg([figOutPath,'PostNonFam_',hemiSide,'.svg'],s);
% export_fig([figOutPath,'postNonFam_',hemiSide],'-tiff','-r300');


s=figure;
% subplot(1,3,3)
setfigsize(s,axisFontSize,figAxisFont,textFontSize,figTextFont,figWidth,figHight);
colormap(jet);
imagesc(tFdr_05);
caxis([-5 5]);
title('fam-nonfam diff t value');
set(gca,'XTick',[1 : nRoi],'YTick',[1 : nRoi]);
set(gca,'XTickLabel',labelLR,'YTickLabel',labelLR);
set(gcf,'color','w');
colorbar;
if isHemiLR ==3
hold on;
plotAFrame(nRoi/2);
end
% plot2svg([figOutPath,'PostFam_NonFam_diff_TvalFdr05_',hemiSide,'.svg'],s);
export_fig([figOutPath,'fam-nonfam_diff_TvalFdr05_',hemiSide],'-tiff','-r300');

% 
% s=figure;
% % subplot(1,3,3)
% setfigsize(s,axisFontSize,figAxisFont,textFontSize,figTextFont,figWidth,figHight);
% colormap(jet);
% imagesc(tFdrTrend);
% caxis([-5 5]);
% title('PostNonfamous-Baseline diff t value');
% set(gca,'XTick',[1 : nRoi],'YTick',[1 : nRoi]);
% set(gca,'XTickLabel',labelLR,'YTickLabel',labelLR);
% set(gcf,'color','w');
% colorbar;
% if isHemiLR ==3
% hold on;
% plotAFrame(nRoi/2);
% end
% % plot2svg([figOutPath,'PostFam_NonFam_diff_TvalFdr05Trend_',hemiSide,'.svg'],s);
% export_fig([figOutPath,'PostNonFam_Baseline_diff_TvalFdr05Trend_',hemiSide],'-tiff','-r300');
% 
% 

s=figure;
% subplot(1,3,3)
setfigsize(s,axisFontSize,figAxisFont,textFontSize,figTextFont,figWidth,figHight);
colormap(jet);
imagesc(tNoCorrection);
caxis([-5 5]);
title('fam-nonfam diff t value');
set(gca,'XTick',[1 : nRoi],'YTick',[1 : nRoi]);
set(gca,'XTickLabel',labelLR,'YTickLabel',labelLR);
set(gcf,'color','w');
colorbar;
if isHemiLR ==3
hold on;
plotAFrame(nRoi/2);
end
% plot2svg([figOutPath,'PostFam_NonFam_diff_TvalNoCrect_',hemiSide,'.svg'],s);
export_fig([figOutPath,'fam-nonfam_diff_TvalNoCrect_',hemiSide],'-tiff','-r300');

close all;

%*************************************************************************
function [corrL, corrR, corrLR]= computeCorr(data,FisherTrans, isDetrend,numTR,filterBand, isCovaryMotion,motionDataDir,runNum,isDeletScramble)

dataL(:,1)= data.L_FFA;
dataL(:,2)= data.L_PPA;
dataL(:,3)= data.L_HPC;
dataL(:,4)= data.L_vmP;
dataL(:,5)= data.L_TPL;
% dataL(:,6)= data.L_Cdt;

dataR(:,1)= data.R_FFA;
dataR(:,2)= data.R_PPA;
dataR(:,3)= data.R_HPC;
dataR(:,4)= data.R_vmP;
dataR(:,5)= data.R_TPL;
% dataR(:,6)= data.R_Cdt;


%detrend the data
if isDetrend ==1
    dataR = detrend(dataR);
    dataL = detrend(dataL);
end

if ~isempty(filterBand);
    %using eeglab function eegfilt to filt the data
    dataR = eegfilt(dataR',1/2,filterBand(1),filterBand(2),size(dataR,1),40);
    dataL = eegfilt(dataL',1/2,filterBand(1),filterBand(2),size(dataL,1),40);
    dataR=dataR';
    dataL=dataL';
end

if isCovaryMotion ==1
    a = textread([motionDataDir,'motionParameter.txt']);
    dataX = a(1+(runNum-1)*numTR:runNum*numTR,1:6);
    dataR =  regressOutCovriate(dataR, dataX);
    dataL =  regressOutCovriate(dataL, dataX);
end

% if isCovaryWMCSF ==1
%     dataX(:,1)= WMCSFData.WM;
%     dataX(:,2)= WMCSFData.CSF;
%     dataR =  regressOutCovriate(dataR, dataX);
%     dataL =  regressOutCovriate(dataL, dataX);
% end
if isDeletScramble==1
    trPics = getPicPairTrsForEncodingBrainCorrelations;
data.L_FFA= data.L_FFA(trPics);
data.L_PPA= data.L_PPA(trPics);
data.L_HPC= data.L_HPC(trPics);
data.L_vmP= data.L_vmP(trPics);
data.L_TPL= data.L_TPL(trPics);
% dataL(:,6)= data.L_Cdt(trPics);

data.R_FFA= data.R_FFA(trPics);
data.R_PPA= data.R_PPA(trPics);
data.R_HPC= data.R_HPC(trPics);
data.R_vmP= data.R_vmP(trPics);
data.R_TPL= data.R_TPL(trPics);   
end
corrL = tril(corr(dataL));% left side corr
corrR = tril(corr(dataR)); %Right side corr
corrLR = tril(corr([dataL dataR]));% left and right corr

if FisherTrans == 1
    corrL = 0.5 * log((1 +corrL)./(1- corrL));
    corrR = 0.5 * log((1 +corrR)./(1- corrR));
    corrLR = 0.5 * log((1 +corrLR)./(1- corrLR));
end

%%%%%% regress out covariates
function dataOut = regressOutCovriate(dataY, dataX)
nVar = size(dataY,2);
for i = 1 : nVar
    [B,BINT,R] = regress(dataY(:,i),[ones(size(dataY,1),1) dataX]);
    dataOut(:,i) = R;
end

function plotAFrame(halfRowNum)
x0 = halfRowNum+.5;
y0 = halfRowNum+.5;
xyend = halfRowNum*2 + .5;
plot([x0 y0], [xyend y0],'k','LineWidth',2);
% plot([5.5 5.5], [0.5 5.5],'k','LineWidth',2);
plot([x0 0.5], [x0 y0],'k','LineWidth',2);
% plot([5.5 10.5], [5.5 5.5],'k','LineWidth',2);

plot([5.5 0.5], [10.5 5.5],':k','LineWidth',2);