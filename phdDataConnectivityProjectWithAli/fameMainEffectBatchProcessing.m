% List of open inputs
% Factorial design specification: Scans - cfg_files
rootDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\';
subjDir=dir([rootDir,'s0*.*']);
contrastImg =2;
nrun = 1; % enter the number of runs here
jobfile = {[rootDir,...
'\matlabFunctions\fameMainEffectBatchProcessing_job.m']};
jobs = repmat(jobfile, 1, nrun);
inputs = cell(1, nrun);
for crun = 1:nrun
for n = 1:length(subjDir)
inputs{1, crun}(n) = {[rootDir,subjDir(n).name,'\encoding\analysis\con_000',num2str(contrastImg),'.img']};
end
%inputs{1, crun} = MATLAB_CODE_TO_FILL_INPUT; % Factorial design specification: Scans - cfg_files
end
spm('defaults', 'FMRI');
spm_jobman('serial', jobs, '', inputs{:});
