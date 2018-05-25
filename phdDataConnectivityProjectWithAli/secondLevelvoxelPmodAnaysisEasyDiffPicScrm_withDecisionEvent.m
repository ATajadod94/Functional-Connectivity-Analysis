function secondLevelvoxelPmodAnaysisEasyDiffPicScrm_withDecisionEvent(dataName,isFamOnly,includedSubj)
% List of open inputs
% Factorial design specification: Directory - cfg_files
% Factorial design specification: Scans - cfg_files
% Contrast Manager: Name - cfg_entry
% Contrast Manager: Name - cfg_entry
if nargin ==2
    includedSubj =1:20;
end
rootDir = 'D:\myStudy\picpairfMRI\';
subjDir=dir([rootDir,'s0*.*']);
if isFamOnly==0
    contrastName={'fam1','fam1-scrmble','fam2','fam2-scrmble',...
        'fam12','fam1_2','fam12_scrmble','fam1-2-scrmble',...
        'nfam1','nfam1-scrmble','nfam2','nfam2-scrmble',...
        'nfam12','nfam1_2','nfam12-scrmble','nfam1-2-scrmble',...
        'fam12-nfam12','fam12-nfam12_controlScrmble',...
        'fam1_nfam1','fam1-nfam1_contrlScrmble',...
        'fam2_nfam2','fam2-nfam2_contrlScrmble',...
        'fam12_contrlScrmble','nfam12_contrlScrmble','famnfam12',...
        'famnfamscrmble_12','famnfam12_contrlScrmble'};
    for k = 1:27
        contrastName{27+k}=[contrastName{k},'-dcs'];
    end
    contrastNum = [1:54];
else
    contrastName={'fam1','fam2','Fam12','fam1_2'};
    contrastNum = [1 2 3 4];
end

jobfile = {'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\matlabFunctions\secondLevelvoxelBasedProcessingEncodingTask_job.m'};
jobs = repmat(jobfile, 1, 1);
inputs = cell(4, 1);
for nFolder = 21:length(contrastName)
    if length(includedSubj)<20 % only part of the sample is used, use another folder name
        if ~exist([rootDir,'secondLevelPmodAnalysis\',dataName,'onlyGoodMemSubj','\',contrastName{nFolder}],'dir')
            mkdir([rootDir,'secondLevelPmodAnalysis\',dataName,'onlyGoodMemSubj','\',contrastName{nFolder}]);
        end
        inputs{1,1} = {[rootDir,'secondLevelPmodAnalysis\',dataName,'onlyGoodMemSubj','\',contrastName{nFolder},'\']}; % Factorial design specification: Directory - cfg_files
    else
        if ~exist([rootDir,'secondLevelPmodAnalysis\',dataName,'\',contrastName{nFolder}],'dir')
            mkdir([rootDir,'secondLevelPmodAnalysis\',dataName,'\',contrastName{nFolder}]);
        end
        inputs{1,1} = {[rootDir,'secondLevelPmodAnalysis\',dataName,'\',contrastName{nFolder},'\']}; % Factorial design specification: Directory - cfg_files
    end
    
    %contrast image from first level analysis
    for n = 1:length(includedSubj)
        inputs{2, 1}(n,1) = {[rootDir,subjDir(includedSubj(n)).name,...
            '\encoding\analysis-',dataName,'\con_',sprintf('%04d',contrastNum(nFolder)),'.img']};
        % Factorial design specification: Scans - cfg_files
    end
    inputs{3, 1} = [contrastName{nFolder},'  1']; % Contrast Manager: Name - cfg_entry
    inputs{4, 1} = [contrastName{nFolder},' -1']; % Contrast Manager: Name - cfg_entry
    spm('defaults', 'FMRI');
    spm_jobman('serial', jobs, '', inputs{:});
end %nfolder





