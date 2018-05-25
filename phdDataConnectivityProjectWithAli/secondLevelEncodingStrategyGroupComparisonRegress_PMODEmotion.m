function secondLevelEncodingStrategyGroupComparisonRegress_PMODEmotion
% this function is modified from the memory group level regression analysis

allContrastNum = [1 2 3];
allContrastNames={'fam1','fam2','fam12'};
rootDir='C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\matlabFunctions\';
load([rootDir,'encodingStrategy.mat']);
memData = encodingStrategy;
memNameStr = 'encodingStrategy';
for contr = 1:length(allContrastNum)
contrastNum=allContrastNum(contr); % contrast from first level univariate analysis

outputPath = ['secondLevelReg\singleReg\encodingStrategyBinaryRegress_PMODEmotion\',allContrastNames{contr}];
contrastNameStr1 = [allContrastNames{contr},'+1'];
contrastData1 = [0 0 0 1];
contrastNameStr2 =  [allContrastNames{contr},'-1'];
contrastData2 = [0 0 0 -1];
secondLevelRegressionOnePredictorGeneral_withCov_pmod(contrastNum,...
                   memData,memNameStr,outputPath,contrastNameStr1,...
                   contrastData1,contrastNameStr2,contrastData2 );
end

function secondLevelRegressionOnePredictorGeneral_withCov_pmod(contrastNum,...
                   memData,memNameStr,outputPath,contrastNameStr1,...
                   contrastData1,contrastNameStr2,contrastData2 )

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
load('C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\matlabFunctions\excludedSessionForBinaryPmod.mat');
for crun = 1:nrun
    inputs{1, crun} = {[rootDir,outputPath]};% Factorial design specification: Directory - cfg_files
    if ~exist([rootDir,outputPath],'dir')
        mkdir([rootDir,outputPath]);
    end
                idExcl = excludeSession(find(excludeSession(:,2)==1),1);
    idIncld = setdiff(1:20,idExcl);
    for n = 1:length(idIncld)

        inputs{2, crun}(n) = {[dataRootDir,subjDir(idIncld(n)).name,'\encoding\analysis-emotionPmod-11\con_',sprintf('%04d',contrastNum),'.img']};
        % Factorial design specification: Scans - cfg_files
    end
    inputs{3, crun} = memData(idIncld); % Factorial design specification: Vector - cfg_entry
    inputs{4, crun} = memNameStr; % Factorial design specification: Name - cfg_entry
    inputs{5, crun} = subjInfo(idIncld,2); % Factorial design specification: Vector - cfg_entry
    inputs{6, crun} = 'age'; % Factorial design specification: Name - cfg_entry
    inputs{7, crun} = fameOrder(idIncld); % Factorial design specification: Vector - cfg_entry
    inputs{8, crun} = 'fameOrder'; % Factorial design specification: Name - cfg_entry
    inputs{9, crun} = contrastNameStr1; % Contrast Manager: Name - cfg_entry
    inputs{10, crun} = contrastData1; % Contrast Manager: T contrast vector - cfg_entry
    inputs{11, crun} = contrastNameStr2; % Contrast Manager: Name - cfg_entry
    inputs{12, crun} = contrastData2; % Contrast Manager: T contrast vector - cfg_entry
   
end
spm('defaults', 'FMRI');
spm_jobman('serial', jobs, '', inputs{:});