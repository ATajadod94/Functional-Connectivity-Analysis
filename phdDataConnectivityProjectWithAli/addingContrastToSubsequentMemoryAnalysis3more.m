function addingContrastToSubsequentMemoryAnalysis3more(subID)
%fam1+fam2 nfam1+nfam2 fam1-nfam1 fam2-nfam2
% List of open inputs
% Contrast Manager: Select SPM.mat - cfg_files
% Contrast Manager: Name - cfg_entry
% Contrast Manager: T contrast vector - cfg_entry
% Contrast Manager: Name - cfg_entry
% Contrast Manager: T contrast vector - cfg_entry
% Contrast Manager: Name - cfg_entry
% Contrast Manager: T contrast vector - cfg_entry
% Contrast Manager: Name - cfg_entry
% Contrast Manager: T contrast vector - cfg_entry
rootDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\';
nrun = length(subID); % enter the number of runs here

jobfile = {'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\matlabFunctions\adding3IndividualConditionContrast_job.m'};
jobs = repmat(jobfile, 1, nrun);
inputs = cell(15, nrun);
for crun = 1:nrun
    inputs{1, crun} = {[rootDir,'s',sprintf('%03d',subID(crun)),...
        '\encoding\analysis-subsequentMemory\SPM.mat']}; % Contrast Manager: Select SPM.mat - cfg_files
    inputs{2, crun} = ['NonFam2Rem-nonRem']; % Contrast Manager: Name - cfg_entry
    inputs{3, crun} = [0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 -1 0]; % Contrast Manager: T contrast vector - cfg_entry
    inputs{4, crun} = ['NonFam12Rem-nonRem']; % Contrast Manager: Name - cfg_entry
    inputs{5, crun} = [0 0 0 0 0 0 0 0 0 0 0 0 1 0 -1 0 0 0 1 0 -1 0 0 0]; % Contrast Manager: T contrast vector - cfg_entry
    inputs{6, crun} = ['fameSubseqEffectfam-nonfam']; % Contrast Manager: Name - cfg_entry
    inputs{7, crun} = [1 0 -1 0 0 0 1 0 -1 0 0 0 -1 0 1 0 0 0 -1 0 1 0 0 0]; % Contrast Manager: T contrast vector - cfg_entry
       
end
spm('defaults', 'FMRI');
spm_jobman('serial', jobs, '', inputs{:});
