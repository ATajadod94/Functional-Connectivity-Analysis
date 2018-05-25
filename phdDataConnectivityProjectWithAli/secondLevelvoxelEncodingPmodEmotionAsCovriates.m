function secondLevelvoxelEncodingPmodEmotionAsCovriates
% List of open inputs
% Factorial design specification: Directory - cfg_files
% Factorial design specification: Scans - cfg_files
% Contrast Manager: Name - cfg_entry
% Contrast Manager: Name - cfg_entry

rootDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\';
dataRootDir = 'D:\myStudy\picpairfMRI\';
subjDir=dir([dataRootDir,'s0*.*']);
contrastName={'fam1','fam2','Fam12','fam1_2',...
        'NFam1','NFam2','NFam12','nfam1_2',...
        'Fam12-NFam12','fam1_nfam1','fam2_nfam2',...
        'MainEff_fam1-scrmb','MainEff_fam2-scrmb','MainEff_fam12-scrmb12',...
        'MainEff_fam1-nfam1','MainEff_fam2-nfam2','MainEff_fam12-nfam12',...
        'MainEff_fam1-nfam1_scrmble',...
        'MainEff_fam2-nfam2_scrmble',...
        'MainEff_fam12-nfam12_scrmble'};
jobfile = {'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\matlabFunctions\secondLevelvoxelBasedProcessingEncodingTask_job.m'};
jobs = repmat(jobfile, 1, 1);
% inputs = cell(2, 1);
for nFolder = 1:length(contrastName)
    if ~exist([rootDir,'secondLevelAnalysisEncodingPmodEmotionAsCovriates\',contrastName{nFolder}],'dir')
        mkdir([rootDir,'secondLevelAnalysisEncodingPmodEmotionAsCovriates\',contrastName{nFolder}]);
    end
    
    inputs{1,1} = {[rootDir,'secondLevelAnalysisEncodingPmodEmotionAsCovriates\',contrastName{nFolder},'\']}; % Factorial design specification: Directory - cfg_files
    for n = 1:length(subjDir)
        inputs{2, 1}(n) = {[dataRootDir,subjDir(n).name,'\encoding\analysis-emotionPmodEmotionAsCov-00\con_',sprintf('%04d',nFolder),'.img']};
        % Factorial design specification: Scans - cfg_files
    end
    inputs{3, 1} = [contrastName{nFolder},'  1']; % Contrast Manager: Name - cfg_entry
    inputs{4, 1} = [contrastName{nFolder},' -1']; % Contrast Manager: Name - cfg_entry
    spm('defaults', 'FMRI');
    spm_jobman('serial', jobs, '', inputs{:});
end %nfolder





