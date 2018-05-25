function firstlevelPmodFamousOnly(subID,dataName,isFamOnly,isBinarized)
if nargin <4
    isBinarized =[];
end
% List of open inputs
% fMRI model specification: Directory - cfg_files
% fMRI model specification: Scans - cfg_files
% fMRI model specification: Multiple conditions - cfg_files
% fMRI model specification: Multiple regressors - cfg_files
% Contrast Manager: Name - cfg_entry
% Contrast Manager: T contrast vector - cfg_entry
% Contrast Manager: Name - cfg_entry
% Contrast Manager: T contrast vector - cfg_entry
% Contrast Manager: Name - cfg_entry
% Contrast Manager: T contrast vector - cfg_entry
% Contrast Manager: Name - cfg_entry
% Contrast Manager: T contrast vector - cfg_entry
rootDir1 = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\';
rootDir = 'D:\myStudy\picpairfMRI\';
codeDir= [rootDir1,'matlabFunctions\'];
subDir = [rootDir, 's',sprintf('%03d',subID),'\'];
behavDataDir = [subDir,'performanceData\'];
nrun = 1; % enter the number of runs here
jobfile = {'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\matlabFunctions\firstlevelPmodFamousOnly_job.m'};
jobs = repmat(jobfile, 1, nrun);
inputs = cell(12, nrun);
for crun = 1:nrun
    FUNCDIR = [rootDir,'s',sprintf('%03d',subID(crun)),'\encoding'];
    inputs{1, crun} = {[FUNCDIR,'\analysis-',dataName,'Pmod-',num2str(isFamOnly),num2str(isBinarized),'\']}; % fMRI model specification: Directory - cfg_files
    if ~exist([FUNCDIR,'\analysis-',dataName,'Pmod-',num2str(isFamOnly),num2str(isBinarized),'\'],'dir')
        mkdir([FUNCDIR,'\analysis-',dataName,'Pmod-',num2str(isFamOnly),num2str(isBinarized),'\']);
    end
    
    inputs{2, crun} = GetImageList4D([FUNCDIR,'\taskRunsConcatenate'], WildcardFilename('*.img')); % fMRI model specification: Scans - cfg_files    
    inputs{3, crun} = {[behavDataDir,dataName,'multiCondPmod-',num2str(isFamOnly),num2str(isBinarized),'.mat']}; % fMRI model specification: Multiple conditions - cfg_files
    inputs{4, crun} = {[FUNCDIR,'\taskRunsConcatenate\motionParameter.txt']}; % fMRI model specification: Multiple regressors - cfg_files

    inputs{5, crun} = 'fam1'; % Contrast Manager: Name - cfg_entry
    inputs{6, crun} = [0 1]; % Contrast Manager: T contrast vector - cfg_entry
    inputs{7, crun} = 'fam2'; % Contrast Manager: Name - cfg_entry
    inputs{8, crun} = [0 0 0 0 1]; % Contrast Manager: T contrast vector - cfg_entry
    inputs{9, crun} = 'fam12'; % Contrast Manager: Name - cfg_entry
    inputs{10, crun} = [0 1 0 0 1]; % Contrast Manager: T contrast vector - cfg_entry
    inputs{11, crun} = 'fam1_2'; % Contrast Manager: Name - cfg_entry
    inputs{12, crun} = [0 1 0 0 -1]; % Contrast Manager: T contrast vector - cfg_entry
end
spm('defaults', 'FMRI');
spm_jobman('serial', jobs, '', inputs{:});
