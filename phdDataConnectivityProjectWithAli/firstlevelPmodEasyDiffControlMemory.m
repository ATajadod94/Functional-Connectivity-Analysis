function firstlevelPmodEasyDiffControlMemory(subID,dataName)

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
rootDir = 'D:\myStudy\picpairfMRI\';
subDir = [rootDir, 's',sprintf('%03d',subID),'\'];
behavDataDir = [subDir,'performanceData\'];
nrun = 1; % enter the number of runs here
jobfile = {'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\matlabFunctions\firstlevelPmodEasyDiffControlMem_job.m'};
jobs = repmat(jobfile, 1, nrun);
inputs = cell(26, nrun);
for crun = 1:nrun
    FUNCDIR = [rootDir,'s',sprintf('%03d',subID(crun)),'\encoding'];
    inputs{1, crun} = {[FUNCDIR,'\analysis-',dataName,'Pmod\']}; % fMRI model specification: Directory - cfg_files
    if ~exist([FUNCDIR,'\analysis-',dataName,'Pmod\'],'dir')
        mkdir([FUNCDIR,'\analysis-',dataName,'Pmod\']);
    end
    
    inputs{2, crun} = GetImageList4D([FUNCDIR,'\taskRunsConcatenate'], WildcardFilename('*.img')); % fMRI model specification: Scans - cfg_files    
    inputs{3, crun} = {[behavDataDir,'easyDiffiucltControlMemoryPmod_012.mat']}; % fMRI model specification: Multiple conditions - cfg_files
    inputs{4, crun} = {[FUNCDIR,'\taskRunsConcatenate\motionParameter.txt']}; % fMRI model specification: Multiple regressors - cfg_files

    inputs{5, crun} = 'fam1'; % Contrast Manager: Name - cfg_entry
    inputs{6, crun} = [0 1]; % Contrast Manager: T contrast vector - cfg_entry
    inputs{7, crun} = 'fam2'; % Contrast Manager: Name - cfg_entry
    inputs{8, crun} = [0 0 0 0 1]; % Contrast Manager: T contrast vector - cfg_entry
    inputs{9, crun} = 'fam12'; % Contrast Manager: Name - cfg_entry
    inputs{10, crun} = [0 1 0 0 1]; % Contrast Manager: T contrast vector - cfg_entry
    inputs{11, crun} = 'fam1_2'; % Contrast Manager: Name - cfg_entry
    inputs{12, crun} = [0 1 0 0 -1]; % Contrast Manager: T contrast vector - cfg_entry
      
    inputs{13, crun} = 'nfam1'; % Contrast Manager: Name - cfg_entry
    inputs{14, crun} = [0 0 0 0 0 0 0 1]; % Contrast Manager: T contrast vector - cfg_entry
    inputs{15, crun} = 'nfam2'; % Contrast Manager: Name - cfg_entry
    inputs{16, crun} = [0 0 0 0 0 0 0 0 0 0 1]; % Contrast Manager: T contrast vector - cfg_entry
    inputs{17, crun} = 'nfam12'; % Contrast Manager: Name - cfg_entry
    inputs{18, crun} = [0 0 0 0 0 0 0 1 0 0 1]; % Contrast Manager: T contrast vector - cfg_entry
    inputs{19, crun} = 'nfam1_2'; % Contrast Manager: Name - cfg_entry
    inputs{20, crun} = [0 0 0 0 0 0 0 1 0 0 -1]; % Contrast Manager: T contrast vector - cfg_entry
    
    inputs{21, crun} = 'fam12_nfam12'; % Contrast Manager: Name - cfg_entry    
    inputs{22, crun} = [0 1 0 0 1 0 0 -1 0 0 -1]; % Contrast Manager: T contrast vector - cfg_entry 
    
    inputs{23, crun} = 'fam1_nfam1'; % Contrast Manager: Name - cfg_entry    
    inputs{24, crun} = [0 1 0 0 0 0 0 -1]; % Contrast Manager: T contrast vector - cfg_entry 
    
    inputs{25, crun} = 'fam2_nfam2'; % Contrast Manager: Name - cfg_entry    
    inputs{26, crun} = [0 0 0 0 1 0 0 0 0 0 -1]; % Contrast Manager: T contrast vector - cfg_entry 
   inputs{27, crun} = 'famnfam12'; % Contrast Manager: Name - cfg_entry    
    inputs{28, crun} = [0 1 0 0 1 0 0 1 0 0 1]; % Contrast Manager: T contrast vector - cfg_entry 
 
end

spm('defaults', 'FMRI');
spm_jobman('serial', jobs, '', inputs{:});
