function firstlevelAnalysisBasic_forFaceEvalCovAnalysis(subID,dataName)
% List of open inputs
% fMRI model specification: Directory - cfg_files
% fMRI model specification: Scans - cfg_files
% fMRI model specification: Multiple conditions - cfg_files
% fMRI model specification: Multiple regressors - cfg_files

rootDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\';
rootDataDir = 'D:\myStudy\picpairfMRI\';
nrun = length(subID); % enter the number of runs here
jobfile = {'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\matlabFunctions\firstlevelAnalysisBasic_job.m'};
jobs = repmat(jobfile, 1, nrun);
inputs = cell(4, nrun);
for crun = 1:nrun
        FUNCDIR = [rootDataDir,'s',sprintf('%03d',subID(crun)),'\encoding'];
        if ~exist([FUNCDIR,'\analysis-FaceEvalCov-',dataName,'\'],'dir')
            mkdir([FUNCDIR,'\analysis-FaceEvalCov-',dataName,'\']);
        end
    inputs{1, crun} = {[FUNCDIR,'\analysis-FaceEvalCov-',dataName,'\']}; % fMRI model specification: Directory - cfg_files
    inputs{2, crun} = GetImageList4D([FUNCDIR,'\taskRunsConcatenate'], WildcardFilename('*.img')); % fMRI model specification: Scans - cfg_files    
    inputs{3, crun} = {[rootDir,'\matlabFunctions\multicond.mat']}; % fMRI model specification: Multiple conditions - cfg_files
    inputs{4, crun} = {[FUNCDIR,'\taskRunsConcatenate\','motionFaceEvalReg-',dataName,'.txt']}; % fMRI model specification: Multiple regressors - cfg_files
end
spm('defaults', 'FMRI');
spm_jobman('serial', jobs, '', inputs{:});
