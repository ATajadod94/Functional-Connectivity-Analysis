dataRootDir = 'D:\myStudy\picpairfMRI\';
crun=1;
inputs{1, crun} ={'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelReg\easyDiffVsMem\'};% Factorial design specification: Directory - cfg_files
if ~exist(inputs{1},'dir')
    mkdir(inputs{1});
end
load(['C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\matlabFunctions\easyDiffiPicScrmbleIncludedSubj.mat']);
load(['C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\matlabFunctions\performanceDataConcatenated.mat']);
[subjInfo a]=xlsread(['C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\matlabFunctions\picpairSubjInfo.xlsx']);
fameOrder = zeros(size(subjInfo,1),1);
fameOrder(1:2:end,1) = 1;
jobfile = {['C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\matlabFunctions\secondLevelRegressionOnePredictorGeneral_withCov_job.m']};
jobs = repmat(jobfile, 1, 1);



memData=.5*(pairMem.intactFam + pairMem.intactNFam);
memNameStr = 'pairMemIntactFamNfam';
contrastNameStr1 = 'pairMem+';
contrastData1 = [0 0 0 1];
contrastNameStr2 = 'pairMem-';
contrastData2 = [0 0 0 -1];

fameOrder=fameOrder(idIncluded,:);
subjInfo = subjInfo(idIncluded,:);
memData = memData(idIncluded,:);

for n = 1:length(idIncluded)
    inputs{2, crun}(n) = {[dataRootDir,'s',sprintf('%03d',idIncluded(n)),'\encoding\analysis-easyDifficultPic&ScrmPmod-0\con_0025.img']};
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
spm('defaults', 'FMRI');
spm_jobman('serial', jobs, '', inputs{:});