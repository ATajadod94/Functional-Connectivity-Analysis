function adding4MoreContrastRepetitionAdditionSubtraction(subID)
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

jobfile = {'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\matlabFunctions\adding4IndividualConditionContrast_job.m'};
jobs = repmat(jobfile, 1, nrun);
inputs = cell(9, nrun);
for crun = 1:nrun
    inputs{1, crun} = {[rootDir,'s',sprintf('%03d',subID(crun)),...
                        '\encoding\analysis\SPM.mat']}; % Contrast Manager: Select SPM.mat - cfg_files
    inputs{2, crun} = ['Fam1+Fam2']; % Contrast Manager: Name - cfg_entry
    inputs{3, crun} = [1 0 -1 0 1 0 -1 0]; % Contrast Manager: T contrast vector - cfg_entry
    inputs{4, crun} = ['Fam1 - Fam2']; % Contrast Manager: Name - cfg_entry
    inputs{5, crun} = [1 0 -1 0 -1 0 1 0]; % Contrast Manager: T contrast vector - cfg_entry
    inputs{6, crun} = ['NonFam1+NonFam2']; % Contrast Manager: Name - cfg_entry
    inputs{7, crun} = [0 0 0 0 0 0 0 0 1 0 -1 0 1 0 -1 0]; % Contrast Manager: T contrast vector - cfg_entry
    inputs{8, crun} = ['NonFam1-NonFam2']; % Contrast Manager: Name - cfg_entry
    inputs{9, crun} = [0 0 0 0 0 0 0 0 1 0 -1 0 -1 0 1 0]; % Contrast Manager: T contrast vector - cfg_entry
end
spm('defaults', 'FMRI');
spm_jobman('serial', jobs, '', inputs{:});
