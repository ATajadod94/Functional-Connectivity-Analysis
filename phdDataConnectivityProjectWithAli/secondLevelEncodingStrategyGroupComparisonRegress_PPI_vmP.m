function secondLevelEncodingStrategyGroupComparisonRegress_PPI_vmP
% this function is modified from the memory group level regression analysis

allContrastNum = [1 2 9 10 11 12 13 15];
allContrastNames={'con_PPI_pic-scrmble_s',...
    'con_PPI_fam-nonfam_s',...    
    'con_PPI_fam1_s',...
    'con_PPI_fam2_s',...
    'con_PPI_nonfam1_s',...
    'con_PPI_nonfam2_s',...
    'con_PPI_fam1+fam2_s',...
    'con_PPI_nonfam1+nonfam2_s'};
rootDir='C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\matlabFunctions\';
load([rootDir,'encodingStrategy.mat']);
memData = encodingStrategy;
memNameStr = 'encodingStrategy';
dataRootDir = 'D:\myStudy\picpairfMRI\';
dataSubDir = 'encoding\analysis\PPI_L_vmP\';
for contr = 1:length(allContrastNum)
contrastNum=allContrastNum(contr); % contrast from first level univariate analysis

outputPath = ['secondLevelReg\singleReg\encodingStrategyBinaryRegress_PPI_L_vmP\',allContrastNames{contr}];
contrastNameStr1 = [allContrastNames{contr},'+1'];
contrastData1 = [0 0 0 1];
contrastNameStr2 =  [allContrastNames{contr},'-1'];
contrastData2 = [0 0 0 -1];
secondLevelRegressionOnePredictorGeneral_withCov_inputDir(allContrastNames{contr},...
                   memData,memNameStr,outputPath,dataRootDir,dataSubDir,contrastNameStr1,...
                   contrastData1,contrastNameStr2,contrastData2 );
end

dataSubDir = 'encoding\analysis\PPI_R_vmP\';

for contr = 1:length(allContrastNum)
contrastNum=allContrastNum(contr); % contrast from first level univariate analysis

outputPath = ['secondLevelReg\singleReg\encodingStrategyBinaryRegress_PPI_R_vmP\',allContrastNames{contr}];
contrastNameStr1 = [allContrastNames{contr},'+1'];
contrastData1 = [0 0 0 1];
contrastNameStr2 =  [allContrastNames{contr},'-1'];
contrastData2 = [0 0 0 -1];
secondLevelRegressionOnePredictorGeneral_withCov_inputDir(allContrastNames{contr},...
                   memData,memNameStr,outputPath,dataRootDir,dataSubDir,contrastNameStr1,...
                   contrastData1,contrastNameStr2,contrastData2 );
end
