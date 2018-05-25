function adding_F_ContrastToMainEncodingAnaysisForPPI(subID)
% List of open inputs
% Contrast Manager: Select SPM.mat - cfg_files
nrun = length(subID); % enter the number of runs here

rootDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\';
jobfile = {'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\matlabFunctions\adding_F_ContrastToMainEncodingAnaysisForPPIVoiExtraction_job.m'};
jobs = repmat(jobfile, 1, nrun);
inputs = cell(1, nrun);
for crun = 1:nrun
    inputs{1, crun} = {[rootDir,'s',sprintf('%03d',subID(crun)),...
                        '\encoding\analysis\SPM.mat']};  % Contrast Manager: Select SPM.mat - cfg_files
end
spm('defaults', 'FMRI');
spm_jobman('serial', jobs, '', inputs{:});
