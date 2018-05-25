function firstlevelAnalysisBasicForResidual(subID)
% List of open inputs
% fMRI model specification: Directory - cfg_files
% fMRI model specification: Scans - cfg_files
% fMRI model specification: Multiple conditions - cfg_files
% fMRI model specification: Multiple regressors - cfg_files

rootDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\';
rootDir1 = 'G:\myStudy\picpairfMRI\';
nrun = length(subID); % enter the number of runs here
jobfile = {'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\matlabFunctions\firstlevelAnalysisBasicForResidual_job.m'};
jobs = repmat(jobfile, 1, nrun);
inputs = cell(4, nrun);
for crun = 1:nrun
        FUNCDIR = [rootDir,'s',sprintf('%03d',subID(crun)),'\encoding'];
        FUNCDIR1 = [rootDir1,'s',sprintf('%03d',subID(crun)),'\encoding'];
    inputs{1, crun} = {[FUNCDIR1,'\analysis_residualsOnlyHrf\']}; % fMRI model specification: Directory - cfg_files
    if ~exist([FUNCDIR1,'\analysis_residualsOnlyHrf\'],'dir')
        mkdir([FUNCDIR1,'\analysis_residualsOnlyHrf\']);
    end
    inputs{2, crun} = GetImageList4D([FUNCDIR,'\taskRunsConcatenate'], WildcardFilename('*.img')); % fMRI model specification: Scans - cfg_files    
    inputs{3, crun} = {[rootDir,'\matlabFunctions\multicond.mat']}; % fMRI model specification: Multiple conditions - cfg_files
    inputs{4, crun} = {[FUNCDIR,'\taskRunsConcatenate\motionParameter.txt']}; % fMRI model specification: Multiple regressors - cfg_files
end
spm('defaults', 'FMRI');
spm_jobman('serial', jobs, '', inputs{:});
