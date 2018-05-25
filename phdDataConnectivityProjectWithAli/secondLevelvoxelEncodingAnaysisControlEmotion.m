function secondLevelvoxelEncodingAnaysisControlEmotion
% List of open inputs
% Factorial design specification: Directory - cfg_files
% Factorial design specification: Scans - cfg_files
% Contrast Manager: Name - cfg_entry
% Contrast Manager: Name - cfg_entry
dataName='emotion';
includedSubj =1:20;

rootDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\';
dataRootDir = 'D:\myStudy\picpairfMRI\';
subjDir=dir([dataRootDir,'s0*.*']);

contrastName={'fam1-scrmb','fam2-scrmbl','fam12-scrmbl12','fam1-nfam1','fam2-nfam2',...
    'fam12-nfam12','fam1-nfam1_scrmbl','fam2-nfam2_scrmbl','fam12-nfam1_scrmbl'};
contrastNum = [5 6 7 8 9 10 11 12 13];

jobfile = {'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\matlabFunctions\secondLevelvoxelBasedProcessingEncodingTask_job.m'};
jobs = repmat(jobfile, 1, 1);
inputs = cell(4, 1);
for nFolder = 1:length(contrastName)
    if length(includedSubj)<20 % only part of the sample is used, use another folder name
        if ~exist([rootDir,'secondLevelvoxelEncodingAnaysisControlEmotion\','onlyGoodMemSubj',contrastName{nFolder}],'dir')
            mkdir([rootDir,'secondLevelvoxelEncodingAnaysisControlEmotion\','onlyGoodMemSubj',contrastName{nFolder}]);
        end
        inputs{1,1} = {[rootDir,'secondLevelvoxelEncodingAnaysisControlEmotion\','onlyGoodMemSubj','\',contrastName{nFolder},'\']}; % Factorial design specification: Directory - cfg_files
    else
        if ~exist([rootDir,'secondLevelvoxelEncodingAnaysisControlEmotion\',contrastName{nFolder}],'dir')
            mkdir([rootDir,'secondLevelvoxelEncodingAnaysisControlEmotion\',contrastName{nFolder}]);
        end
        inputs{1,1} = {[rootDir,'secondLevelvoxelEncodingAnaysisControlEmotion\',contrastName{nFolder},'\']}; % Factorial design specification: Directory - cfg_files
    end
    
    %contrast image from first level analysis
    for n = 1:length(includedSubj)
        inputs{2, 1}(n) = {[dataRootDir,subjDir(includedSubj(n)).name,...
            '\encoding\analysis-',dataName,'Pmod-1','\con_',sprintf('%04d',contrastNum(nFolder)),'.img']};
        % Factorial design specification: Scans - cfg_files
    end
    inputs{3, 1} = [contrastName{nFolder},'  1']; % Contrast Manager: Name - cfg_entry
    inputs{4, 1} = [contrastName{nFolder},' -1']; % Contrast Manager: Name - cfg_entry
    spm('defaults', 'FMRI');
    spm_jobman('serial', jobs, '', inputs{:});
end %nfolder


