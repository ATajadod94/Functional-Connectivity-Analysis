function secondLevelRegression1PredictorPairReinstMem(isCovari)

rootDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\';
load([rootDir,'matlabFunctions\performanceDataConcatenated.mat']);
load([rootDir,'matlabFunctions\reinstatementData.mat']);


% *** fame effects ****


faceFam_NFam = faceMem.totalFam - faceMem.totalNFam;
houseFam_NFam = houseMem.totalFam - houseMem.totalNFam;
pairFam_NFam = pairMem.avgFam - pairMem.avgNFam;

if nargin==2 && memType == 1 % 1, precise memory, using recollection face, hous and intact pair memory
faceFam_NFam = faceMem.firstRecFam - faceMem.firstRecNFam;
houseFam_NFam = houseMem.firstRecFam - houseMem.firstRecNFam;
pairFam_NFam = pairMem.intactFam - pairMem.intactNFam;
end


memData = pairFam_NFam;
if isCovari ==1
   memData = covariMemData(memData);    
end


contrastNum=13; % contrast from first level univariate analysis

memNameStr = 'pairReinstMemFam';
    
outputPath = 'secondLevelReg\singleReg\pairReinstMemFamEffect';               
memData = reinstatementData(:,6);
if isCovari ==1
   memData = covariMemData(memData);    
end
memNameStr = 'pairReinstFamMemory';
contrastNameStr1 = 'reinstEff+';
contrastData1 = [0 0 0 1];
contrastNameStr2 = 'reinstEff-';
contrastData2 = [0 0 0 -1];
secondLevelRegressionOnePredictorGeneral_withCov(contrastNum,...
                   memData,memNameStr,outputPath,contrastNameStr1,...
                   contrastData1,contrastNameStr2,contrastData2 );  
               
            
contrastNum=15; % contrast from first level univariate analysis

memNameStr = 'pairReinstMemNFam';
    
outputPath = 'secondLevelReg\singleReg\pairReinstMemNFamEffect';               
memData = reinstatementData(:,5);
if isCovari ==1
   memData = covariMemData(memData);    
end
memNameStr = 'pairReinstNFamMemory';
contrastNameStr1 = 'reinstEff+';
contrastData1 = [0 0 0 1];
contrastNameStr2 = 'reinstEff-';
contrastData2 = [0 0 0 -1];
secondLevelRegressionOnePredictorGeneral_withCov(contrastNum,...
                   memData,memNameStr,outputPath,contrastNameStr1,...
                   contrastData1,contrastNameStr2,contrastData2 );                
               
function memData = covariMemData(memData)
rootDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\';
[subjInfo a]=xlsread([rootDir,'matlabFunctions\picpairSubjInfo.xlsx']);
fameOrder = zeros(size(subjInfo,1),1);
fameOrder(1:2:end,1) = 1;
age = subjInfo(:,2);
gender  = subjInfo(:,3);
[a b memData]=regress(memData,[ones(size(subjInfo,1),1),...
    fameOrder]);



               
% rootDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\';
% load([rootDir,'matlabFunctions\performanceDataConcatenated.mat']);
% contrastNum=1;
% memData = .5*(faceMem.totalFam + faceMem.totalNFam);
% memNameStr = 'faceMemoryFamNFam';
% outputPath = 'secondLevelReg\singleReg\faceMemoryContr1';
% contrastNameStr1 = 'faceMemtotal+';
% contrastData1 = [0 0 0 1];
% contrastNameStr2 = 'faceMemtotal-';
% contrastData2 = [0 0 0 -1];
% secondLevelRegressionOnePredictorGeneral_withCov(contrastNum,...
%                    memData,memNameStr,outputPath,contrastNameStr1,...
%                    contrastData1,contrastNameStr2,contrastData2 )
%                
%                
%  rootDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\';
% load([rootDir,'matlabFunctions\performanceDataConcatenated.mat']);
% contrastNum=1;
% memData = .5*(houseMem.totalFam + houseMem.totalNFam);
% memNameStr = 'houseMemoryFamNFam';
% outputPath = 'secondLevelReg\singleReg\houseMemoryContr1';
% contrastNameStr1 = 'houseMemtotal+';
% contrastData1 = [0 0 0 1];
% contrastNameStr2 = 'houseMemtotal-';
% contrastData2 = [0 0 0 -1];
% secondLevelRegressionOnePredictorGeneral_withCov(contrastNum,...
%                    memData,memNameStr,outputPath,contrastNameStr1,...
%                    contrastData1,contrastNameStr2,contrastData2 )
%                
%                
%  rootDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\';
% load([rootDir,'matlabFunctions\performanceDataConcatenated.mat']);
% contrastNum=1;
% memData = .5*(pairMem.avgFam + pairMem.avgNFam);
% memNameStr = 'pairMemoryFamNFam';
% outputPath = 'secondLevelReg\singleReg\pairMemoryContr1';
% contrastNameStr1 = 'pairMemtotal+';
% contrastData1 = [0 0 0 1];
% contrastNameStr2 = 'pairMemtotal-';
% contrastData2 = [0 0 0 -1];
% secondLevelRegressionOnePredictorGeneral_withCov(contrastNum,...
%                    memData,memNameStr,outputPath,contrastNameStr1,...
%                    contrastData1,contrastNameStr2,contrastData2 )