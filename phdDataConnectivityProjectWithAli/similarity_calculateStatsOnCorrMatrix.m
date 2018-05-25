function similarity_calculateStatsOnCorrMatrix
rootDir='C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\similarityAnalysis\';

% maskDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\masks\';
% load([maskDir,'subjVoxForEachROI.mat']); % load the data of included voxels for each subj

corrMatrixDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\similarityAnalysis\corrMatrixData_EncodingResting\';
load([corrMatrixDir,'similarityData.mat']);
load([corrMatrixDir,'RestingCorrMeanData.mat']);



%get data
% fam1-postfam vs. fam1-postnfam
idx = 10; % for all roi separately
%find the data for to-be-tested similiarity


for subj=1:length(similarityPerRoi)
    allData1(:,:,subj)=restingCorrMeanPerRoi(subj).resting(:,:,2);
    allData2(:,:,subj)=restingCorrMeanPerRoi(subj).resting(:,:,3);
end
postfam_postnfam = ttestOnSimilarity(allData1,allData2,idx,1);
contrastNames = {'postFam','postNfam'};
plot2SimilarityDifference(allData1,allData2,postfam_postnfam,contrastNames, idx);


m = find(strcmp(corrNames.encoRest,'fam2-postfam')==1);
n = find(strcmp(corrNames.encoRest,'fam2-postnfam')==1);
contrastNames = {corrNames.encoRest{m},corrNames.encoRest{n}};
for subj=1:length(similarityPerRoi)
    allData1(:,:,subj)=similarityPerRoi(subj).encoRest(:,:,m);
    allData2(:,:,subj)=similarityPerRoi(subj).encoRest(:,:,n);
end
fam2_postfam_postnfam = ttestOnSimilarity(allData1,allData2,idx,1);
plot2SimilarityDifference(allData1,allData2, fam2_postfam_postnfam,contrastNames, idx);

m = find(strcmp(corrNames.encoRest,'fam1-postfam')==1);
n = find(strcmp(corrNames.encoRest,'fam1-postnfam')==1);
contrastNames = {corrNames.encoRest{m},corrNames.encoRest{n}};
for subj=1:length(similarityPerRoi)
    allData1(:,:,subj)=similarityPerRoi(subj).encoRest(:,:,m);
    allData2(:,:,subj)=similarityPerRoi(subj).encoRest(:,:,n);
end
fam1_postfam_postnfam = ttestOnSimilarity(allData1,allData2,idx,1);
plot2SimilarityDifference(allData1,allData2, fam1_postfam_postnfam,contrastNames, idx);

m = find(strcmp(corrNames.encoRest,'fam1-postfam')==1);
n = find(strcmp(corrNames.encoRest,'fam1-postnfam')==1);
contrastNames = {corrNames.encoRest{m},corrNames.encoRest{n}};
for subj=1:length(similarityPerRoi)
    allData1(:,:,subj)=similarityPerRoi(subj).encoRest(:,:,m);
    allData2(:,:,subj)=similarityPerRoi(subj).encoRest(:,:,n);
end
fam1_postfam_postnfam = ttestOnSimilarity(allData1,allData2,idx,1);
plot2SimilarityDifference(allData1,allData2, fam1_postfam_postnfam,contrastNames, idx);

%fam12-postfam vs. postnfam
m1 = find(strcmp(corrNames.encoRest,'fam1-postfam')==1);
m2 = find(strcmp(corrNames.encoRest,'fam2-postfam')==1);
n1 = find(strcmp(corrNames.encoRest,'fam1-postnfam')==1);
n2 = find(strcmp(corrNames.encoRest,'fam2-postnfam')==1);
for subj=1:length(similarityPerRoi)
    allData1(:,:,subj)=.5*(similarityPerRoi(subj).encoRest(:,:,m1)+similarityPerRoi(subj).encoRest(:,:,m2));
    allData2(:,:,subj)=.5*(similarityPerRoi(subj).encoRest(:,:,n1)+similarityPerRoi(subj).encoRest(:,:,n2));
end
fam12_postfam_postnfam = ttestOnSimilarity(allData1,allData2,idx,1);
contrastNames = {'fam12-postfam','fam12-postnfam'};
plot2SimilarityDifference(allData1,allData2, fam12_postfam_postnfam,contrastNames, idx);

%nfam12-postnfam vs. postfam
m1 = find(strcmp(corrNames.encoRest,'nfam1-postnfam')==1);
m2 = find(strcmp(corrNames.encoRest,'nfam2-postnfam')==1);
n1 = find(strcmp(corrNames.encoRest,'nfam1-postfam')==1);
n2 = find(strcmp(corrNames.encoRest,'nfam2-postfam')==1);
for subj=1:length(similarityPerRoi)
    allData1(:,:,subj)=.5*(similarityPerRoi(subj).encoRest(:,:,m1)+similarityPerRoi(subj).encoRest(:,:,m2));
    allData2(:,:,subj)=.5*(similarityPerRoi(subj).encoRest(:,:,n1)+similarityPerRoi(subj).encoRest(:,:,n2));
end
nfam12_postnfam_postfam = ttestOnSimilarity(allData1,allData2,idx,1);
contrastNames = {'nfam12-postnfam','nfam12-postfam'};
plot2SimilarityDifference(allData1,allData2, nfam12_postnfam_postfam,contrastNames, idx);


%fam12-postfam vs. postnfam partial pre
m1 = find(strcmp(corrNames.encoRestPartial,'fam1-postfam')==1);
m2 = find(strcmp(corrNames.encoRestPartial,'fam2-postfam')==1);
n1 = find(strcmp(corrNames.encoRestPartial,'fam1-postnfam')==1);
n2 = find(strcmp(corrNames.encoRestPartial,'fam2-postnfam')==1);
for subj=1:length(similarityPerRoi)
    allData1(:,:,subj)=.5*(similarityPerRoi(subj).encoRestPartialPre(:,:,m1)+similarityPerRoi(subj).encoRestPartialPre(:,:,m2));
    allData2(:,:,subj)=.5*(similarityPerRoi(subj).encoRestPartialPre(:,:,n1)+similarityPerRoi(subj).encoRestPartialPre(:,:,n2));
end
fam12_postfam_postnfam_partialpre = ttestOnSimilarity(allData1,allData2,idx,1);
contrastNames = {'fam12-postfam-partialpre','fam12-postnfam-partialpre'};
plot2SimilarityDifference(allData1,allData2, fam12_postfam_postnfam_partialpre,contrastNames, idx);

%nfam12-postnfam vs. postfam partial pre
m1 = find(strcmp(corrNames.encoRestPartial,'nfam1-postnfam')==1);
m2 = find(strcmp(corrNames.encoRestPartial,'nfam2-postnfam')==1);
n1 = find(strcmp(corrNames.encoRestPartial,'nfam1-postfam')==1);
n2 = find(strcmp(corrNames.encoRestPartial,'nfam2-postfam')==1);
for subj=1:length(similarityPerRoi)
    allData1(:,:,subj)=.5*(similarityPerRoi(subj).encoRestPartialPre(:,:,m1)+similarityPerRoi(subj).encoRestPartialPre(:,:,m2));
    allData2(:,:,subj)=.5*(similarityPerRoi(subj).encoRestPartialPre(:,:,n1)+similarityPerRoi(subj).encoRestPartialPre(:,:,n2));
end
nfam12_postnfam_postfam_partialpre = ttestOnSimilarity(allData1,allData2,idx,1);
contrastNames = {'nfam12-postnfam-partialpre','nfam12-postfam-partialpre'};
plot2SimilarityDifference(allData1,allData2, nfam12_postnfam_postfam_partialpre,contrastNames, idx);


%fam12-postfam vs. pre
m1 = find(strcmp(corrNames.encoRest,'fam1-postfam')==1);
m2 = find(strcmp(corrNames.encoRest,'fam2-postfam')==1);
n1 = find(strcmp(corrNames.encoRest,'fam1-pre')==1);
n2 = find(strcmp(corrNames.encoRest,'fam2-pre')==1);
for subj=1:length(similarityPerRoi)
    allData1(:,:,subj)=.5*(similarityPerRoi(subj).encoRest(:,:,m1)+similarityPerRoi(subj).encoRest(:,:,m2));
    allData2(:,:,subj)=.5*(similarityPerRoi(subj).encoRest(:,:,n1)+similarityPerRoi(subj).encoRest(:,:,n2));
end
a= ttestOnSimilarity(allData1,allData2,idx,1);
contrastNames = {'fam12-postfam','fam12-pre'};
plot2SimilarityDifference(allData1,allData2, a,contrastNames, idx);


%nfam12-postnfam vs. pre
m1 = find(strcmp(corrNames.encoRest,'nfam1-postnfam')==1);
m2 = find(strcmp(corrNames.encoRest,'nfam2-postnfam')==1);
n1 = find(strcmp(corrNames.encoRest,'nfam1-pre')==1);
n2 = find(strcmp(corrNames.encoRest,'nfam2-pre')==1);
for subj=1:length(similarityPerRoi)
    allData1(:,:,subj)=.5*(similarityPerRoi(subj).encoRest(:,:,m1)+similarityPerRoi(subj).encoRest(:,:,m2));
    allData2(:,:,subj)=.5*(similarityPerRoi(subj).encoRest(:,:,n1)+similarityPerRoi(subj).encoRest(:,:,n2));
end
a= ttestOnSimilarity(allData1,allData2,idx,1);
contrastNames = {'nfam12-postnfam','nfam12-pre'};
plot2SimilarityDifference(allData1,allData2, a,contrastNames, idx);





idx=5;
%fam12-postfam vs. postnfam
m1 = find(strcmp(corrNames.encoRest,'fam1-postfam')==1);
m2 = find(strcmp(corrNames.encoRest,'fam2-postfam')==1);
n1 = find(strcmp(corrNames.encoRest,'fam1-postnfam')==1);
n2 = find(strcmp(corrNames.encoRest,'fam2-postnfam')==1);
for subj=1:length(similarityLRMergedRoi)
    allData1(:,:,subj)=.5*(similarityLRMergedRoi(subj).encoRest(:,:,m1)+similarityLRMergedRoi(subj).encoRest(:,:,m2));
    allData2(:,:,subj)=.5*(similarityLRMergedRoi(subj).encoRest(:,:,n1)+similarityLRMergedRoi(subj).encoRest(:,:,n2));
end
fam12_postfam_postnfam = ttestOnSimilarity(allData1,allData2,idx,1);
contrastNames = {'fam12-postfam','fam12-postnfam'};
plot2SimilarityDifference(allData1,allData2, fam12_postfam_postnfam,contrastNames, idx);

%nfam12-postnfam vs. postfam
m1 = find(strcmp(corrNames.encoRest,'nfam1-postnfam')==1);
m2 = find(strcmp(corrNames.encoRest,'nfam2-postnfam')==1);
n1 = find(strcmp(corrNames.encoRest,'nfam1-postfam')==1);
n2 = find(strcmp(corrNames.encoRest,'nfam2-postfam')==1);
for subj=1:length(similarityLRMergedRoi)
    allData1(:,:,subj)=.5*(similarityLRMergedRoi(subj).encoRest(:,:,m1)+similarityLRMergedRoi(subj).encoRest(:,:,m2));
    allData2(:,:,subj)=.5*(similarityLRMergedRoi(subj).encoRest(:,:,n1)+similarityLRMergedRoi(subj).encoRest(:,:,n2));
end
nfam12_postnfam_postfam = ttestOnSimilarity(allData1,allData2,idx,1);
contrastNames = {'nfam12-postnfam','nfam12-postfam'};
plot2SimilarityDifference(allData1,allData2, nfam12_postnfam_postfam,contrastNames, idx);









%get data
% fam1-postfam vs. fam1-postnfam
idx = 10; % for all roi separately
%find the data for to-be-tested similiarity

m = find(strcmp(corrNames.encoRestPartial,'fam1-postfam')==1);
n = find(strcmp(corrNames.encoRestPartial,'nfam1-postnfam')==1);
for subj=1:length(similarityPerRoi)
    allData1(:,:,subj)=similarityPerRoi(subj).encoRestPartialPost(:,:,m);
    allData2(:,:,subj)=similarityPerRoi(subj).encoRestPartialPost(:,:,n);
end
fam1_postfam_nfam1_postnfam = ttestOnSimilarity(allData1,allData2,idx,1);

%get data
% fam1-postfam vs. fam1-postnfam
idx = 10; % for all roi separately
%find the data for to-be-tested similiarity

m = find(strcmp(corrNames.encoRest,'fam1-postfam')==1);
n = find(strcmp(corrNames.encoRestPartial,'fam1-postnfam')==1);
for subj=1:length(similarityPerRoi)
    allData1(:,:,subj)=similarityPerRoi(subj).encoRestPartialPost(:,:,m);
    allData2(:,:,subj)=similarityPerRoi(subj).encoRestPartialPost(:,:,n);
end
fam1_postfam_postnfam = ttestOnSimilarity(allData1,allData2,idx,1);




% fam2-postfam vs. fam2-postnfam
m = find(strcmp(corrNames.encoRestPartial,'fam2-postfam')==1);
n = find(strcmp(corrNames.encoRestPartial,'fam2-postnfam')==1);
for subj=1:length(similarityPerRoi)
    allData1(:,:,subj)=similarityPerRoi(subj).encoRestPartialPost(:,:,m);
    allData2(:,:,subj)=similarityPerRoi(subj).encoRestPartialPost(:,:,n);
end
fam2_postfam_postnfam = ttestOnSimilarity(allData1,allData2,idx,1);


%     allData = getfield(similarityPerRoi(subj), corrMatrixField);
%
function outStats = ttestOnSimilarity(allData1,allData2,idx,doFisherZ)

for roii=1:idx
    for roij = 1: roii
        data1=squeeze(allData1(roii,roij,:));
        data2=squeeze(allData2(roii,roij,:));
        if doFisherZ==1
        data1 = 0.5 * log((1 +data1)./(1- data1));
        data2 = 0.5 * log((1 +data2)./(1- data2));
        end
        % t test
        [output,idkept,idDel,idOut]=removeoutlierpair(data1,data2,2.5);
        [a p c stats]= ttest(output(:,1),output(:,2));
        outStats.P(roii,roij)=p;
        outStats.T(roii,roij)=stats.tstat;
        outStats.df(roii,roij)=stats.df;
        outStats.sd(roii,roij)=stats.sd;
    end
end

function plot2SimilarityDifference(allData1,allData2, outStats,contrastNames, numROI)
figOutPath = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\similarityAnalysis\corrMatrixData_EncodingResting\resultsFigures\';
axisFontSize = 8;
figAxisFont  = 'Helvetica';
textFontSize = 8;
figTextFont  = 'Helvetica';
figWidth = 36;
figHight = 15;


s=figure;
subplot(2,3,1)
valueLim= [-1 1];
justDoPlotMatrix(mean(allData1,3),valueLim,numROI);
title(contrastNames{1});

subplot(2,3,2)
justDoPlotMatrix(mean(allData2,3),valueLim,numROI);
title(contrastNames{2});

subplot(2,3,3)
valueLim= [-.5 .5];
justDoPlotMatrix(mean(allData1,3)-mean(allData2,3),valueLim,numROI);
title([contrastNames{1},'-',contrastNames{2}]);

subplot(2,3,4)
valueLim= [-2 2];
justDoPlotMatrix(outStats.T,valueLim,numROI);
title('tval');

subplot(2,3,5)
justDoPlotMatrix(outStats.T.*(outStats.P <=.05),valueLim,numROI);
title('tval:p<.05');

subplot(2,3,6)
id = find(outStats.df~=0);
q=conn_fdr(outStats.P(id));
outStats.P(id) = q;
justDoPlotMatrix(outStats.T.*(outStats.P <=.05),valueLim,numROI);
title('tval:fdr p<.05');
setfigsize(s,axisFontSize,figAxisFont,textFontSize,figTextFont,figWidth,figHight);

export_fig([figOutPath,[contrastNames{1},'-',contrastNames{2}],'-',num2str(numROI)],'-tiff','-r300');
% plot2svg([figOutPath,'PostFam_NonFam_',hemiSide,'.svg'],s);



function h = justDoPlotMatrix(data,valueLim,numROI)
if numROI == 5
    labelLR = {'vm','tp','hp','pp','ff'};
else
    labelLR = {'lv','rv','lt','rt','lh','rh','lp','rp','lf','rf'};
end
colormap(jet);
h = imagesc(data);
caxis([valueLim(1) valueLim(2)]);
colorbar;
set(gca,'XTick',[1 : numROI],'YTick',[1 : numROI]);
set(gca,'XTickLabel',labelLR,'YTickLabel',labelLR);
set(gcf,'color','w');


