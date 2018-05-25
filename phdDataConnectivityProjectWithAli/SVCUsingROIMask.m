function TabDat = SVCUsingROIMask(spmDir, maskFile, contrastID, voxThresh)
spm('defaults','fmri');
xSPM.swd       = spmDir;
xSPM.Ic        = contrastID; % index of contrast
xSPM.n         = 1; % conjunction number (next update)
xSPM.u         = voxThresh;
xSPM.Im        =[]; % if no masking
% if need masking
% xSPM.Im        = {'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelAnalysis\picEffect_Pic-Scramble\L_HPC.img'};
% xSPM.Ex        = 0; % 0 inclusive 1, exclusive
xSPM.thresDesc = 'none'; % 'FWE', or 'FDR'-if using FDR defaults.stats.topFDR need be changed from 1 to 0
xSPM.title     = '';
xSPM.k         = 10;
xSPM.units     = {'mm' 'mm' 'mm'};

% specify parameters for SVC
CustomParameters.Num = 8; % maxima per cluster (default 16)
CustomParameters.Dis = 4; % distance among maxima (mm, default 4)
% CustomParameters.xyzmm = [10 -10 10]; % custom centre coordinates (mm), not necessary zhongxu
CustomParameters.SPACE = 'I'; % Spherical VOI
CustomParameters.D = maskFile;

% 
 [hReg, xSPM, SPM] = spm_results_ui('setup', xSPM); 
 TabDat = spm_VOI_Custom(SPM,xSPM,hReg,CustomParameters);

