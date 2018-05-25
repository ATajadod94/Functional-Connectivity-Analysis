function secondLevelEncodingTaskSubsequentMemoryAnalysis(subID)
% List of open inputs
% Factorial design specification: Directory - cfg_files
% Factorial design specification: Scans - cfg_files
% Contrast Manager: Name - cfg_entry
% Contrast Manager: Name - cfg_entry

rootDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\';
rootDir1 = 'D:\myStudy\picpairfMRI\';

subjDir=dir([rootDir1,'s0*.*']);
% contrastName={'remPic-Scramble','remFameEff_fam-nonfam','remFam',...
%     'remNonFam','remFamRep','remNonFamRep','Fam1Rem-nonRem',...
%     'Fam2Rem-nonRem','Fam12Rem-nonRem','NonFam1Rem-nonRem',...
%     'NonFam2Rem-nonRem','NonFam12Rem-nonRem','fameSubseqEffectfam-nonfam'};
contrastName={'nonremFam','nonremNonFam','nonremFam1',...
    'nonremNonFam1','nonremFam2','nonremNonFam2','remFam1',...
    'remNonFam1','remFam2','remNonFam2',...
    'nonremFamRep','nonremNonFamRep'};
jobfile = {'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\matlabFunctions\secondLevelvoxelBasedProcessingEncodingTask_job.m'};
jobs = repmat(jobfile, 1, 1);
inputs = cell(4, 1);
% for nFolder = 1:length(contrastName)
for nFolder = 1:length(contrastName)
    if ~exist([rootDir,'secondLevelSubsequentMemoryAnalysis\',contrastName{nFolder}],'dir')
        mkdir([rootDir,'secondLevelSubsequentMemoryAnalysis\',contrastName{nFolder}]);
    end
    
    inputs{1,1} = {[rootDir,'secondLevelSubsequentMemoryAnalysis\',contrastName{nFolder},'\']}; % Factorial design specification: Directory - cfg_files
    for n = 1:length(subID)
        subj = subID(n);
        inputs{2, 1}(n) = {[rootDir1,subjDir(subj).name,'\encoding\analysis-subsequentMemory\con_',sprintf('%04d',14+nFolder),'.img']};
        % Factorial design specification: Scans - cfg_files
    end
    inputs{3, 1} = [contrastName{nFolder},'  1']; % Contrast Manager: Name - cfg_entry
    inputs{4, 1} = [contrastName{nFolder},' -1']; % Contrast Manager: Name - cfg_entry
    spm('defaults', 'FMRI');
    spm_jobman('serial', jobs, '', inputs{:});
end %nfolder





