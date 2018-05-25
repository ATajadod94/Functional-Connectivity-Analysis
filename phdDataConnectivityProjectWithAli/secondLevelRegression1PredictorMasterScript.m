function secondLevelRegression1PredictorMasterScript(isCovari,memType)

rootDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\';
load([rootDir,'matlabFunctions\performanceDataConcatenated.mat']);

% *** fame effects ****


faceFam_NFam = faceMem.totalFam - faceMem.totalNFam;
houseFam_NFam = houseMem.totalFam - houseMem.totalNFam;
pairFam_NFam = pairMem.avgFam - pairMem.avgNFam;

if nargin==2 && memType == 1 % 1, precise memory, using recollection face, hous and intact pair memory
faceFam_NFam = faceMem.firstRecFam - faceMem.firstRecNFam;
houseFam_NFam = houseMem.firstRecFam - houseMem.firstRecNFam;
pairFam_NFam = pairMem.intactFam - pairMem.intactNFam;
end

contrastNum=2; % fame effect contrast from first level univariate analysis

memData = pairFam_NFam;
if isCovari ==1
   memData = covariMemData(memData);    
end

memNameStr = 'pairMemory';
outputPath = 'secondLevelReg\singleReg\pairFameEffect';
contrastNameStr1 = 'pairMemFameEff+';
contrastData1 = [0 0 0 1];
contrastNameStr2 = 'pairMemFameEff-';
contrastData2 = [0 0 0 -1];
secondLevelRegressionOnePredictorGeneral_withCov(contrastNum,...
                   memData,memNameStr,outputPath,contrastNameStr1,...
                   contrastData1,contrastNameStr2,contrastData2 );
               
outputPath = 'secondLevelReg\singleReg\faceFameEffect';               
memData = faceFam_NFam;
if isCovari ==1
   memData = covariMemData(memData);    
end
memNameStr = 'faceMemory';
contrastNameStr1 = 'faceMemFameEff+';
contrastData1 = [0 0 0 1];
contrastNameStr2 = 'faceMemFameEff-';
contrastData2 = [0 0 0 -1];
secondLevelRegressionOnePredictorGeneral_withCov(contrastNum,...
                   memData,memNameStr,outputPath,contrastNameStr1,...
                   contrastData1,contrastNameStr2,contrastData2 );  
               
outputPath = 'secondLevelReg\singleReg\houseFameEffect';
memData = houseFam_NFam;
if isCovari ==1
   memData = covariMemData(memData);    
end
memNameStr = 'houseMemory';
contrastNameStr1 = 'houseMemFameEff+';
contrastData1 = [0 0 0 1];
contrastNameStr2 = 'houseMemFameEff-';
contrastData2 = [0 0 0 -1];
secondLevelRegressionOnePredictorGeneral_withCov(contrastNum,...
                   memData,memNameStr,outputPath,contrastNameStr1,...
                   contrastData1,contrastNameStr2,contrastData2 );             
               
               
% ***** famous nonfmaou separately ****    

%*** famous ***

rootDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\';
load([rootDir,'matlabFunctions\performanceDataConcatenated.mat']);
contrastNum=13;

outputPath = 'secondLevelReg\singleReg\faceMemoryFam';
memData = faceMem.totalFam;

if nargin==2 && memType == 1 % 1, precise memory, using recollection face, hous and intact pair memory
memData = faceMem.firstRecFam;
end

if isCovari ==1
   memData = covariMemData(memData);    
end
memNameStr = 'faceMemoryFam';
contrastNameStr1 = 'faceMemFam+';
contrastData1 = [0 0 0 1];
contrastNameStr2 = 'faceMemFam-';
contrastData2 = [0 0 0 -1];
secondLevelRegressionOnePredictorGeneral_withCov(contrastNum,...
                   memData,memNameStr,outputPath,contrastNameStr1,...
                   contrastData1,contrastNameStr2,contrastData2 );

outputPath = 'secondLevelReg\singleReg\houseMemoryFam';
memData = houseMem.totalFam;

if nargin==2 && memType == 1 % 1, precise memory, using recollection face, hous and intact pair memory
memData = houseMem.firstRecFam;
end

if isCovari ==1
   memData = covariMemData(memData);    
end
memNameStr = 'houseMemoryFam';
contrastNameStr1 = 'houseMemFam+';
contrastData1 = [0 0 0 1];
contrastNameStr2 = 'houseMemFam-';
contrastData2 = [0 0 0 -1];
secondLevelRegressionOnePredictorGeneral_withCov(contrastNum,...
                   memData,memNameStr,outputPath,contrastNameStr1,...
                   contrastData1,contrastNameStr2,contrastData2 );
               
outputPath = 'secondLevelReg\singleReg\pairMemoryFam';               
memData = pairMem.avgFam;

if nargin==2 && memType == 1 % 1, precise memory, using recollection face, hous and intact pair memory
memData = pairMem.intactFam;
end

if isCovari ==1
   memData = covariMemData(memData);    
end
memNameStr = 'pairMemoryFam';
contrastNameStr1 = 'pairMemFam+';
contrastData1 = [0 0 0 1];
contrastNameStr2 = 'pairMemFam-';
contrastData2 = [0 0 0 -1];
secondLevelRegressionOnePredictorGeneral_withCov(contrastNum,...
                   memData,memNameStr,outputPath,contrastNameStr1,...
                   contrastData1,contrastNameStr2,contrastData2 ); 
               
% **** non famous condition             
rootDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\';
load([rootDir,'matlabFunctions\performanceDataConcatenated.mat']);
contrastNum=15;

outputPath = 'secondLevelReg\singleReg\faceMemoryNonFam';
memData = faceMem.totalNFam;

if nargin==2 && memType == 1 % 1, precise memory, using recollection face, hous and intact pair memory
memData = faceMem.firstRecNFam;
end

if isCovari ==1
   memData = covariMemData(memData);    
end
memNameStr = 'faceMemoryNFam';
contrastNameStr1 = 'faceMemNFam+';
contrastData1 = [0 0 0 1];
contrastNameStr2 = 'faceMemNFam-';
contrastData2 = [0 0 0 -1];
secondLevelRegressionOnePredictorGeneral_withCov(contrastNum,...
                   memData,memNameStr,outputPath,contrastNameStr1,...
                   contrastData1,contrastNameStr2,contrastData2 );

outputPath = 'secondLevelReg\singleReg\houseMemoryNonFam';
memData = houseMem.totalNFam;

if nargin==2 && memType == 1 % 1, precise memory, using recollection face, hous and intact pair memory
memData = houseMem.firstRecNFam;
end

if isCovari ==1
   memData = covariMemData(memData);    
end
memNameStr = 'houseMemoryNFam';
contrastNameStr1 = 'houseMemNFam+';
contrastData1 = [0 0 0 1];
contrastNameStr2 = 'houseMemNFam-';
contrastData2 = [0 0 0 -1];
secondLevelRegressionOnePredictorGeneral_withCov(contrastNum,...
                   memData,memNameStr,outputPath,contrastNameStr1,...
                   contrastData1,contrastNameStr2,contrastData2 );
               
outputPath = 'secondLevelReg\singleReg\pairMemoryNonFam';                
memData = pairMem.avgNFam;

if nargin==2 && memType == 1 % 1, precise memory, using recollection face, hous and intact pair memory
memData = pairMem.intactNFam;
end

if isCovari ==1
   memData = covariMemData(memData);    
end
memNameStr = 'pairMemoryNFam';
contrastNameStr1 = 'pairMemNFam+';
contrastData1 = [0 0 0 1];
contrastNameStr2 = 'pairMemNFam-';
contrastData2 = [0 0 0 -1];
secondLevelRegressionOnePredictorGeneral_withCov(contrastNum,...
                   memData,memNameStr,outputPath,contrastNameStr1,...
                   contrastData1,contrastNameStr2,contrastData2 ); 


% **** both famous and non famous condition             
rootDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\';
load([rootDir,'matlabFunctions\performanceDataConcatenated.mat']);
contrastNum=1;

outputPath = 'secondLevelReg\singleReg\faceMemoryFamAndNonFam';
memData = (faceMem.totalFam + faceMem.totalNFam)*.5;

if nargin==2 && memType == 1 % 1, precise memory, using recollection face, hous and intact pair memory
memData =  (faceMem.firstRecFam + faceMem.firstRecNFam)*.5;
end

if isCovari ==1
   memData = covariMemData(memData);    
end
memNameStr = 'faceMemoryFamNFam';
contrastNameStr1 = 'faceMemFamNFam+';
contrastData1 = [0 0 0 1];
contrastNameStr2 = 'faceMemFamNFam-';
contrastData2 = [0 0 0 -1];
secondLevelRegressionOnePredictorGeneral_withCov(contrastNum,...
                   memData,memNameStr,outputPath,contrastNameStr1,...
                   contrastData1,contrastNameStr2,contrastData2 );

outputPath = 'secondLevelReg\singleReg\houseMemoryFamAndNonFam';
memData = (houseMem.totalFam +houseMem.totalNFam)*.5;

if nargin==2 && memType == 1 % 1, precise memory, using recollection face, hous and intact pair memory
memData = (houseMem.firstRecFam +houseMem.firstRecNFam)*.5;
end

if isCovari ==1
   memData = covariMemData(memData);    
end
memNameStr = 'houseMemoryFamNFam';
contrastNameStr1 = 'houseMemFamNFam+';
contrastData1 = [0 0 0 1];
contrastNameStr2 = 'houseMemFamNFam-';
contrastData2 = [0 0 0 -1];
secondLevelRegressionOnePredictorGeneral_withCov(contrastNum,...
                   memData,memNameStr,outputPath,contrastNameStr1,...
                   contrastData1,contrastNameStr2,contrastData2 );
               
outputPath = 'secondLevelReg\singleReg\pairMemoryFamAndNonFam';                
memData = (pairMem.avgFam+pairMem.avgNFam)*.5;

if nargin==2 && memType == 1 % 1, precise memory, using recollection face, hous and intact pair memory
memData = (pairMem.intactFam +pairMem.intactNFam)*.5;
end

if isCovari ==1
   memData = covariMemData(memData);    
end
memNameStr = 'pairMemoryFamNFam';
contrastNameStr1 = 'pairMemFamNFam+';
contrastData1 = [0 0 0 1];
contrastNameStr2 = 'pairMemFamNFam-';
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