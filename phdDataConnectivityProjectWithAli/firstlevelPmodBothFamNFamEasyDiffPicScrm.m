function firstlevelPmodBothFamNFamEasyDiffPicScrm(subID,dataName,isFamOnly,isBinarized)
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
rootDir = 'D:\myStudy\picpairfMRI\';
% codeDir= [rootDir,'matlabFunctions\'];
subDir = [rootDir, 's',sprintf('%03d',subID),'\'];
behavDataDir = [subDir,'performanceData\'];
nrun = 1; % enter the number of runs here
jobfile = {'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\matlabFunctions\firstlevelPmodBothFamNFamEasyDiffPicScrm_job.m'};
jobs = repmat(jobfile, 1, nrun);
inputs = cell(48, nrun);
for crun = 1:nrun
    FUNCDIR = [rootDir,'s',sprintf('%03d',subID(crun)),'\encoding'];
    inputs{1, crun} = {[FUNCDIR,'\analysis-',dataName,'Pmod-',num2str(isFamOnly),num2str(isBinarized),'\']}; % fMRI model specification: Directory - cfg_files
    if ~exist([FUNCDIR,'\analysis-',dataName,'Pmod-',num2str(isFamOnly),num2str(isBinarized),'\'],'dir')
        mkdir([FUNCDIR,'\analysis-',dataName,'Pmod-',num2str(isFamOnly),num2str(isBinarized),'\']);
    else delete([FUNCDIR,'\analysis-',dataName,'Pmod-',num2str(isFamOnly),num2str(isBinarized),'\SPM.*']);
    end
    
    inputs{2, crun} = GetImageList4D([FUNCDIR,'\taskRunsConcatenate'], WildcardFilename('*.img')); % fMRI model specification: Scans - cfg_files
    inputs{3, crun} = {[behavDataDir,dataName,'multiCondPmod-',num2str(isFamOnly),'.mat']}; % fMRI model specification: Multiple conditions - cfg_files
    inputs{4, crun} = {[FUNCDIR,'\taskRunsConcatenate\motionParameter.txt']}; % fMRI model specification: Multiple regressors - cfg_files
    
    inputs{5, crun} = 'fam1'; % Contrast Manager: Name - cfg_entry
    inputs{6, crun} = [0 1]; % Contrast Manager: T contrast vector - cfg_entry
    inputs{7, crun} = 'fam1-scrmble'; % Contrast Manager: Name - cfg_entry
    inputs{8, crun} = [0 0 0 1]; % Contrast Manager: T contrast vector - cfg_entry
    inputs{9, crun} = 'fam2'; % Contrast Manager: Name - cfg_entry
    inputs{10, crun} = [0 0 0 0 0 1]; % Contrast Manager: T contrast vector - cfg_entry
    inputs{11, crun} = 'fam2-scrmble'; % Contrast Manager: Name - cfg_entry
    inputs{12, crun} = [0 0 0 0 0 0 0 1]; % Contrast Manager: T contrast vector - cfg_entry
    inputs{13, crun} = 'fam12'; % Contrast Manager: Name - cfg_entry
    inputs{14, crun} = [0 1 0 0 0 1]; % Contrast Manager: T contrast vector - cfg_entry
    inputs{15, crun} = 'fam1_2'; % Contrast Manager: Name - cfg_entry
    inputs{16, crun} = [0 1 0 0 0 -1]; % Contrast Manager: T contrast vector - cfg_entry
    inputs{17, crun} = 'fam12-scrmble'; % Contrast Manager: Name - cfg_entry
    inputs{18, crun} = [0 0 0 1 0 0 0 1]; % Contrast Manager: T contrast vector - cfg_entry
    inputs{19, crun} = 'fam1-2-scrmble'; % Contrast Manager: Name - cfg_entry
    inputs{20, crun} = [0 0 0 1 0 0 0 -1]; % Contrast Manager: T contrast vector - cfg_entry
    
    inputs{21, crun} = 'nfam1'; % Contrast Manager: Name - cfg_entry
    inputs{22, crun} = [0 0 0 0 0 0 0 0 0 1]; % Contrast Manager: T contrast vector - cfg_entry
    inputs{23, crun} = 'nfam1-scrmble'; % Contrast Manager: Name - cfg_entry
    inputs{24, crun} = [0 0 0 0 0 0 0 0 0 0 0 1]; % Contrast Manager: T contrast vector - cfg_entry
    
    
    inputs{25, crun} = 'nfam2'; % Contrast Manager: Name - cfg_entry
    inputs{26, crun} = [0 0 0 0 0 0 0 0 0 0 0 0 0 1]; % Contrast Manager: T contrast vector - cfg_entry
    inputs{27, crun} = 'nfam2-scrmble'; % Contrast Manager: Name - cfg_entry
    inputs{28, crun} = [0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1]; % Contrast Manager: T contrast vector - cfg_entry
    
    
    inputs{29, crun} = 'nfam12'; % Contrast Manager: Name - cfg_entry
    inputs{30, crun} = [0 0 0 0 0 0 0 0 0 1 0 0 0 1]; % Contrast Manager: T contrast vector - cfg_entry
    inputs{31, crun} = 'nfam1_2'; % Contrast Manager: Name - cfg_entry
    inputs{32, crun} = [0 0 0 0 0 0 0 0 0 1 0 0 0 -1]; % Contrast Manager: T contrast vector - cfg_entry
    inputs{33, crun} = 'nfam12-scrmble'; % Contrast Manager: Name - cfg_entry
    inputs{34, crun} = [0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1]; % Contrast Manager: T contrast vector - cfg_entry
    inputs{35, crun} = 'nfam1-2-scrmble'; % Contrast Manager: Name - cfg_entry
    inputs{36, crun} = [0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 -1]; % Contrast Manager: T contrast vector - cfg_entry
    
    
    inputs{37, crun} = 'fam12_nfam12'; % Contrast Manager: Name - cfg_entry
    inputs{38, crun} = [0 1 0 0 0 1 0 0 0 -1 0 0 0 -1]; % Contrast Manager: T contrast vector - cfg_entry
    inputs{39, crun} = 'fam12_nfam12_contrlScrmble'; % Contrast Manager: Name - cfg_entry
    inputs{40, crun} = [0 1 0 -1 0 1 0 -1 0 -1 0 1 0 -1 0 1]; % Contrast Manager: T contrast vector - cfg_entry
    
    inputs{41, crun} = 'fam1_nfam1'; % Contrast Manager: Name - cfg_entry
    inputs{42, crun} = [0 1 0 0 0 0 0 0 0 -1]; % Contrast Manager: T contrast vector - cfg_entry
    inputs{43, crun} = 'fam1_nfam1_contrlScrmble'; % Contrast Manager: Name - cfg_entry
    inputs{44, crun} = [0 1 0 -1 0 0 0 0 0 -1 0 1]; % Contrast Manager: T contrast vector - cfg_entry
    
    inputs{45, crun} = 'fam2_nfam2'; % Contrast Manager: Name - cfg_entry
    inputs{46, crun} = [0 0 0 0 0 1 0 0 0 0 0 0 0 -1]; % Contrast Manager: T contrast vector - cfg_entry
    inputs{47, crun} = 'fam2-nfam2_contrlScrmble'; % Contrast Manager: Name - cfg_entry
    inputs{48, crun} = [0 0 0 0 0 1 0 -1 0 0 0 0 0 -1 0 1]; % Contrast Manager: T contrast vector - cfg_entry
    
end

spm('defaults', 'FMRI');
spm_jobman('serial', jobs, '', inputs{:});
