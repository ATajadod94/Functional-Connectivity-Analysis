function secondLevelvoxelPmodAnaysis_NoOrthog(dataName,isFamOnly,includedSubj)
% List of open inputs
% Factorial design specification: Directory - cfg_files
% Factorial design specification: Scans - cfg_files
% Contrast Manager: Name - cfg_entry
% Contrast Manager: Name - cfg_entry
if nargin ==2
    includedSubj =1:20;
end
rootDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\';
rootDir1 = 'D:\myStudy\picpairfMRI\';

subjDir=dir([rootDir1,'s0*.*']);
if isFamOnly==0
    contrastName={'fam1','fam2','Fam12','fam1_2',...
        'NFam1','NFam2','NFam12','nfam1_2',...
        'Fam12-NFam12','fam1_nfam1','fam2_nfam2'};
    contrastNum = [1 2 3 4 5 6 7 8 9 10 11];
else
    contrastName={'fam1','fam2','Fam12','fam1_2'};
    contrastNum = [1 2 3 4];
end

jobfile = {'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\matlabFunctions\secondLevelvoxelBasedProcessingEncodingTask_job.m'};
jobs = repmat(jobfile, 1, 1);
inputs = cell(4, 1);
for nFolder = 1:length(contrastName)
    if length(includedSubj)<20 % only part of the sample is used, use another folder name
        if ~exist([rootDir,'secondLevelPmodAnalysis\',dataName,'onlyGoodMemSubj','_NoOrthog\',contrastName{nFolder}],'dir')
            mkdir([rootDir,'secondLevelPmodAnalysis\',dataName,'onlyGoodMemSubj','_NoOrthog\',contrastName{nFolder}]);
        end
        inputs{1,1} = {[rootDir,'secondLevelPmodAnalysis\',dataName,'onlyGoodMemSubj','_NoOrthog\',contrastName{nFolder},'\']}; % Factorial design specification: Directory - cfg_files
    else
        if ~exist([rootDir,'secondLevelPmodAnalysis\',dataName,'_NoOrthog\',contrastName{nFolder}],'dir')
            mkdir([rootDir,'secondLevelPmodAnalysis\',dataName,'_NoOrthog\',contrastName{nFolder}]);
        end
        inputs{1,1} = {[rootDir,'secondLevelPmodAnalysis\',dataName,'_NoOrthog\',contrastName{nFolder},'\']}; % Factorial design specification: Directory - cfg_files
    end
    
    %contrast image from first level analysis
    for n = 1:length(includedSubj)
        inputs{2, 1}(n) = {[rootDir1,subjDir(includedSubj(n)).name,...
            '\encoding\analysis-',dataName,'Pmod-',num2str(isFamOnly),'_NoOrthog\con_',sprintf('%04d',contrastNum(nFolder)),'.img']};
        % Factorial design specification: Scans - cfg_files
    end
    inputs{3, 1} = [contrastName{nFolder},'  1']; % Contrast Manager: Name - cfg_entry
    inputs{4, 1} = [contrastName{nFolder},' -1']; % Contrast Manager: Name - cfg_entry
    spm('defaults', 'FMRI');
    spm_jobman('serial', jobs, '', inputs{:});
end %nfolder





