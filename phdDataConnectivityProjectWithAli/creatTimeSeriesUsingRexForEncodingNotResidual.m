function [fam1,fam2,nonfam1,nonfam2]=creatTimeSeriesUsingRexForEncodingNotResidual(subID,numTR)
participantNum=sprintf('%03d',subID);

%make participant folder
projDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\';
rootDir = [projDir,'s',participantNum,'\'];
dataDir = [projDir,'s',participantNum,...
    '\encoding\taskRunsConcatenate\'];
% numTR = 287;
%************ fam1
f=dir([dataDir,'*.img']);
for i = 1:numTR
   imgF(i,:)=[dataDir,f(i).name];    
end
fam1 = getTimeSeriesUsingVex(imgF,rootDir);

%************ fam2
f=dir([dataDir,'*.img']);
for i = 1:numTR
    k = numTR+i;
   imgF(i,:)=[dataDir,f(k).name];    
end
fam2 = getTimeSeriesUsingVex(imgF,rootDir);

%************ nonfam1
f=dir([dataDir,'*.img']);
for i = 1:numTR
    k = numTR*2+i;
   imgF(i,:)=[dataDir,f(k).name];    
end
nonfam1 = getTimeSeriesUsingVex(imgF,rootDir);

%************ nonfam2
f=dir([dataDir,'*.img']);
for i = 1:numTR
    k = numTR*3+i;
   imgF(i,:)=[dataDir,f(k).name];    
end
nonfam2 = getTimeSeriesUsingVex(imgF,rootDir);

save([rootDir,'encoding\','restTimeSNotResi.mat'],...
                'fam1','fam2','nonfam1','nonfam2');

%*****************************************************************************
function timeS = getTimeSeriesUsingVex(imgF,rootDir)
maskDir = ['C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\masks\'];
timeS.L_FFA = rex(imgF, [rootDir,'localization\','L_FFA.img'],'select_clusters',0);%,'summary_measure','eigenvariate','dims',1
timeS.R_FFA = rex(imgF, [rootDir,'localization\','R_FFA.img'],'select_clusters',0);

timeS.L_PPA = rex(imgF, [rootDir,'localization\','L_PPA.img'],'select_clusters',0);
timeS.R_PPA = rex(imgF, [rootDir,'localization\','R_PPA.img'],'select_clusters',0);

timeS.L_HPC = rex(imgF, [maskDir,'L_HPC.nii'],'select_clusters',0);
timeS.R_HPC = rex(imgF, [maskDir,'R_HPC.nii'],'select_clusters',0);

timeS.L_vmP = rex(imgF, [maskDir,'L_vmP.nii'],'select_clusters',0);
timeS.R_vmP = rex(imgF, [maskDir,'R_vmP.nii'],'select_clusters',0);

timeS.L_TPL = rex(imgF, [maskDir,'L_TPL.nii'],'select_clusters',0);
timeS.R_TPL = rex(imgF, [maskDir,'R_TPL.nii'],'select_clusters',0);

% timeS.L_Cdt = rex(imgF, [maskDir,'L_M_1.nii']);
% timeS.R_Cdt = rex(imgF, [maskDir,'R_M_1.nii']);