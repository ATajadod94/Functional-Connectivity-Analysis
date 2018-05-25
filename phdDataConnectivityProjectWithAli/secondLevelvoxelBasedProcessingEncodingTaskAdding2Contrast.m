function secondLevelvoxelBasedProcessingEncodingTaskAdding2Contrast
% List of open inputs
% Factorial design specification: Directory - cfg_files
% Factorial design specification: Scans - cfg_files
% Contrast Manager: Name - cfg_entry
% Contrast Manager: Name - cfg_entry

rootDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\';
subjDir=dir([rootDir,'s0*.*']);
contrastName={'picEffect_Pic-Scramble','famEffect_Fam-NonFam','repetitionEffect_1-2',...
    'picEffect_Scramble-Pic','famEffect_NonFam-Fam','repetitionEffect_2-1',...
    'repititionInter_Fam12-NonFam12','repititionInter_Fam21-NonFam21',...
    'Fam1','Fam2','NonFam1','NonFam2','Fam1+Fam2','Fam1-Fam2','NFam1+NFam2','NFam1-NFam2',...
    'deleted','deleted','Fam1-NFam1','Fam2-NFam2'};
jobfile = {'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\matlabFunctions\secondLevelvoxelBasedProcessingEncodingTask_job.m'};
jobs = repmat(jobfile, 1, 1);
inputs = cell(2, 1);
for nFolder = [19 20]
    if ~exist([rootDir,'secondLevelAnalysis\',contrastName{nFolder}],'dir')
        mkdir([rootDir,'secondLevelAnalysis\',contrastName{nFolder}]);
    end
    
    inputs{1,1} = {[rootDir,'secondLevelAnalysis\',contrastName{nFolder},'\']}; % Factorial design specification: Directory - cfg_files
    for n = 1:length(subjDir)
        inputs{2, 1}(n) = {[rootDir,subjDir(n).name,'\encoding\analysis\con_',sprintf('%04d',nFolder),'.img']};
        % Factorial design specification: Scans - cfg_files
    end
    inputs{3, 1} = [contrastName{nFolder},'  1']; % Contrast Manager: Name - cfg_entry
    inputs{4, 1} = [contrastName{nFolder},' -1']; % Contrast Manager: Name - cfg_entry
    spm('defaults', 'FMRI');
    spm_jobman('serial', jobs, '', inputs{:});
end %nfolder





