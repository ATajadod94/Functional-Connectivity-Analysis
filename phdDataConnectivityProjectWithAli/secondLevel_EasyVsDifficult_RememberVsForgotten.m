function secondLevel_EasyVsDifficult_RememberVsForgotten
% List of open inputs
% Factorial design specification: Directory - cfg_files
% Factorial design specification: Scans - cfg_files
% Contrast Manager: Name - cfg_entry
% Contrast Manager: Name - cfg_entry
load('D:\myStudy\picpairfMRI\s020\encoding\analysis-EasyDiffRemForgotten\SPM.mat');
rootDir = 'D:\myStudy\picpairfMRI\';
subjDir=dir([rootDir,'s0*.*']);
for i = 1:8
contrastName{i}=SPM.xCon(i).name;
end
jobfile = {'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\matlabFunctions\secondLevelvoxelBasedProcessingEncodingTask_job.m'};
jobs = repmat(jobfile, 1, 1);
inputs = cell(2, 1);
for nFolder = 1:length(contrastName)
    if ~exist([rootDir,'secondLevelAnalysis-EasyDiffRemForgotten\',contrastName{nFolder}],'dir')
        mkdir([rootDir,'secondLevelAnalysis-EasyDiffRemForgotten\',contrastName{nFolder}]);
    end
    
    inputs{1,1} = {[rootDir,'secondLevelAnalysis-EasyDiffRemForgotten\',contrastName{nFolder},'\']}; % Factorial design specification: Directory - cfg_files
    for n = 1:length(subjDir)
        inputs{2, 1}(n) = {[rootDir,subjDir(n).name,'\encoding\analysis-EasyDiffRemForgotten\con_',sprintf('%04d',nFolder),'.img']};
        % Factorial design specification: Scans - cfg_files
    end
    inputs{3, 1} = [contrastName{nFolder},'  1']; % Contrast Manager: Name - cfg_entry
    inputs{4, 1} = [contrastName{nFolder},' -1']; % Contrast Manager: Name - cfg_entry
    spm('defaults', 'FMRI');
    spm_jobman('serial', jobs, '', inputs{:});
end %nfolder





