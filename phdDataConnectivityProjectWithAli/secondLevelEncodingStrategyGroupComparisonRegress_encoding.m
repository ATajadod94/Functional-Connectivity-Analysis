function secondLevelEncodingStrategyGroupComparisonRegress_encoding
% this function is modified from the memory group level regression analysis

allContrastNum = [1 2 9 10 11 12 13 15];
allContrastNames={'pic-scrmb','fam12-nfam12','fam1','fam2','nfam1','nfam2',...
    'fam12','nfam12'};
rootDir='C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\matlabFunctions\';
load([rootDir,'encodingStrategy.mat']);
memData = encodingStrategy;
memNameStr = 'encodingStrategy';
for contr = 1:length(allContrastNum)
contrastNum=allContrastNum(contr); % contrast from first level univariate analysis

outputPath = ['secondLevelReg\singleReg\encodingStrategyBinaryRegress_encoding\',allContrastNames{contr}];
contrastNameStr1 = [allContrastNames{contr},'+1'];
contrastData1 = [0 0 0 1];
contrastNameStr2 =  [allContrastNames{contr},'-1'];
contrastData2 = [0 0 0 -1];
secondLevelRegressionOnePredictorGeneral_withCov(contrastNum,...
                   memData,memNameStr,outputPath,contrastNameStr1,...
                   contrastData1,contrastNameStr2,contrastData2 );
end