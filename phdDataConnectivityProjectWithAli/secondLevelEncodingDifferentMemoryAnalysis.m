function secondLevelEncodingDifferentMemoryAnalysis(subID)
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
load('D:\myStudy\picpairfMRI\s001\encoding\analysis-DiffMemType\SPM.mat');
for i = 1:length(SPM.xCon)
contrastName{i}=SPM.xCon(i).name;
end
jobfile = {'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\matlabFunctions\secondLevelvoxelBasedProcessingEncodingTask_job.m'};
jobs = repmat(jobfile, 1, 1);
inputs = cell(4, 1);
% for nFolder = 1:length(contrastName)
for nFolder = 49:length(contrastName) %for newly added contrast
    if ~exist([rootDir,'secondLevelDifferentMem\',contrastName{nFolder}],'dir')
        mkdir([rootDir,'secondLevelDifferentMem\',contrastName{nFolder}]);
    end
    
    inputs{1,1} = {[rootDir,'secondLevelDifferentMem\',contrastName{nFolder},'\']}; % Factorial design specification: Directory - cfg_files
    for n = 1:length(subID)
        subj = subID(n);
        inputs{2, 1}(n) = {[rootDir1,subjDir(subj).name,'\encoding\analysis-DiffMemType\con_',sprintf('%04d',nFolder),'.img']};
        % Factorial design specification: Scans - cfg_files
    end
    inputs{3, 1} = [contrastName{nFolder},'  1']; % Contrast Manager: Name - cfg_entry
    inputs{4, 1} = [contrastName{nFolder},' -1']; % Contrast Manager: Name - cfg_entry
    spm('defaults', 'FMRI');
    spm_jobman('serial', jobs, '', inputs{:});
end %nfolder





