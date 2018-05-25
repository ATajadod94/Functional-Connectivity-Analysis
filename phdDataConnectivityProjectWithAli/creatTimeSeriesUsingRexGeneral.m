function [baseline, postFam,postNonFam]=creatTimeSeriesUsingRexGeneral(subID,...
          outputFileName, maskNames,maskFiles,numTR)
participantNum=sprintf('%03d',subID);

%make participant folder
projDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\';

if ~exist([projDir,'s',participantNum],'dir')
    mkdir([projDir,'s',participantNum]);
end
rootDir = [projDir,'s',participantNum,'\'];

if ~exist([rootDir,'prepostEncoding\preBaseline'],'dir')
    mkdir([rootDir,'prepostEncoding\preBaseline']);
end

if ~exist([rootDir,'prepostEncoding\postFam'],'dir')
    mkdir([rootDir,'prepostEncoding\postFam']);
end

if ~exist([rootDir,'prepostEncoding\postNonFam'],'dir')
    mkdir([rootDir,'prepostEncoding\postNonFam']);
end

%************ baseline
f=dir([rootDir,'prepostEncoding\preBaseline\','*.img']);
for i = 1:numTR
   imgF(i,:)=[rootDir,'prepostEncoding\preBaseline\',f(i).name];    
end
baseline = getTimeSeriesUsingVex(imgF,maskNames,maskFiles);

%************* postFam
f=dir([rootDir,'prepostEncoding\postFam\','*.img']);
for i = 1:numTR
   imgFF(i,:)=[rootDir,'prepostEncoding\postFam\',f(i).name];    
end
postFam = getTimeSeriesUsingVex(imgFF,maskNames, maskFiles);

%************ postNonFam
f=dir([rootDir,'prepostEncoding\postNonFam\','*.img']);
for i = 1:numTR
   imgFNF(i,:)=[rootDir,'prepostEncoding\postNonFam\',f(i).name];    
end
postNonFam = getTimeSeriesUsingVex(imgFNF,maskNames, maskFiles);

save([rootDir,'prepostEncoding\','restTimeS',outputFileName,'.mat'],...
                'baseline','postFam','postNonFam');

%*****************************************************************************
function timeS = getTimeSeriesUsingVex(imgF,maskNames, maskFiles)
 
nMasks = size(maskNames,2);
for i = 1:nMasks
    [timeS.(maskNames{i})]= rex(imgF, maskFiles{i},'select_clusters',0);    
end

