function secondLevelRegressionOnePredictorGeneral_withCov(contrastNum,...
                   memData,memNameStr,outputPath,contrastNameStr1,...
                   contrastData1,contrastNameStr2,contrastData2 )
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


rootDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\'; % for original calculation, the first level data was stored in C: drive. but now moved to D: drive. therefore this dir name has been changed.

dataRootDir = 'D:\myStudy\picpairfMRI\';
disp('please check the dataRootDir, whether it is')
disp(dataRootDir)

nrun = 1; % enter the number of runs here
subjDir=dir([dataRootDir,'s0*.*']);
jobfile = {[rootDir,'matlabFunctions\secondLevelRegressionOnePredictorGeneral_withCov_job.m']};
jobs = repmat(jobfile, 1, nrun);
inputs = cell(12, nrun);

[subjInfo a]=xlsread([rootDir,'matlabFunctions\picpairSubjInfo.xlsx']);
fameOrder = zeros(size(subjInfo,1),1);
fameOrder(1:2:end,1) = 1;
for crun = 1:nrun
    inputs{1, crun} = {[rootDir,outputPath]};% Factorial design specification: Directory - cfg_files
    if ~exist([rootDir,outputPath],'dir')
        mkdir([rootDir,outputPath]);
    end
    for n = 1:length(subjDir)
        inputs{2, crun}(n) = {[dataRootDir,subjDir(n).name,'\encoding\analysis\con_',sprintf('%04d',contrastNum),'.img']};
        % Factorial design specification: Scans - cfg_files
    end
    inputs{3, crun} = memData; % Factorial design specification: Vector - cfg_entry
    inputs{4, crun} = memNameStr; % Factorial design specification: Name - cfg_entry
    inputs{5, crun} = subjInfo(:,2); % Factorial design specification: Vector - cfg_entry
    inputs{6, crun} = 'age'; % Factorial design specification: Name - cfg_entry
    inputs{7, crun} = fameOrder; % Factorial design specification: Vector - cfg_entry
    inputs{8, crun} = 'fameOrder'; % Factorial design specification: Name - cfg_entry
    inputs{9, crun} = contrastNameStr1; % Contrast Manager: Name - cfg_entry
    inputs{10, crun} = contrastData1; % Contrast Manager: T contrast vector - cfg_entry
    inputs{11, crun} = contrastNameStr2; % Contrast Manager: Name - cfg_entry
    inputs{12, crun} = contrastData2; % Contrast Manager: T contrast vector - cfg_entry
   
end
spm('defaults', 'FMRI');
spm_jobman('serial', jobs, '', inputs{:});