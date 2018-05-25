function secondLevelvoxelForAddedPicScrambleContrast
% List of open inputs
% Factorial design specification: Directory - cfg_files
% Factorial design specification: Scans - cfg_files
% Contrast Manager: Name - cfg_entry
% Contrast Manager: Name - cfg_entry

rootDir = 'D:\myStudy\picpairfMRI\';
subjDir=dir([rootDir,'s0*.*']);
contrastName={'picEffect1_Pic1-Scramble1','picEffect2_Pic2-Scramble2'};
jobfile = {'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\matlabFunctions\secondLevelvoxelBasedProcessingEncodingTask_job.m'};
jobs = repmat(jobfile, 1, 1);
inputs = cell(2, 1);
for nFolder = 1:length(contrastName)
    if ~exist([rootDir,'secondLevelAnalysis\',contrastName{nFolder}],'dir')
        mkdir([rootDir,'secondLevelAnalysis\',contrastName{nFolder}]);
    end
    
    inputs{1,1} = {[rootDir,'secondLevelAnalysis\',contrastName{nFolder},'\']}; % Factorial design specification: Directory - cfg_files
    for n = 1:length(subjDir)
        inputs{2, 1}(n) = {[rootDir,subjDir(n).name,'\encoding\analysis\con_',sprintf('%04d',22+nFolder),'.img']};
        % Factorial design specification: Scans - cfg_files
    end
    inputs{3, 1} = [contrastName{nFolder},'  1']; % Contrast Manager: Name - cfg_entry
    inputs{4, 1} = [contrastName{nFolder},' -1']; % Contrast Manager: Name - cfg_entry
    spm('defaults', 'FMRI');
    spm_jobman('serial', jobs, '', inputs{:});
end %nfolder





