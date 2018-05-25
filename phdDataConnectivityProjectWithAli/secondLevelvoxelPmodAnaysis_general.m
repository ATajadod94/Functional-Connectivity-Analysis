function secondLevelvoxelPmodAnaysis_general(dataName,isFamOnly,isBinarized,includedSubj)
% List of open inputs
% Factorial design specification: Directory - cfg_files
% Factorial design specification: Scans - cfg_files
% Contrast Manager: Name - cfg_entry
% Contrast Manager: Name - cfg_entry
if nargin ==3
    includedSubj =1:20;
end
rootDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\';
rootDir1 = 'D:\myStudy\picpairfMRI\';

subjDir=dir([rootDir1,'s0*.*']);
load(['D:\myStudy\picpairfMRI\s001\encoding\analysis-',[cat(2,dataName{:}),'Pmod-',num2str(sum(isFamOnly)),num2str(isBinarized)],'\SPM.mat']);
for i = 1:length(SPM.xCon)
contrastName{i}=SPM.xCon(i).name;
end
jobfile = {'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\matlabFunctions\secondLevelvoxelBasedProcessingEncodingTask_job.m'};
jobs = repmat(jobfile, 1, 1);
inputs = cell(4, 1);
for nFolder = 1:length(contrastName)
    if length(includedSubj)<20 % only part of the sample is used, use another folder name
        if ~exist([rootDir,'secondLevelPmodAnalysis\',cat(2,dataName{:}),'onlyGoodMemSubj','\',contrastName{nFolder}],'dir')
            mkdir([rootDir,'secondLevelPmodAnalysis\',cat(2,dataName{:}),'onlyGoodMemSubj','\',contrastName{nFolder}]);
        end
        inputs{1,1} = {[rootDir,'secondLevelPmodAnalysis\',cat(2,dataName{:}),'onlyGoodMemSubj','\',contrastName{nFolder},'\']}; % Factorial design specification: Directory - cfg_files
    else
        if ~exist([rootDir,'secondLevelPmodAnalysis\',cat(2,dataName{:}),'\',contrastName{nFolder}],'dir')
            mkdir([rootDir,'secondLevelPmodAnalysis\',cat(2,dataName{:}),'\',contrastName{nFolder}]);
        end
        inputs{1,1} = {[rootDir,'secondLevelPmodAnalysis\',cat(2,dataName{:}),'\',contrastName{nFolder},'\']}; % Factorial design specification: Directory - cfg_files
    end
    
    %contrast image from first level analysis
    for n = 1:length(includedSubj)
        inputs{2, 1}(n) = {[rootDir1,subjDir(includedSubj(n)).name,...
            '\encoding\analysis-',cat(2,dataName{:}),'Pmod-',num2str(sum(isFamOnly)),num2str(isBinarized),'\con_',sprintf('%04d',nFolder),'.img']};
        % Factorial design specification: Scans - cfg_files
    end
    inputs{3, 1} = [contrastName{nFolder},'  1']; % Contrast Manager: Name - cfg_entry
    inputs{4, 1} = [contrastName{nFolder},' -1']; % Contrast Manager: Name - cfg_entry
    spm('defaults', 'FMRI');
    spm_jobman('serial', jobs, '', inputs{:});
end %nfolder





