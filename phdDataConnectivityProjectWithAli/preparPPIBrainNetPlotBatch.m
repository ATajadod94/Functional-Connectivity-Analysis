function preparPPIBrainNetPlotBatch
rootDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\matlabFunctions';
outFileName = fullfile(rootDir,'RL-HPC-PPI-nonfam');
fileL = ['C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelPPIAnalysis\L_HPC\fam-nonfam\',...
    'L-HPC-PPInonfam-fam005_10dataForMakingResultForms.mat'];

fileR = ['C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelPPIAnalysis\R_HPC\fam-nonfam\',...
    'PPInonfam-fam005_10dataForMakingResultForms.mat'];
prepareNodeEdgeFiles(fileL, fileR, outFileName);

% surfDir='C:\Users\Zhongxu\Documents\MATLAB\myMatLabTools\majorNeuroImagingTools\BrainNetViewer\Data\SurfTemplate';
% BrainNet(fullfile(surfDir,'BrainMesh_ICBM152_smoothed_tal.nv'),...
%      fullfile(rootDir, [outFileName,'.node.txt']),...
%      fullfile(rootDir, [outFileName,'.edge.txt']),...
%      fullfile(rootDir,'ppi-fameEffect-confg-152tal.mat'));


%ppi subsequent memory 
rootDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\matlabFunctions';
outFileName = fullfile(rootDir,'RL-HPC-PPI-fam');
fileL = ['C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelPPIAnalysis\L_HPC\fam-nonfam\',...
    'L-HPC-PPIfam-nonfam005_10dataForMakingResultForms.mat'];

fileR = ['C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelPPIAnalysis\R_HPC\fam-nonfam\',...
    'PPIfam-nfam005_10dataForMakingResultForms.mat'];
prepareNodeEdgeFiles(fileL, fileR, outFileName);


rootDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\matlabFunctions';
outFileName = fullfile(rootDir,'RL-HPC-PPI-subsequentMem-fam05');
fileL = ['C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelPPIAnalysisSubsequentMem\L_HPC\rem-nonrem-fm\',...
    'PPI-subsequentMemFam-LHPC-05_10dataForMakingResultForms.mat'];

fileR = ['C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelPPIAnalysisSubsequentMem\R_HPC\rem-nonrem-fm\',...
    'PPI-subsequentMemFam-RHPC-05_10dataForMakingResultForms.mat'];
prepareNodeEdgeFiles(fileL, fileR, outFileName);


rootDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\matlabFunctions';
outFileName = fullfile(rootDir,'RL-HPC-PPI-subsequentMem-nonfam05');
fileL = ['C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelPPIAnalysisSubsequentMem\L_HPC\rem-nonrem-nfm\',...
    'PPI-subsequentMemNonFam-LHPC-05_10dataForMakingResultForms.mat'];

fileR = ['C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelPPIAnalysisSubsequentMem\R_HPC\rem-nonrem-nfm\',...
    'PPI-subsequentMemNonFam-RHPC-05_10dataForMakingResultForms.mat'];
prepareNodeEdgeFiles(fileL, fileR, outFileName);

%.005
rootDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\matlabFunctions';
outFileName = fullfile(rootDir,'RL-HPC-PPI-subsequentMem-nonfam005');
fileL = ['C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelPPIAnalysisSubsequentMem\L_HPC\rem-nonrem-nfm\',...
    'PPI-subsequentMemNonFam-LHPC-005_10dataForMakingResultForms.mat'];

fileR = ['C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelPPIAnalysisSubsequentMem\R_HPC\rem-nonrem-nfm\',...
    'PPI-subsequentMemNonFam-RHPC-005_10dataForMakingResultForms.mat'];
prepareNodeEdgeFiles(fileL, fileR, outFileName);



%PPI regression
ootDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\matlabFunctions';
outFileName = fullfile(rootDir,'RL-HPC-PPI-RegressionMem-fam05');
fileL = ['C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelPPIAnalysisSubsequentMem\L_HPC\rem-nonrem-fm\',...
    'PPI-subsequentMemFam-LHPC-05_10dataForMakingResultForms.mat'];

fileR = ['C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelPPIAnalysisSubsequentMem\R_HPC\rem-nonrem-fm\',...
    'PPI-subsequentMemFam-RHPC-05_10dataForMakingResultForms.mat'];
prepareNodeEdgeFiles(fileL, fileR, outFileName);


rootDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\matlabFunctions';
outFileName = fullfile(rootDir,'RL-HPC-PPI-RegressionMem-nonfam05');
fileL = ['C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelPPIAnalysisSubsequentMem\L_HPC\rem-nonrem-nfm\',...
    'PPI-subsequentMemNonFam-LHPC-05_10dataForMakingResultForms.mat'];

fileR = ['C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelPPIAnalysisSubsequentMem\R_HPC\rem-nonrem-nfm\',...
    'PPI-subsequentMemNonFam-RHPC-05_10dataForMakingResultForms.mat'];
prepareNodeEdgeFiles(fileL, fileR, outFileName);

