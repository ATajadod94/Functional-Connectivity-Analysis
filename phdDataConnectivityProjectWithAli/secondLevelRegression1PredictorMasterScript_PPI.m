function secondLevelRegression1PredictorMasterScript_PPI(isCovari,memType,roiName)

rootDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\';
load([rootDir,'matlabFunctions\performanceDataConcatenated.mat']);
outputPath = ['secondLevelReg_PPI\',roiName, '\pairMemoryFam'];               
memData = pairMem.avgFam;

if memType == 1 % 1, precise memory, using recollection face, hous and intact pair memory
memData = pairMem.intactFam;
end

if isCovari ==1
   memData = covariMemData(memData);    
end
contrastNum='fam1+fam2';
memNameStr = 'pairMemoryFam';
contrastNameStr1 = 'pairMemFam+';
contrastData1 = [0 0 0 1];
contrastNameStr2 = 'pairMemFam-';
contrastData2 = [0 0 0 -1];
secondLevelRegressionOnePredictorGeneral_PPI_withCov(contrastNum,...
                   memData,memNameStr,outputPath,contrastNameStr1,...
                   contrastData1,contrastNameStr2,contrastData2 ,roiName); 
               
               

outputPath = ['secondLevelReg_PPI\',roiName, '\pairMemoryNonFam'];                
memData = pairMem.avgNFam;

if memType == 1 % 1, precise memory, using recollection face, hous and intact pair memory
memData = pairMem.intactNFam;
end

if isCovari ==1
   memData = covariMemData(memData);    
end


contrastNum='nonfam1+nonfam2';
memNameStr = 'pairMemoryNFam';
contrastNameStr1 = 'pairMemNFam+';
contrastData1 = [0 0 0 1];
contrastNameStr2 = 'pairMemNFam-';
contrastData2 = [0 0 0 -1];
secondLevelRegressionOnePredictorGeneral_PPI_withCov(contrastNum,...
                   memData,memNameStr,outputPath,contrastNameStr1,...
                   contrastData1,contrastNameStr2,contrastData2,roiName ); 
                              
 
rootDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\';
load([rootDir,'matlabFunctions\performanceDataConcatenated.mat']);
outputPath = ['secondLevelReg_PPI\',roiName, '\pairMemoryFamNonFam']; 

contrastNum= 'pic-scrmble';

memData = .5*(pairMem.avgFam + pairMem.avgNFam);

if memType == 1 % 1, precise memory, using recollection face, hous and intact pair memory
memData = .5*(pairMem.intactFam+pairMem.intactNFam);
end

memNameStr = 'pairMemoryFamNFam';

contrastNameStr1 = 'pairMemtotal+';
contrastData1 = [0 0 0 1];
contrastNameStr2 = 'pairMemtotal-';
contrastData2 = [0 0 0 -1];
secondLevelRegressionOnePredictorGeneral_PPI_withCov(contrastNum,...
                   memData,memNameStr,outputPath,contrastNameStr1,...
                   contrastData1,contrastNameStr2,contrastData2,roiName )               
               
               
               
               
               
function memData = covariMemData(memData)
rootDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\';
[subjInfo a]=xlsread([rootDir,'matlabFunctions\picpairSubjInfo.xlsx']);
fameOrder = zeros(size(subjInfo,1),1);
fameOrder(1:2:end,1) = 1;
age = subjInfo(:,2);
gender  = subjInfo(:,3);
[a b memData]=regress(memData,[ones(size(subjInfo,1),1),...
    fameOrder]);