function [p t baselineCorrGrpLR postFamCorrGrpLR postNonFamCorrGrpLR] = ...
    prepostEncodingCorr(subjID,isHemiLR,isControlCov,filterBand)
if nargin <4
    filterBand=[];
end
projDir = 'D:\myStudy\picpairfMRI\';
figOutPath = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\postFam_NonFam_EncodingCorr_5ROI_defense\';
if isControlCov==1
    figOutPath = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\postFam_NonFam_EncodingCorr_ControlCov_5ROI_defense\';
end

if ~exist(figOutPath,'dir')
    mkdir(figOutPath)
end

includePilots =0;
FisherTrans =1;
isDetrend =isControlCov;
isCovaryMotion =isControlCov;
isCovaryWMCSF=isControlCov;




numTR=180;

for i =1: length(subjID)
    subjDir{i} = [projDir,'s', sprintf('%03d',i),'\prepostEncoding\'];
end

if includePilots ==1
    subjDir{length(subjID)+1} = [projDir,'pilot001\prepostEncoding\'];
    subjDir{length(subjID)+2} = [projDir,'pilot002\prepostEncoding\'];
end

for i = 1:length(subjDir)
    load([subjDir{i},'restTimeS.mat']);
    a = load([subjDir{i},'restTimeS_WM_CSF.mat'],'baseline');
    baselineWMCSF=a.baseline;
    [baselineCorrGrpL(:,:,i),baselineCorrGrpR(:,:,i),baselineCorrGrpLR(:,:,i)] = ...
        computeCorr(baseline,FisherTrans, isDetrend, isCovaryMotion,...
        [subjDir{i},'preBaseline\'],isCovaryWMCSF,baselineWMCSF,numTR,filterBand);
    
    b= load([subjDir{i},'restTimeS_WM_CSF.mat'],'postFam');
    postFamWMCSF = b.postFam;
    [postFamCorrGrpL(:,:,i),postFamCorrGrpR(:,:,i),postFamCorrGrpLR(:,:,i)] = ...
        computeCorr(postFam,FisherTrans, isDetrend, isCovaryMotion,...
        [subjDir{i},'postFam\'], isCovaryWMCSF, postFamWMCSF, numTR,filterBand);    
    
    
    c = load([subjDir{i},'restTimeS_WM_CSF.mat'],'postNonFam');
    postNonFamWMCSF = c.postNonFam;
    [postNonFamCorrGrpL(:,:,i),postNonFamCorrGrpR(:,:,i),postNonFamCorrGrpLR(:,:,i)] = ...
        computeCorr(postNonFam,FisherTrans, isDetrend, isCovaryMotion,...
        [subjDir{i},'postNonFam\'],isCovaryWMCSF, postNonFamWMCSF, numTR,filterBand);
end

if FisherTrans == 1
    colorLim = [-1 1];
else
    colorLim = [-1 1];
end
% labelR = {'R_FFA','R_PPA','R_HPC','R_vmP','R_TPL','R_Cdt'};
% labelL = {'L_FFA','L_PPA','L_HPC','L_vmP','L_TPL','L_Cdt'};

if isHemiLR ==0
baselineCorrGrpLR = .5* (baselineCorrGrpL + baselineCorrGrpR);
postFamCorrGrpLR = .5* (postFamCorrGrpL + postFamCorrGrpR);
postNonFamCorrGrpLR = .5* (postNonFamCorrGrpL + postNonFamCorrGrpR);
labelLR = {'FFA','PPA','HPC','vmP','TPL'};
hemiSide ='LRM';

elseif isHemiLR ==1 % L
baselineCorrGrpLR = baselineCorrGrpL;
postFamCorrGrpLR = postFamCorrGrpL ;
postNonFamCorrGrpLR =postNonFamCorrGrpL;  
labelLR = {'L-FFA','PPA','HPC','vmP','TPL'};
hemiSide ='L';

elseif isHemiLR ==2 %r  
baselineCorrGrpLR = baselineCorrGrpR;
postFamCorrGrpLR = postFamCorrGrpR ;
postNonFamCorrGrpLR =postNonFamCorrGrpR; 
labelLR = {'R-FFA','PPA','HPC','vmP','TPL'};
hemiSide ='R';

elseif isHemiLR==3 %both L R hemispheres
baselineCorrGrpLR = baselineCorrGrpLR;
postFamCorrGrpLR = postFamCorrGrpLR;
postNonFamCorrGrpLR = postNonFamCorrGrpLR;   
labelLR = {'L-FFA','L-PPA','L-HPC','L-vmP','L-TPL',...
           'R-FFA','R-PPA','R-HPC','R-vmP','R-TPL'}; 
hemiSide ='L-R';
end
    
postFam_NonFamLR = postFamCorrGrpLR - postNonFamCorrGrpLR;

nRoi = length(labelLR);
%ttest
baselineCorrGrpLR(find(baselineCorrGrpLR==inf))=0;
postFamCorrGrpLR(find(postFamCorrGrpLR==inf))=0;
postNonFamCorrGrpLR(find(postNonFamCorrGrpLR==inf))=0;

% %average brain correlation
% for i = 1:length(subjID)
%     postFamCorrMLR(i) = mean(mean(tril(postFamCorrGrpLR(:,:,i))));
%     postNonFamCorrMLR(i) = mean(mean(tril(postNonFamCorrGrpLR(:,:,i))));
% end
% [a pcorrM] = ttest(postFamCorrMLR,  postNonFamCorrMLR);

for i = 1:nRoi
    for j = 1:nRoi
        [a p(i,j) ci stats]=ttest(postFamCorrGrpLR(i,j,:),postNonFamCorrGrpLR(i,j,:));
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
    'p','t','baselineCorrGrpLR', 'postFamCorrGrpLR', 'postNonFamCorrGrpLR');

%plot
axisFontSize = 8;
figAxisFont  = 'Helvetica';
textFontSize = 8;
figTextFont  = 'Helvetica';
figWidth = 16;
figHight = 10;

s=figure;
figTitle = {['Post-famous vs Nonfamous correlations',hemiSide]};
setfigsize(s,axisFontSize,figAxisFont,textFontSize,figTextFont,figWidth,figHight);
colormap(jet);
imagesc(mean(postFam_NonFamLR,3));
caxis([-.35 .35]);
title(figTitle);
set(gca,'XTick',[1 : nRoi],'YTick',[1 : nRoi]);
set(gca,'XTickLabel',labelLR,'YTickLabel',labelLR);
set(gcf,'color','w');
colorbar;
export_fig([figOutPath,'PostFam_NonFam_',hemiSide],'-tiff','-r300');
% plot2svg([figOutPath,'PostFam_NonFam_',hemiSide,'.svg'],s);


%left side
% subplot(1,3,1)
s =figure;
figTitle = {'Baseline rest'};
colormap(jet);
imagesc(mean(baselineCorrGrpLR,3));
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
% plot2svg([figOutPath,'baseline_',hemiSide,'.svg'],s);
export_fig([figOutPath,'baseline_',hemiSide],'-tiff','-r300');

s=figure;
setfigsize(s,axisFontSize,figAxisFont,textFontSize,figTextFont,figWidth,figHight);
% subplot(1,3,2)
colormap(jet);
imagesc(mean(postFamCorrGrpLR,3));
caxis(colorLim);
title('Post-famous rest');
set(gca,'XTick',[1 : nRoi],'YTick',[1 : nRoi]);
set(gca,'XTickLabel',labelLR,'YTickLabel',labelLR);
set(gcf,'color','w');
colorbar;
if isHemiLR ==3
hold on;
plotAFrame(nRoi/2);
end
export_fig([figOutPath,'postFam_',hemiSide],'-tiff','-r300');


s=figure;
% subplot(1,3,3)
setfigsize(s,axisFontSize,figAxisFont,textFontSize,figTextFont,figWidth,figHight);
colormap(jet);
imagesc(mean(postNonFamCorrGrpLR,3));
caxis(colorLim);
title('Post-nonfamous rest');
set(gca,'XTick',[1 : nRoi],'YTick',[1 : nRoi]);
set(gca,'XTickLabel',labelLR,'YTickLabel',labelLR);
set(gcf,'color','w');
colorbar;
if isHemiLR ==3
hold on;
plotAFrame(nRoi/2);
end
% plot2svg([figOutPath,'PostNonFam_',hemiSide,'.svg'],s);
export_fig([figOutPath,'postNonFam_',hemiSide],'-tiff','-r300');


s=figure;
% subplot(1,3,3)
setfigsize(s,axisFontSize,figAxisFont,textFontSize,figTextFont,figWidth,figHight);
colormap(jet);
imagesc(tFdr_05);
caxis([-5 5]);
title('Post famous-nonfamous diff t value');
set(gca,'XTick',[1 : nRoi],'YTick',[1 : nRoi]);
set(gca,'XTickLabel',labelLR,'YTickLabel',labelLR);
set(gcf,'color','w');
colorbar;
if isHemiLR ==3
hold on;
plotAFrame(nRoi/2);
end
% plot2svg([figOutPath,'PostFam_NonFam_diff_TvalFdr05_',hemiSide,'.svg'],s);
export_fig([figOutPath,'PostFam_NonFam_diff_TvalFdr05_',hemiSide],'-tiff','-r300');


s=figure;
% subplot(1,3,3)
setfigsize(s,axisFontSize,figAxisFont,textFontSize,figTextFont,figWidth,figHight);
colormap(jet);
imagesc(tFdrTrend);
caxis([-5 5]);
title('Post famous-nonfamous diff t value');
set(gca,'XTick',[1 : nRoi],'YTick',[1 : nRoi]);
set(gca,'XTickLabel',labelLR,'YTickLabel',labelLR);
set(gcf,'color','w');
colorbar;
if isHemiLR ==3
hold on;
plotAFrame(nRoi/2);
end
% plot2svg([figOutPath,'PostFam_NonFam_diff_TvalFdr05Trend_',hemiSide,'.svg'],s);
export_fig([figOutPath,'PostFam_NonFam_diff_TvalFdr05Trend_',hemiSide],'-tiff','-r300');



s=figure;
% subplot(1,3,3)
setfigsize(s,axisFontSize,figAxisFont,textFontSize,figTextFont,figWidth,figHight);
colormap(jet);
imagesc(tNoCorrection);
caxis([-5 5]);
title('Post famous-nonfamous diff t value');
set(gca,'XTick',[1 : nRoi],'YTick',[1 : nRoi]);
set(gca,'XTickLabel',labelLR,'YTickLabel',labelLR);
set(gcf,'color','w');
colorbar;
if isHemiLR ==3
hold on;
plotAFrame(nRoi/2);
end
% plot2svg([figOutPath,'PostFam_NonFam_diff_TvalNoCrect_',hemiSide,'.svg'],s);
export_fig([figOutPath,'PostFam_NonFam_diff_TvalNoCrect_',hemiSide],'-tiff','-r300');
close all;


%*************************************************************************
function [corrL, corrR, corrLR]= computeCorr(data,FisherTrans, isDetrend,...
    isCovaryMotion, motionDataDir,...
    isCovaryWMCSF,WMCSFData, numTR,filterBand)

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
    a = textread([motionDataDir,'rp_avol_0004.txt']);
    dataX = a(1:numTR,:);
    dataR =  regressOutCovriate(dataR, dataX);
    dataL =  regressOutCovriate(dataL, dataX);
end

if isCovaryWMCSF ==1
    dataX(:,1)= WMCSFData.WM;
    dataX(:,2)= WMCSFData.CSF;
    dataR =  regressOutCovriate(dataR, dataX);
    dataL =  regressOutCovriate(dataL, dataX);
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