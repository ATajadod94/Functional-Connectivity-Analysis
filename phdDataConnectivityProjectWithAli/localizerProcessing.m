function localizerProcessing(subID)
% List of open inputs
% fMRI model specification: Directory - cfg_files
% fMRI model specification: Scans - cfg_files
% fMRI model specification: Multiple conditions - cfg_files
% fMRI model specification: Multiple regressors - cfg_files

rootDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\';
nrun = length(subID);
jobfile = {'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\matlabFunctions\localizerProcessing_job.m'};
jobs = repmat(jobfile, 1, nrun);
inputs = cell(4, nrun);
for crun = 1:nrun
     FUNCDIR = [rootDir,'s',sprintf('%03d',subID(crun)),'\localization\'];
    inputs{1, crun} = {FUNCDIR}; % fMRI model specification: Directory - cfg_files
    inputs{2, crun} = GetImageList4D([rootDir,'s',sprintf('%03d',subID(crun)),'\scanImgData\run_0011'], WildcardFilename('sw*.img')); % fMRI model specification: Scans - cfg_files
    inputs{3, crun} = {[rootDir,'matlabFunctions\localizerMulticond_s',sprintf('%03d',subID),'.mat']}; % fMRI model specification: Multiple conditions - cfg_files
    inputs{4, crun} = {[rootDir,'s',sprintf('%03d',subID(crun)),'\scanImgData\run_0011\rp_avol_0004.txt' ]}; % fMRI model specification: Multiple regressors - cfg_files
end
spm('defaults', 'FMRI');
spm_jobman('serial', jobs, '', inputs{:});
