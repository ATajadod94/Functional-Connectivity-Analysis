function secondLevelFameEffRegressionFaceEval(contrastNum, faceEvalData,faceEvalName,outDir)
% List of open inputs
% Factorial design specification: Directory - cfg_files
% Factorial design specification: Scans - cfg_files
% Factorial design specification: Vector - cfg_entry
% Factorial design specification: Name - cfg_entry
% Factorial design specification: Vector - cfg_entry
% Factorial design specification: Name - cfg_entry
% Factorial design specification: Vector - cfg_entry
% Factorial design specification: Name - cfg_entry
% Contrast Manager: Name - cfg_entry
% Contrast Manager: T contrast vector - cfg_entry

rootDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\';
nrun = 1; % enter the number of runs here
subjDir=dir([rootDir,'s0*.*']);
jobfile = {[rootDir,'matlabFunctions\secondLevelRegressionFace_job.m']};
jobs = repmat(jobfile, 1, nrun);
inputs = cell(12, nrun);

[subjInfo a]=xlsread([rootDir,'matlabFunctions\picpairSubjInfo.xlsx']);
fameOrder = zeros(size(subjInfo,1),1);
fameOrder(1:2:end,1) = 1;
for crun = 1:nrun
    inputs{1, crun} = {[rootDir,'secondLevelReg\faceEvalReg\',outDir]};% Factorial design specification: Directory - cfg_files
    if ~exist([rootDir,'secondLevelReg\faceEvalReg\',outDir],'dir')
        mkdir([rootDir,'secondLevelReg\faceEvalReg\',outDir]);
    end
    for n = 1:length(subjDir)
        inputs{2, crun}(n) = {[rootDir,subjDir(n).name,'\encoding\analysis\con_',sprintf('%04d',contrastNum),'.img']};
        % Factorial design specification: Scans - cfg_files
    end
    inputs{3, crun} = faceEvalData; % Factorial design specification: Vector - cfg_entry
    inputs{4, crun} = faceEvalName; % Factorial design specification: Name - cfg_entry
    inputs{5, crun} = subjInfo(:,2); % Factorial design specification: Vector - cfg_entry
    inputs{6, crun} = 'age'; % Factorial design specification: Name - cfg_entry
    inputs{7, crun} = fameOrder; % Factorial design specification: Vector - cfg_entry
    inputs{8, crun} = 'fameOrder'; % Factorial design specification: Name - cfg_entry
    inputs{9, crun} = 'FameEff+1'; % Contrast Manager: Name - cfg_entry
    inputs{10, crun} = [0 0 0 1]; % Contrast Manager: T contrast vector - cfg_entry
    inputs{11, crun} = 'FameEff-1'; % Contrast Manager: Name - cfg_entry
    inputs{12, crun} = [0 0 0 -1]; % Contrast Manager: T contrast vector - cfg_entry
end
spm('defaults', 'FMRI');
spm_jobman('serial', jobs, '', inputs{:});