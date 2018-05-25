function [baseline, postFam,postNonFam]=creatTimeSeriesUsingRexPilot(numTR)
participantNum='pilot002';

%make participant folder
projDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\';

if ~exist([projDir,participantNum],'dir')
    mkdir([projDir,participantNum]);
end
rootDir = [projDir,participantNum,'\'];

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
baseline = getTimeSeriesUsingVex(imgF,rootDir);

%************* postFam
f=dir([rootDir,'prepostEncoding\postFam\','*.img']);
for i = 1:numTR
   imgFF(i,:)=[rootDir,'prepostEncoding\postFam\',f(i).name];    
end
postFam = getTimeSeriesUsingVex(imgFF,rootDir);

%************ postNonFam
f=dir([rootDir,'prepostEncoding\postNonFam\','*.img']);
for i = 1:numTR
   imgFNF(i,:)=[rootDir,'prepostEncoding\postNonFam\',f(i).name];    
end
postNonFam = getTimeSeriesUsingVex(imgFNF,rootDir);

save([rootDir,'prepostEncoding\','restTimeS.mat'],...
                'baseline','postFam','postNonFam');

%*****************************************************************************
function timeS = getTimeSeriesUsingVex(imgF,rootDir)
maskDir = ['C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\masks\'];
timeS.L_FFA = rex(imgF, [rootDir,'localization\','L_FFA.img']);
timeS.R_FFA = rex(imgF, [rootDir,'localization\','R_FFA.img']);

timeS.L_PPA = rex(imgF, [rootDir,'localization\','L_PPA.img']);
timeS.R_PPA = rex(imgF, [rootDir,'localization\','R_PPA.img']);

timeS.L_HPC = rex(imgF, [maskDir,'L_HPC.img']);
timeS.R_HPC = rex(imgF, [maskDir,'R_HPC.img']);

timeS.L_vmP = rex(imgF, [maskDir,'L_vmP.img']);
timeS.R_vmP = rex(imgF, [maskDir,'R_vmP.img']);

timeS.L_Cdt = rex(imgF, [maskDir,'L_M_1.img']);
timeS.R_Cdt = rex(imgF, [maskDir,'R_M_1.img']);

timeS.L_TPL = rex(imgF, [maskDir,'L_TPL.img']);
timeS.R_TPL = rex(imgF, [maskDir,'R_TPL.img']);

