function secondLevelvoxelBasedProcessingEncodingTask_ControOder
% List of open inputs
% Factorial design specification: Directory - cfg_files
% Factorial design specification: Scans - cfg_files
% Contrast Manager: Name - cfg_entry
% Contrast Manager: Name - cfg_entry
rootDir1 = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\';
rootDir = 'D:\myStudy\picpairfMRI\';
subjDir=dir([rootDir,'s0*.*']);
load('D:\myStudy\picpairfMRI\s001\encoding\analysis\SPM.mat');

jobfile = {'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\matlabFunctions\secondLevelvoxelBasedProcessingEncodingTask_ContrOder_job.m'};
jobs = repmat(jobfile, 1, 1);
inputs = cell(2, 1);
for nFolder = [1:16 19:20 23 24] % conntrast 17 18 are repeated from previous ones
    if ~exist([rootDir1,'secondLevelAnalysis-contrOrder\',SPM.xCon(nFolder).name],'dir')
        mkdir([rootDir1,'secondLevelAnalysis-contrOrder\',SPM.xCon(nFolder).name]);
    end
    
    inputs{1,1} = {[rootDir1,'secondLevelAnalysis-contrOrder\',SPM.xCon(nFolder).name,'\']}; % Factorial design specification: Directory - cfg_files
    for n = 1:length(subjDir)
        inputs{2, 1}(n) = {[rootDir,subjDir(n).name,'\encoding\analysis\con_',sprintf('%04d',nFolder),'.img']};
        % Factorial design specification: Scans - cfg_files
    end
    inputs{3, 1} = [SPM.xCon(nFolder).name,'  1']; % Contrast Manager: Name - cfg_entry
    inputs{4, 1} = [SPM.xCon(nFolder).name,' -1']; % Contrast Manager: Name - cfg_entry
    spm('defaults', 'FMRI');
    spm_jobman('serial', jobs, '', inputs{:});
end %nfolder





