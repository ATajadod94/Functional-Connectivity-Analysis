rootDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\';

load([rootDir,'matlabFunctions\faceEvalMTotal.mat']);

familiarityFam_NFam = faceEvalMTotal.familiarity(:,1) - faceEvalMTotal.familiarity(:,3);
emotionFam_NFam = faceEvalMTotal.emotion(:,1) - faceEvalMTotal.emotion(:,3);
memoryFam_NFam = faceEvalMTotal.memory(:,1);
attractivenessFam_NFam = faceEvalMTotal.attractiveness(:,1) - faceEvalMTotal.attractiveness(:,3);
outDir = 'familiarityFameEff';
contrastNum = 2;
faceEvalData = familiarityFam_NFam;
faceEvalName = 'familiarityFame';
secondLevelFameEffRegressionFaceEval(contrastNum, faceEvalData,faceEvalName,outDir);

outDir = 'emotionFameEff';
contrastNum = 2;
faceEvalData = emotionFam_NFam;
faceEvalName = 'emotionFame';
secondLevelFameEffRegressionFaceEval(contrastNum, faceEvalData,faceEvalName,outDir);

outDir = 'memoryFameEff';
contrastNum = 2;
faceEvalData = memoryFam_NFam;
faceEvalName = 'memoryFame';
secondLevelFameEffRegressionFaceEval(contrastNum, faceEvalData,faceEvalName,outDir);

outDir = 'attractivenessFameEff';
contrastNum = 2;
faceEvalData = attractivenessFam_NFam;
faceEvalName = 'attractivenessFame';
secondLevelFameEffRegressionFaceEval(contrastNum, faceEvalData,faceEvalName,outDir);