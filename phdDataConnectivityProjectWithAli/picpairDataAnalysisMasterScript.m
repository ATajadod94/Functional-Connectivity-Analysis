% ***** the first 6 participant dec 31,2012
% subID = [1:6]
% nSub = length(subID);
% runGlobalReg = 1;
% for i = 1: nSub
%     setupFolders(subID(i));
%     concatenateMotionData(subID(i),runGlobalReg);
%     concatenateTaskRuns(subID(i));
%     firstlevelAnalysisBasic(subID(i));
% end

subID=[7:15];
% setup the folders
nSub = length(subID);
for i = 1: nSub
    setupFolders(subID(i));
end

%convert dicom to img/hdr
for i = 1:nSub
    convertDICOM(subID(i));
end

for i = 1:nSub
    deleteFirstNVol(subID(i));
end

% ****** NEED stop here !!!!!!!!!!!!!!!!!!!!!!
% *****!!!! Set origin to AC !!!!!!!% manually!!!!!***************

for i = 1:nSub
    preprocessingAllRuns(subID(i));
end

%*************** check head movement and normalization quality!!**********
runGlobalReg =1;
for i = 1:nSub
    % make sure the perfomrance eprime txt data have been copied to
    % perfomranceData folder !!!!!
    plotCheckHeadMotionUsingRelignmentData(subID(i));
    
    % concatenate motion data to multiregressor file (according to fame order)
    concatenateMotionData(subID(i),runGlobalReg);
end
%check whether need to regressout spike movement: optional
%            regressOutSpikeMovement
% concatenate task runs 5 6 8 9 according to fameorder
for i = 1:nSub
    concatenateTaskRuns(subID(i));
end

%******* delete useless processing files
subID=[1:15];
nSub = length(subID);
for i = 1:nSub
    deleteUnusedFiles(subID(i));
end

% run first level analysis
subID=[7:15];
nSub = length(subID);
for i = 1:nSub
    firstlevelAnalysisBasic(subID(i));
end

%******* localizer processing

subID=[1:15];
nSub = length(subID);
for i = 1:nSub
    makeLocalizerMulticondFile(subID(i));
    localizerProcessing(subID(i));
end


%***** single participant processing pipeline*****************************
%**************************************************************************
%*************************************************************************
subID= 20%[18 19]%[17]%[16];
% setup the folders
nSub = length(subID);
for i = 1: nSub
    setupFolders(subID(i));
end

for i = 1:nSub
    convertDICOM(subID(i));
end

for i = 1:nSub
    deleteFirstNVol(subID(i));
end

% ****** NEED stop here !!!!!!!!!!!!!!!!!!!!!!********************
% *****!!!! Set origin to AC !!!!!!!% manually!!!!!***************

for i = 1:nSub
    preprocessingAllRuns(subID(i));
end

%** check head movement and normalization quality!! manually******
runGlobalReg =1;
for i = 1:nSub
    % make sure the perfomrance eprime txt data have been copied to
    % perfomranceData folder !!!!!
    plotCheckHeadMotionUsingRelignmentData(subID(i));
    
    % concatenate motion data to multiregressor file (according to fame order)
    concatenateMotionData(subID(i),runGlobalReg);
end

%***check whether need to regressout spike movement: optional
%           using regressOutSpikeMovement

% concatenate task runs 5 6 8 9 according to fameorder
for i = 1:nSub
    concatenateTaskRuns(subID(i));
end

%******* delete useless processing files
for i = 1:nSub
    deleteUnusedFiles(subID(i));
end

% run first level analysis
nSub = length(subID);
for i = 1:nSub
    firstlevelAnalysisBasic(subID(i));
end
%add contrast fam1 2 nonfam 1 2
for i = 1:nSub
    adding4IndividualConditionContrast(subID(i));
    adding4MoreContrastRepetitionAdditionSubtraction(subID(i));
end

%******* localizer processing
for i = 1:nSub
    makeLocalizerMulticondFile(subID(i));
    localizerProcessing(subID(i));
end

%*************************************************************************
%****** behavioral data processing****************************************

subID=1:20% [1:19]%[1:17]%[16];

nSub = length(subID);
for i = 1: nSub
    disp(i)
    performanceData{i} = getRetrievalSummaryData(subID(i));  %get summary performace data for group level regression analysis
    getRetrievalDataUpdated(subID(i));  % get data for making design matrix or parameter modulation
    %getRetrievalData(subID(i));
    
end
save(['C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\matlabFunctions\',...
    'performanceData.mat'],'performanceData');
% put individual participants data togeter, which can be used a regressor
% in brain-behavioral correlation analyses
load(['C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\matlabFunctions\',...
    'performanceData.mat']);
[faceMem houseMem pairMem memPCA]= concatenatePerformanceData(performanceData);
save(['C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\matlabFunctions\',...
    'performanceDataConcatenated.mat'],'faceMem','houseMem','pairMem','memPCA');
%**************************************************************************
% *************************************************************************
%adding contrast fam1 2 nonfam1 2 separately for subject 1:17
subID=1:17;
nSub = length(subID);

%add contrast fam1 2 nonfam 1 2
for i = 1:nSub
    adding4IndividualConditionContrast(subID(i));
end

subID=1:19;
nSub = length(subID);
for i = 1:nSub
    adding4MoreContrastRepetitionAdditionSubtraction(subID(i));
end

subID=20% 2:19;
nSub = length(subID);
for i = 1:nSub
    adding4ConditionContrasts(subID(i));
end

%**************************************************************************
%***********    prepost encoding correlation analysis *********************
%**************************************************************************


subID=20%18:19%1:17;
nSub = length(subID);


for i = 1:nSub
    disp(i)
    copyRestingFiles(subID(i));
end
for i = 1:nSub
    disp(i)
    copyRestingMotionParameterFiles(subID(i));
end

%normalize wm gm, and csf for each subj, which will serve as masks for rest correlation analyses
subID=20%18:19 %1:17;
nSub = length(subID);
for i = 1:nSub
    disp(i)
    normalizeGrayWhiteCSF(subID(i));
end




% process face evaluation data and seve group data in matlabfunction folder
subID=1:20;
nSub = length(subID);
% remember! the 4 filling pics for each cond were not evaluated
for i = 1:nSub
    disp(i)
    faceEvalM = getFaceEvaluationData(subID(i));
    faceEvalMTotal.familiarity(i,:) = faceEvalM.familiarity;
    faceEvalMTotal.emotion(i,:) = faceEvalM.emotion;
    faceEvalMTotal.memory(i,:) = faceEvalM.memory;
    faceEvalMTotal.attractiveness(i,:) = faceEvalM.attractiveness;
    save(['C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\matlabFunctions\'...
        'faceEvalMTotal.mat'],'faceEvalMTotal');
end

% process face evaluation data and seve group data in matlabfunction folder
subID=1:20;
nSub = length(subID);
% remember! the 4 filling pics for each cond were not evaluated
for i = 1:nSub
    disp(i)
    [picsEvalM scrmEvalM] = getEncodingEasyDifficultEvaluationData(subID(i));
    picsEvalMTotal(i,:) = picsEvalM;
    scrmEvalMTotal(i,:) = scrmEvalM;
    save(['C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\matlabFunctions\'...
        'encodingEasyDiffEvalMTotal.mat'],'picsEvalMTotal','scrmEvalMTotal');
end



%************************ parametric modulation first level****************
%**************************************************************************

% only fam condition parametric modulation
subID = 20%1:19;
nSub = length(subID);
dataNames = {'memory','emotion','familiarity','attractiveness','performance'};
for i = 1:nSub
    disp(i)
    for k = 1:5
        makeMultiPmodFile(subID(i), dataNames{k},1);
        firstlevelPmodFamousOnly(subID(i),dataNames{k},1);
    end
end

% both fam and nonfam condition parametric modulation
subID = 20;
nSub = length(subID);
isFamOnly =0;
dataNames = {'easyDifficult','performance'};
for i = 1:nSub
    disp(i)
    for k = 1:2
        makeMultiPmodFile(subID(i), dataNames{k},isFamOnly);
        firstlevelPmodBothFamNFam(subID(i),dataNames{k},isFamOnly);
    end
end

subID = 20;
nSub = length(subID);
isFamOnly =0;
dataNames = {'easyDifficult','performance'};
for i = 1:nSub
    disp(i)
    for k = 1:2
        makeMultiPmodFile(subID(i), dataNames{k},isFamOnly);
        firstlevelPmodBothFamNFam(subID(i),dataNames{k},isFamOnly);
    end
end

% do pmod analysis for both fam nonfam condition 
subID = 1:20;
nSub = length(subID);
for i = 2:nSub
    disp(i)
    
           firstlevelPmodEasyDiffControlMemory(subID(i),'easyDifficultControMem');
           
end

[idBlockE idBlockD idExclude] = getMemoryPerformanceForEachTrial([0 1 2]);
idIn = 1:20;
idIn = idIn(logical(1-idExclude));
for i = idIn
    disp(i)
    
      firstlevelPmodEasyDiffControlMemory(i,'easyDifficultControMem_012');
           
end

secondLevelvoxelPmodEasyDiffControlMemory;

clear all;

subID=1:20;
nSub = length(subID);
projDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\s';
maskNames = {'WM','CSF'};
for i = 1:nSub
    disp(i)
    creatTimeSeriesUsingRex(subID(i),180);
    maskFiles{1} = [projDir,sprintf('%03d',subID(i)),'\scanImgData\run_0003\wc2vol_0001.img'];
    maskFiles{2} = [projDir,sprintf('%03d',subID(i)),'\scanImgData\run_0003\wc3vol_0001.img'];
    creatTimeSeriesUsingRexGeneral(subID(i),...
        '_WM_CSF', maskNames,maskFiles,180);
end

clear all;
%**************************************************************************
%************    second level univariate processing brain data  ***********
%**************************************************************************
secondLevelvoxelBasedProcessingEncodingTask;
secondLevelvoxelBasedProcessingEncodingTaskAdding2Contrast;
secondLevelMaskedVoxelBasedProcessingEncodingTask; % only use the five ROIs
secondLevelvoxelBasedProcessingLocalizerTask;
clear all;
secondLevelMaskedVoxelBasedProcessingEncodingTask; % only use gray matter

%**************************************************************************
%**********  second level brain-memory (total Memory)regression analysis***
%**************************************************************************
secondLevelRegression3PredictorsFameEffect_withCov(0);% 0 memroy perfomrance is not covariated out fame order
secondLevelRegression3PredictorsNonFamCond_withCov(0);
secondLevelRegression3PredictorsFamCond_withCov(0);
secondLevelRegression1PredictorMasterScript(1);% 1: memroy perfomrance is covariated out fame order
clear all;

%**************************************************************************
%**************  second level paramteric modulation analysis ************
%**************************************************************************
dataNames = {'memory','emotion','familiarity','attractiveness',...
    'easyDifficult','performance'};
isFamOnly = [1 0 0 0 0 0];

for i = 1:6
    secondLevelvoxelPmodAnaysis(dataNames{i},isFamOnly(i));
end
clear all;
%******** prePost correlations*****************************************
subID=1:20;
nSub = length(subID);
for i = 1:nSub
    disp(i)
    creatTimeSeriesUsingRex(subID(i),180);
end

% postfam vs nonfam
%control covariates
[p tval a b c] = prepostEncodingCorr(1:20,0,1);
[p tval a b c] = prepostEncodingCorr(1:20,1,1);
[p tval a b c] = prepostEncodingCorr(1:20,2,1);
[p tval a b c] = prepostEncodingCorr(1:20,3,1);
% no control covariates
[p tval a b c] = prepostEncodingCorr(1:20,0,0);
[p tval a b c] = prepostEncodingCorr(1:20,1,0);
[p tval a b c] = prepostEncodingCorr(1:20,2,0);
[p tval a b c] = prepostEncodingCorr(1:20,3,0);

%postFam vs baseline
%control covariates
[p tval a b c] = prepostFamEncodingCorr(1:20,0,1);
[p tval a b c] = prepostFamEncodingCorr(1:20,1,1);
[p tval a b c] = prepostFamEncodingCorr(1:20,2,1);
[p tval a b c] = prepostFamEncodingCorr(1:20,3,1);
% no control covariates
[p tval a b c] = prepostFamEncodingCorr(1:20,0,0);
[p tval a b c] = prepostFamEncodingCorr(1:20,1,0);
[p tval a b c] = prepostFamEncodingCorr(1:20,2,0);
[p tval a b c] = prepostFamEncodingCorr(1:20,3,0);

%postNonFam vs baseline
%control covariates
[p tval a b c] = prepostNonFamEncodingCorr(1:20,0,1);
[p tval a b c] = prepostNonFamEncodingCorr(1:20,1,1);
[p tval a b c] = prepostNonFamEncodingCorr(1:20,2,1);
[p tval a b c] = prepostNonFamEncodingCorr(1:20,3,1);
% no control covariates
[p tval a b c] = prepostNonFamEncodingCorr(1:20,0,0);
[p tval a b c] = prepostNonFamEncodingCorr(1:20,1,0);
[p tval a b c] = prepostNonFamEncodingCorr(1:20,2,0);
[p tval a b c] = prepostNonFamEncodingCorr(1:20,3,0);

% calculate left right separately
[p tval a b c] = prepostEncodingCorr(1:20,3,0);
[p tval a b c] = prepostFamEncodingCorr(1:20,3,0);
[p tval a b c] = prepostNonFamEncodingCorr(1:20,3,0);

[p tval a b c] = prepostEncodingCorr(1:20,3,1);
[p tval a b c] = prepostFamEncodingCorr(1:20,3,1);
[p tval a b c] = prepostNonFamEncodingCorr(1:20,3,1);

% Need to change folder names of the previous calculation otherwise, it will be rewritten by the following calculations
filterBand = [.001,.08];
[p tval a b c] = prepostEncodingCorr(1:20,3,0,filterBand);
[p tval a b c] =prepostFamEncodingCorr(1:20,3,0,filterBand);
[p tval a b c] =prepostNonFamEncodingCorr(1:20,3,0,filterBand);


%**********************************************************************
%***************** encoding correlation using residual data********************

subID=1:20;
nSub = length(subID);
for i = 1:nSub
    disp(i)
    creatTimeSeriesUsingRexForEncoding(subID(i),287);
end
[p tval famCorrGrpLR nonfamCorrGrpLR] = ...
    EncodingCorr5ROIs(1:20,'restTimeS.mat',3,0);


%**********************************************************************
%***************** encoding correlation using original data*******************

subID=1:20;
nSub = length(subID);
for i = 1:nSub
    disp(i)
    creatTimeSeriesUsingRexForEncodingNotResidual(subID(i),287);
end
[p tval famCorrGrpLR nonfamCorrGrpLR] = ...
    EncodingCorrUsingOriginalData5ROIs(1:20,'restTimeSNotResi.mat',3,1);




%**************************************************************************
%***** subsequent memory analsyis
subID=1:20;
nSub = length(subID);
for i = 1:nSub
    disp(i)
    makeMultiCondMatFileUsingMemeorPerformanceData(subID(i),'performance',0);
    firstlevelSubsequentMemoryAnalysisBasic(subID(i),'subsequentMemory','performance',0);
end

% adding contrast to subsequent memory analysis
%add 4 contrasts
subID = 1:20
nSub = length(subID);
for i = 1:nSub
    addingContrastToSubsequentMemoryAnalysis(subID(i));
end
%add 3 more contrasts
subID = 1:20
nSub = length(subID);
for i = 1:nSub
    addingContrastToSubsequentMemoryAnalysis3more(subID(i));
end

%*************************************************************************
%******************* get encoding residual*********************************
subID=1:20;
nSub = length(subID);
for i = 1:nSub
    firstlevelAnalysisBasicForResidual(i);
end

% ***** subsequent memory analysis second level***************************
%*************************************************************************
% calculate remembered trial count
subID=1:20;
nSub = length(subID);
for i = 1:nSub
    [a b associativeCountFam(i) d e associativeCountNFam(i)]=getMemoryTrialCount(i,1);
end

idFamDel = find(associativeCountFam<5);
idNFamDel = find(associativeCountNFam<5);
idDel = union(idFamDel, idNFamDel);
idIncluded = setdiff(1:20,idDel);
%second level analysis using subject with more than 10 trials, 5 in each
%encoding
secondLevelEncodingTaskSubsequentMemoryAnalysis(idIncluded);
%*************************************************************************
% redo pmod analysis performance using subjects with at least 5
% remembered trials
secondLevelvoxelPmodAnaysis('performance',0,idIncluded);


%******* first level pmod face evaluation analysis using binary coding

subID = 1:20;
nSub = length(subID);
isFamOnly =[1 1 1 1];
isBinarized=1;
dataNames = {'emotion','familiarity','attractiveness','memory'};
numExcl = 0;
for i = 1:nSub
    disp(i)
    for k =1: 4
        subjPmod = makeMultiPmodFile(subID(i), dataNames{k},isFamOnly(k),isBinarized);
        if isempty(find(cell2mat(subjPmod(1).param) ==1)==1) ||isempty(find(cell2mat(subjPmod(1).param) ==-1)==1)
            numExcl = numExcl+1;
            excludeSession(numExcl,1)=subID(i);
            excludeSession(numExcl,2)=k;
            continue;
        end
        firstlevelPmodFamousOnly(subID(i),dataNames{k},isFamOnly(k),isBinarized);
    end
end
save('C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\matlabFunctions\excludedSessionForBinaryPmod.mat',...
    'excludeSession');
%**************************************************************************
%**************  second level binary paramteric modulation analysis *******
%**************************************************************************
dataNames = {'emotion','familiarity','attractiveness','memory'}; % the order of the dataNames SHOULD NOT BE CHANGED because the excluded ID is calculatedd in this order
isFamOnly = [1 1 1 1];
load('C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\matlabFunctions\excludedSessionForBinaryPmod.mat');
for i = 1:4
    idExcl = excludeSession(find(excludeSession(:,2)==i),1);
    idIncld = setdiff(1:20,idExcl);
    secondLevelvoxelPmodAnaysis_Binary(dataNames{i},isFamOnly(i),idIncld);
end

%**************************************************************************
%**************  second level brain-memory regression analysis ************
%***********************  first & second encoding separately***************
secondLevelRegression3PredictorsFameEffect_withCov_Encoding1(1);% 0 memroy perfomrance is not covariated out fame order
secondLevelRegression3PredictorsFameEffect_withCov_Encoding2(1);% 0 memroy perfomrance is not covariated out fame order

secondLevelRegression3PredictorsNonFamCond_withCov_Encoding1(1);
secondLevelRegression3PredictorsNonFamCond_withCov_Encoding2(1);

secondLevelRegression3PredictorsFamCond_withCov_Encoding1(1);
secondLevelRegression3PredictorsFamCond_withCov_Encoding2(1);

secondLevelRegression1PredictorMasterScript_Encoding1(1);% 1: memroy perfomrance is covariated out fame order
secondLevelRegression1PredictorMasterScript_Encoding2(1);% 1: memroy perfomrance is covariated out fame order


% firstlevel analysis for getting beta seriers

firstLevelSingleTrialBetaSeries([1,3:20]);

%adding f contrast to main encoding analysis in order to extract roi time
%series e ppi analysis
subID=[1:3 5:20]; % s004 has been done when i testing the procedure, therefore should not be redone
adding_F_ContrastToMainEncodingAnaysisForPPI(subID);

%**************************************************************************
%******************* first level PPI **************************************
%**************************************************************************

%***** first level PPI using L_PPA as seeds*
ppi_wrapper_encodingPsy(1,2,20);

%***** first level PPI using R_PPA as seeds*
ppi_wrapper_encodingPsy(2,1,20);

%***** first level PPI using L_FFA as seeds*
ppi_wrapper_encodingPsy(3,1,20);

%***** first level PPI using R_FFA as seeds*
ppi_wrapper_encodingPsy(4,1,20);

%**************************************************************************
%************************* second level PPI  ******************************
%**************************************************************************

%***** second level PPI using L_PPA as seeds*
secondLevelEncodingTaskPPIAnalysis('L_PPA',1:20);

%***** second level PPI using R_PPA as seeds*
secondLevelEncodingTaskPPIAnalysis('R_PPA',1:20);

%***** second level PPI using L_FFA as seeds*
secondLevelEncodingTaskPPIAnalysis('L_FFA',1:20);

%***** second level PPI using R_FFA as seeds*
secondLevelEncodingTaskPPIAnalysis('R_FFA',1:20);


%**************************************************************************
%**********  second level brain-memory (precise Memory)regression analysis***
%**************************************************************************
secondLevelRegression3PredictorsFameEffect_withCov(0,1);% 0 memroy perfomrance is not covariated out fame order
secondLevelRegression3PredictorsNonFamCond_withCov(0,1);
secondLevelRegression3PredictorsFamCond_withCov(0,1);
secondLevelRegression1PredictorMasterScript(0,1);% 1: memroy perfomrance is covariated out fame order

%**************************************************************************
%****************** VBM analysis******************************************

firstLevelVBMAnalysis(1:20);
vbmQualityCheckHomogeneity;
%another quaility check using gui VBMQualityCheckDisplay
%precise memory both famous and nonfamous perfomrance (averaged).1 control
%fame order, 1, precise memory
secondLevelVBMAnalysis(1:20, 1,1,'house','famnonfam');
secondLevelVBMAnalysis(1:20, 1,1,'face','famnonfam');
secondLevelVBMAnalysis(1:20, 1,1,'pair','famnonfam');

%precise memory nonfamous perfomrance .1 control
%fame order, 1, precise memory
secondLevelVBMAnalysis(1:20, 1,1,'house','nonfam');
secondLevelVBMAnalysis(1:20, 1,1,'face','nonfam');
secondLevelVBMAnalysis(1:20, 1,1,'pair','nonfam');

%precise memory famous perfomrance .1 control
%fame order, 1, precise memory
secondLevelVBMAnalysis(1:20, 1,1,'house','fam');
secondLevelVBMAnalysis(1:20, 1,1,'face','fam');
secondLevelVBMAnalysis(1:20, 1,1,'pair','fam');


%*************************************************************************
%************ pmod analysis easydifficult trials for both pic and scrm****
for i = 1:20
    [minTrialCount(i),pmod] = makeMultiPmodEasiNessFile(i, 'easyDifficultPic&Scrm',0);
%     if minTrialCount(i)>5
%         firstlevelPmodBothFamNFamEasyDiffPicScrm(i, 'easyDifficultPic&Scrm',0);
%     end
end


% idDel = find(minTrialCount<5);
% idIncluded = setdiff(1:20,idDel);
% %second level analysis using subject with more than 10 trials, 5 in each
% %encoding
% secondLevelvoxelPmodAnaysisEasyDiffPicScrm('easyDifficultPic&Scrm',0,idIncluded);

% adding contrasts
load('C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\matlabFunctions\easyDiffiPicScrmbleIncludedSubj.mat');
for i = 1:length(idIncluded)
    addingContrastForEasyDiffiPicScrmble(idIncluded(i), 'easyDifficultPic&Scrm',0);
end

secondLevelvoxelPmodAnaysisEasyDiffPicScrm('easyDifficultPic&Scrm',0,idIncluded);



%add events of "decision making" August 31,2016
%************ pmod analysis easydifficult trials for both pic and scrm****
addpath C:\Users\Zhongxu\Documents\MATLAB\myMatLabTools\spmwrapperlib
addpath C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\matlabFunctions
for i = 1:20
    [minTrialCount(i),pmod] = makeMultiPmodEasiNessFile(i, 'easyDifficultPic&Scrm',0);
%      if minTrialCount(i)>5
%       makeMultiPmodEasiNessFile_withDecisionEvent(i)
%       firstlevelPmodBothFamNFamEasyDiffPicScrm_withDecisionEvent(i, 'easyDifficultPic&ScrmmultiCondPmod-EncodingRespond16Conds',0);
%      end
end


idDel = find(minTrialCount<5);
idIncluded = setdiff(1:20,idDel);

% adding contrasts
load('C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\matlabFunctions\easyDiffiPicScrmbleIncludedSubj.mat');
for i = 1:length(idIncluded)
    addingContrastForEasyDiffiPicScrmble_withDecisionEvent(idIncluded(i), 'easyDifficultPic&ScrmmultiCondPmod-EncodingRespond16Conds');
end

secondLevelvoxelPmodAnaysisEasyDiffPicScrm_withDecisionEvent('easyDifficultPic&ScrmmultiCondPmod-EncodingRespond16Conds',0,idIncluded);


%****************************************************************************
%*********************** PPI ananlysis (HPC vmP TMP preCun as roi)*********

regions={'L_HPC','R_HPC','L_aHC','R_aHC','L_mHC','R_mHC','L_pHC','R_pHC',...
    'L_preCun','R_preCun','L_TMP','R_TMP','L_vmP','R_vmP'};

for i = 9:14
    ppi_wrapper_encodingPsyAddHPCetal(i,1,20);
    secondLevelEncodingTaskPPIAnalysis(regions{i},1:20);
end


%***************** plot surface data***************************************
%**************************************************************************

% ***** parametric modulation analysis: easy vs. difficult trials

% easy > difficult trials controlling for scrambled (perceputal) pairs
inputDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelPmodAnalysis\easyDifficultPic&ScrmonlyGoodMemSubj\famnfam12_contrlScrmble\';
dataTImage = [inputDir, 'spmT_0001.img'];
savefigName = 'famnfam12-scrm12';
savefigNote = [dataTImage,'___',savefigName,'____easy > difficult controlling for scramble pairs'];
outDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\easyDiffFigures\';
makeBrainNetSurfacePlot(dataTImage,savefigName,savefigNote,outDir,...
    2.95, 6,'MediumView', 10);

% easy > difficult for face-house associative encoding pairs
inputDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelPmodAnalysis\easyDifficultPic&ScrmonlyGoodMemSubj\famnfam12\';
dataTImage = [inputDir, 'spmT_0001.img'];
savefigName = 'famnfam12';
savefigNote = [dataTImage,'___',savefigName,'____easy-difficult for face-house pairs'];
outDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\easyDiffFigures\';
makeBrainNetSurfacePlot(dataTImage,savefigName,savefigNote,outDir,...
    2.95, 6,'MediumView+', 10);

% easy > difficult for scrambled pairs
inputDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelPmodAnalysis\easyDifficultPic&ScrmonlyGoodMemSubj\famnfamscrmble_12\';
dataTImage = [inputDir, 'spmT_0001.img'];
savefigName = 'famnfamScramble12';
savefigNote = [dataTImage,'___',savefigName,'____easy-difficult for scrambled pairs'];
outDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\easyDiffFigures\';
makeBrainNetSurfacePlot(dataTImage,savefigName,savefigNote,outDir,...
    2.95, 6,'MediumView+', 10);



% easy > difficult for face-house associative encoding pairs
inputDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelPmodAnalysis\easyDifficultPic&ScrmonlyGoodMemSubj\famnfam12\';
dataTImage = [inputDir, 'spmT_0001.img'];
savefigName = 'famnfam12easydiff001';
savefigNote = [dataTImage,'___',savefigName,'____easy-difficult for face-house pairs'];
outDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\easyDiffFigures\';
makeBrainNetSurfacePlot(dataTImage,savefigName,savefigNote,outDir,...
   3.73, 6,'MediumView', 10);

% easy > difficult for scrambled pairs
inputDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelPmodAnalysis\easyDifficultPic&ScrmonlyGoodMemSubj\famnfamscrmble_12\';
dataTImage = [inputDir, 'spmT_0001.img'];
savefigName = 'famnfamScramble12easydiff001';
savefigNote = [dataTImage,'___',savefigName,'____easy-difficult for scrambled pairs'];
outDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\easyDiffFigures\';
makeBrainNetSurfacePlot(dataTImage,savefigName,savefigNote,outDir,...
    3.73, 6,'MediumView', 10);



xSPM.swd       = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelPmodAnalysis\easyDifficultPic&ScrmonlyGoodMemSubj\famnfam12\';
;
xSPM.Ic        = 1; % index of contrast
xSPM.n         = 1; % conjunction number (next update)
xSPM.u         = 0.005;
xSPM.Im        =[]; % if no masking
% if need masking
% xSPM.Im        = {'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelAnalysis\picEffect_Pic-Scramble\L_HPC.img'};
% xSPM.Ex        = 0; % 0 inclusive 1, exclusive
xSPM.thresDesc = 'none'; % 'FWE', or 'FDR'-if using FDR defaults.stats.topFDR need be changed from 1 to 0
xSPM.title     = '';
xSPM.k         = 10;
xSPM.units     = {'mm' 'mm' 'mm'};
defaultCor     = [24 -14 -18]; % for right hippocampus
% encodingFam_nonfam005_10= batchProduceOutputFigAndTable(xSPM,defaultCor,0,'encodingFam_nonfam005_10');
encodingFam_nonfam005_10= batchProduceOutputFigAndTable(xSPM,defaultCor,1,'encodingFam_nonfam005_10');


xSPM.swd       = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelPmodAnalysis\easyDifficultPic&ScrmonlyGoodMemSubj\famnfam12\';
xSPM.Ic        = 2; % index of contrast
xSPM.n         = 1; % conjunction number (next update)
xSPM.u         = 0.005;
xSPM.Im        =[]; % if no masking
% if need masking
% xSPM.Im        = {'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelAnalysis\picEffect_Pic-Scramble\L_HPC.img'};
% xSPM.Ex        = 0; % 0 inclusive 1, exclusive
xSPM.thresDesc = 'none'; % 'FWE', or 'FDR'-if using FDR defaults.stats.topFDR need be changed from 1 to 0
xSPM.title     = '';
xSPM.k         = 10;
xSPM.units     = {'mm' 'mm' 'mm'};
defaultCor     = [24 -14 -18]; % for right hippocampus
% encodingFam_nonfam005_10= batchProduceOutputFigAndTable(xSPM,defaultCor,0,'encodingFam_nonfam005_10');
encodingFam_nonfam005_10= batchProduceOutputFigAndTable(xSPM,defaultCor,1,'encodingFam_nonfam005_10_Diff-Easy');

plotEasyDiffTrialCountsAndPairMemPerformance;


%**************************************************************************

inputDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelPmodAnalysisBinary\memory\Fam12\';
dataTImage = [inputDir, 'spmT_0001.img'];
% p=.005 threshold
savefigName = 'PMOD-MemoryBinary-positive-005';
savefigNote = [dataTImage,'___',savefigName,'____high Memory > low memory p = .005'];
outDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\picPairFigures\';
makeBrainNetSurfacePlot(dataTImage,savefigName,savefigNote,outDir,...
    2.861, 6,'MediumView', 10);

% p=.05 threshold
savefigName = 'PMOD-MemoryBinary-positive-05';
savefigNote = [dataTImage,'___',savefigName,'____high Memory > low memory p = .05'];
outDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\picPairFigures\';
makeBrainNetSurfacePlot(dataTImage,savefigName,savefigNote,outDir,...
    1.73, 6,'MediumView', 10);
%&****************************************************************


%**************************************************************************
% postencoding correlations
inputDir = 'E:\myStudy\picpairfMRI\restingConnectivityConn_SessionAsConditions\conn_restingConnectivity\results\secondlevel\';
dataTImage = [inputDir, 'R_PPA_postFamnonfam-pre_fw05.nii'];
% p=.005 threshold
savefigName = 'R_PPA_postFamnonfam-pre_fw05';
savefigNote = [dataTImage,'___',savefigName,'____.05 family wise correction postfam_postnonfam - pre'];
outDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\picPairFigures\';
makeBrainNetSurfacePlot(dataTImage,savefigName,savefigNote,outDir,...
    0, 6,'MediumView', 10);


%*************second level marsbar roi analysis **************************
% encoding anlaysis foler (with gray matter mask)
% SecondLevelEncodingROIMarsbarAnalysis;

rootDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelAnalysis';
SecondLevelROIMarsbarAnalysisGeneral(rootDir);

rootDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelPmodAnalysis\attractiveness';
SecondLevelROIMarsbarAnalysisGeneral(rootDir);

rootDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelPmodAnalysis\easyDifficultPic&ScrmonlyGoodMemSubj';
SecondLevelROIMarsbarAnalysisGeneral(rootDir);

rootDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelPmodAnalysis\emotion';
SecondLevelROIMarsbarAnalysisGeneral(rootDir);

rootDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelPmodAnalysis\easyDifficult';
SecondLevelROIMarsbarAnalysisGeneral(rootDir);

rootDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelPmodAnalysis\familiarity';
SecondLevelROIMarsbarAnalysisGeneral(rootDir);

rootDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelPmodAnalysis\memory';
SecondLevelROIMarsbarAnalysisGeneral(rootDir);

rootDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelPmodAnalysis\performance';
SecondLevelROIMarsbarAnalysisGeneral_functionalROI(rootDir);

SecondLevelROIMarsbarAnalysisGeneral(rootDir);

rootDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelPmodAnalysis\performanceonlyGoodMemSubj';
SecondLevelROIMarsbarAnalysisGeneral(rootDir);


rootDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelPmodAnalysisBinary\attractivenessPartSubj';
SecondLevelROIMarsbarAnalysisGeneral(rootDir);

rootDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelPmodAnalysisBinary\emotionPartSubj';
SecondLevelROIMarsbarAnalysisGeneral(rootDir);

rootDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelPmodAnalysisBinary\familiarity';
SecondLevelROIMarsbarAnalysisGeneral(rootDir);

rootDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelPmodAnalysisBinary\memory';
SecondLevelROIMarsbarAnalysisGeneral(rootDir);

rootDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelPmodAnalysis\easyDifficultControMem';
SecondLevelROIMarsbarAnalysisGeneral(rootDir);

rootDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelPmodAnalysis\easyDifficultControMem_012onlyGoodMemSubj';
SecondLevelROIMarsbarAnalysisGeneral(rootDir);

rDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelPmodAnalysisSubj1-19'
rootDirs = dir(rDir);
rootDirs = rootDirs(3:end);
for i = 1:size(rootDirs,1)
    SecondLevelROIMarsbarAnalysisGeneral(fullfile(rDir,rootDirs(i).name));
end

rDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelPPIAnalysis'
rootDirs = dir(rDir);
rootDirs = rootDirs(3:end);
for i = 1:size(rootDirs,1)
    SecondLevelROIMarsbarAnalysisGeneral(fullfile(rDir,rootDirs(i).name));
end

rDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelReg__preciseMem_noFameOrderCovInMem_withCovsInBold'
rootDirs = dir(rDir);
rootDirs = rootDirs(3:end);
for i = 1:size(rootDirs,1)
    SecondLevelROIMarsbarAnalysisGeneral(fullfile(rDir,rootDirs(i).name));
end

rDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelReg_usingTotalMemory'
rootDirs = dir(rDir);
rootDirs = rootDirs(3:end);
for i = 1:size(rootDirs,1)
    SecondLevelROIMarsbarAnalysisGeneral(fullfile(rDir,rootDirs(i).name));
end


rootDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelSubsequentMemoryAnalysis';
SecondLevelROIMarsbarAnalysisGeneral(rootDir);

rDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelVBM'
SecondLevelROIMarsbarAnalysisVBM(rDir);


%****** second level analysis for publication ****************************
%*************************************************************************

% for publication:
% 1) at the sencod level analysis, gray matter mask will be applied
% 2) marsbar roi analysis will be applied
% The analysis will include:
%   a) encoding picture vs. scramble and famous vs nonfamous
%   b) pmod analysis for fmaous condition to get regions showing modulation
%   c) PPI analysis showing PPA and hipp connect with more anterior regions
%   in the famous than nonfamous condition.


%************** for PPI analysis AlphaSim********************************
% for ppi analysis because the ROI marsbar results are not significant, to
% control multiple testing, using alphasim in REST toolbox
usingAlphaSimToDetermineClusterSizeForPPIResults % this script inlcudes another function to do the test

usingAlphaSimToDetermineClusterSizeForfacehoseVsScramble ;
%****************** Plot ppi results (R_HPC as illustration) *************
ppi_wrapper_forPPIPlot(1,1,20) % right temporal pole fam > nonfam
ppi_wrapper_forPPIPlot(2,1,20) % left parahippocampus nonfam > fam
ppi_wrapper_forPPIPlot(3,1,20) % left parahippocampus nonfam > fam
ppi_wrapper_forPPIPlot(4,1,20)
ppi_wrapper_forPPIPlot(5,1,20)


%******ppi subsequent memory


regions={'L_PPAnative','R_PPAnative','L_FFAnative','R_FFAnative',...
    'L_PPA','R_PPA','L_FFA','R_FFA',...
    'L_HPC','R_HPC','L_aHC','R_aHC',...
    'L_mHC','R_mHC','L_pHC','R_pHC',...
    'L_preCun','R_preCun','L_TMP','R_TMP','L_vmP','R_vmP'};

for i =9:10
    ppi_wrapper_encodingSubsquentMemEff(i,1,20);
    % secondLevelEncodingTaskPPIAnalysisSubsequentMem(regions{i},1:20);
end

for i =9:10
    secondLevelEncodingTaskPPIAnalysisSubsequentMem(regions{i},1:20);
end
rootDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelPPIAnalysisSubsequentMem\L_HPC';
SecondLevelROIMarsbarAnalysisGeneral(rootDir);
rootDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelPPIAnalysisSubsequentMem\R_HPC';
SecondLevelROIMarsbarAnalysisGeneral(rootDir);



%****** regression PPI with memory performance

secondLevelRegression1PredictorMasterScript_PPI(1,1,'L_HPC');
secondLevelRegression1PredictorMasterScript_PPI(1,1,'R_HPC');

rootDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelReg_PPI\L_HPC';
SecondLevelROIMarsbarAnalysisGeneral(rootDir);

rootDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelReg_PPI\R_HPC';
SecondLevelROIMarsbarAnalysisGeneral(rootDir);



% subsequent emotion effects (separating high (4,5) vs. low (1,2,3) emotion
% evaluation trials. similar to emotion binary pmod analysis. but this is
% to prepar for PPI on high vs low emotion trials.
subID=1:20;
nSub = length(subID);
for i = 1: nSub
    disp(i)
    idExcluded = makeMultiCondMatFileUsingFaceEvaluationData(subID(i),'emotion',0);
    if idExcluded ~=1
        firstlevelSubsequentMemoryAnalysisBasic(subID(i),'subsequentEmotionEffects','emotion',0);
    end
end

%******* PPI on subsequent emotion effect*****
regions={'L_PPAnative','R_PPAnative','L_FFAnative','R_FFAnative',...
    'L_PPA','R_PPA','L_FFA','R_FFA',...
    'L_HPC','R_HPC','L_aHC','R_aHC',...
    'L_mHC','R_mHC','L_pHC','R_pHC',...
    'L_preCun','R_preCun','L_TMP','R_TMP','L_vmP','R_vmP'};
subID=1:20;
nSub = length(subID);

for i = 1: nSub
    disp(i)
    idExcluded(i) = makeMultiCondMatFileUsingFaceEvaluationData(subID(i),'emotion',0);
    
end

idIn = setdiff(subID,subID(logical(idExcluded)));

for i = 9:10
    ppi_wrapper_encodingSubsquentEmotionEff(i,idIn);
end
for i =9:10
    secondLevelEncodingTaskPPIAnalysisSubsequentEmotionEff(regions{i},idIn);
end

rootDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelPPIAnalysisSubsequentEmotionEff\L_HPC';
SecondLevelROIMarsbarAnalysisGeneral(rootDir);
rootDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelPPIAnalysisSubsequentEmotionEff\R_HPC';
SecondLevelROIMarsbarAnalysisGeneral(rootDir);


%**************************************************************************
%******** produce figures for encoding publication************************
%**************************************************************************
%**************************************************************************
%behavioral graph using

plotMemoryPerformanceResults
%then combine the figures in inkscape

% mask regions
%using brainnet, with BrainMesh_ICBM152_tal.nv (in brain net folder) and
%\ROI_all_10_discrete.hdr in mask folder, option" nearest voxel", scale
%.9-5, custom color space colorScale =[1 0 1; 0 1 0 ; 1 0 0 ;0 1 1 ; 0 0 1]; %for ppa ffa, hpc, tpl, and vmpfc
% then copy paste teh relevant graphs in inkscape.

%encoding pic-scramble main effects
inputDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelAnalysis\picEffect_Pic-Scramble\';
dataTImage = [inputDir, 'spmT_0001.img'];
% p=.005 threshold
savefigName = 'PicEff-pic-scramble-005';
savefigNote = [dataTImage,'___',savefigName,'____pic > scramble p = .005'];
outDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\picPairFigures\';
makeBrainNetSurfacePlot(dataTImage,savefigName,savefigNote,outDir,...
    2.861, 15,'FullView', 10);



% ***** fame main effect during encoding
inputDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelAnalysis\famEffect_Fam-NonFam\';
dataTImage = [inputDir, 'spmT_0003.img'];
% p=.005 threshold
savefigName = 'fameMainEffect-fam-nfam-005';
savefigNote = [dataTImage,'___',savefigName,'____famous > nonfamous p = .005'];
outDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\picPairFigures\';
makeBrainNetSurfacePlot(dataTImage,savefigName,savefigNote,outDir,...
    2.860935, 5,'FullView', 10); %'MediumView'


% p=.05 threshold
savefigName = 'fameMainEffect-fam-nfam-05';
savefigNote = [dataTImage,'___',savefigName,'____famous > nonfamous p = .05'];
outDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\picPairFigures\';
makeBrainNetSurfacePlot(dataTImage,savefigName,savefigNote,outDir,...
    1.73, 5,'FullView', 10);

% famous only

inputDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelAnalysis\Fam1+Fam2\';
dataTImage = [inputDir, 'spmT_0001.img'];
% p=.005 threshold
savefigName = 'famous-pic-scramble-005';
savefigNote = [dataTImage,'___',savefigName,'____famous pic-scramble p = .005'];
outDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\picPairFigures\';
makeBrainNetSurfacePlot(dataTImage,savefigName,savefigNote,outDir,...
    2.860935, 10,'MediumView', 10); %'MediumView'


% nonfamous only
inputDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelAnalysis\NFam1+NFam2\';
dataTImage = [inputDir, 'spmT_0001.img'];
% p=.005 threshold
savefigName = 'nonfamous-pic-scramble-005';
savefigNote = [dataTImage,'___',savefigName,'____nonfamous pic-scramble p = .005'];
outDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\picPairFigures\';
makeBrainNetSurfacePlot(dataTImage,savefigName,savefigNote,outDir,...
    2.860935, 10,'MediumView', 10); %'MediumView'
%***************************************************************************
%*************************************************************************
% plot output activation table, and spm figure (mainly for subcortical
% regions. for cortical regions using the obove surface brainnet plot.)
%************************************************************************

%encding fame effects: famous - nonfamous
xSPM.swd       = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelAnalysis\famEffect_Fam-NonFam';
xSPM.Ic        = 1; % index of contrast
xSPM.n         = 1; % conjunction number (next update)
xSPM.u         = 0.005;
xSPM.Im        =[]; % if no masking
% if need masking
% xSPM.Im        = {'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelAnalysis\picEffect_Pic-Scramble\L_HPC.img'};
% xSPM.Ex        = 0; % 0 inclusive 1, exclusive
xSPM.thresDesc = 'none'; % 'FWE', or 'FDR'-if using FDR defaults.stats.topFDR need be changed from 1 to 0
xSPM.title     = '';
xSPM.k         = 10;
xSPM.units     = {'mm' 'mm' 'mm'};
defaultCor     = [24 -14 -18]; % for right hippocampus
encodingFam_nonfam005_10= batchProduceOutputFigAndTable(xSPM,defaultCor,0,'encodingFam_nonfam005_10');
encodingFam_nonfam005_10= batchProduceOutputFigAndTable(xSPM,defaultCor,1,'encodingFam_nonfam005_10');
defaultCor     = [1 43 -19]; % for L-vmpfc
encodingFam_nonfam005_10= batchProduceOutputFigAndTable(xSPM,defaultCor,0,'encodingFam_nonfam005_10');
defaultCor     = [-24 -14 -16]; % for L-HPC
encodingFam_nonfam005_10= batchProduceOutputFigAndTable(xSPM,defaultCor,0,'encodingFam_nonfam005_10');
defaultCor     = [-40 -44 -15]; % for FFA
encodingFam_nonfam005_10= batchProduceOutputFigAndTable(xSPM,defaultCor,0,'encodingFam_nonfam005_10');



%encding fame effects: nonfamous - famous
xSPM.swd       = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelAnalysis\famEffect_Fam-NonFam';
xSPM.Ic        = 2; % index of contrast
xSPM.n         = 1; % conjunction number (next update)
xSPM.u         = 0.005;
xSPM.Im        =[]; % if no masking
% if need masking
% xSPM.Im        = {'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelAnalysis\picEffect_Pic-Scramble\L_HPC.img'};
% xSPM.Ex        = 0; % 0 inclusive 1, exclusive
xSPM.thresDesc = 'none'; % 'FWE', or 'FDR'-if using FDR defaults.stats.topFDR need be changed from 1 to 0
xSPM.title     = '';
xSPM.k         = 10;
xSPM.units     = {'mm' 'mm' 'mm'};
defaultCor     = [24 -14 -18]; % for right hippocampus
encodingNonFam_fam005_10= batchProduceOutputFigAndTable(xSPM,defaultCor,0,'encodingNonFam_fam005_10');
defaultCor     = [24 -14 -18]; % for right hippocampus
encodingNonFam_fam005_10= batchProduceOutputFigAndTable(xSPM,defaultCor,1,'encodingNonFam_fam005_10');


% parametric modulation analysi PKM
inputDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelPmodAnalysisBinary\';
dataTImage = [inputDir, 'PKM+.img'];
% p=.005 threshold
savefigName = 'ParametricModulationBinaryAllScaleSurvived005-10v';
savefigNote = [dataTImage,'___',savefigName,'____High_low_p = .005'];
outDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\picPairFigures\';
makeBrainNetSurfacePlot(dataTImage,savefigName,savefigNote,outDir,...
    0,1,'FullView', 10); %'MediumView'

%PKM -
inputDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelPmodAnalysisBinary\';
dataTImage = [inputDir, 'PKM-.img'];
% p=.005 threshold
savefigName = 'ParametricModulationBinaryAllNegativeSurvived005-10v';
savefigNote = [dataTImage,'___',savefigName,'____Low_High_p = .005'];
outDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\picPairFigures\';
makeBrainNetSurfacePlot(dataTImage,savefigName,savefigNote,outDir,...
    2.861,6,'FullView', 10); %'MediumView'

%overlap between PKM and fame effects
inputDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelAnalysis\famEffect_Fam-NonFam\';
dataTImage = [inputDir, 'overlapPKMandFameEff.img'];
% p=.005 threshold
tempDir='C:\Users\Zhongxu\Documents\MATLAB\myMatLabTools\majorNeuroImagingTools\BrainNetViewer\Data\SurfTemplate';
savefigName = 'ParametricModulationBinaryOverlayWithFameEffect';

h=BrainNet_MapCfg('BrainMesh_ICBM152_smoothed_tal.nv',dataTImage,[inputDir,'overlayPKM_fameEff_brainNet_setup.mat']);
outDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\picPairFigures\';
% export_fig([outDir,savefigName],'-eps','-r300');% saved image has color edges, may have to do screen catch.


%PKM memory
inputDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelPmodAnalysisBinary\memory\Fam12\';
dataTImage = [inputDir, 'spmT_0001.img'];
% p=.005 threshold
savefigName = 'ParametricModulationBinaryMemory005-10v';
savefigNote = [dataTImage,'___',savefigName,'____Low_High_p = .005'];
outDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\picPairFigures\';
makeBrainNetSurfacePlot(dataTImage,savefigName,savefigNote,outDir,...
    2.861,5,'MediumView', 10); %'MediumView'

savefigName = 'ParametricModulationBinaryMemory05-10v';
savefigNote = [dataTImage,'___',savefigName,'____Low_High_p = .05'];
outDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\picPairFigures\';
makeBrainNetSurfacePlot(dataTImage,savefigName,savefigNote,outDir,...
    1.73,5,'MediumView', 10); %'MediumView'


%PKM emotion
inputDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelPmodAnalysisBinary\emotionPartSubj\Fam12\';
dataTImage = [inputDir, 'spmT_0001.img'];
% p=.005 threshold
savefigName = 'ParametricModulationBinaryEmotion005-10v';
savefigNote = [dataTImage,'___',savefigName,'____Low_High_p = .005'];
outDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\picPairFigures\';
makeBrainNetSurfacePlot(dataTImage,savefigName,savefigNote,outDir,...
    2.861,5,'MediumView', 10); %'MediumView'

savefigName = 'ParametricModulationBinaryEmotion05-10v';
savefigNote = [dataTImage,'___',savefigName,'____Low_High_p = .05'];
outDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\picPairFigures\';
makeBrainNetSurfacePlot(dataTImage,savefigName,savefigNote,outDir,...
    1.73,5,'MediumView', 10); %'MediumView'



%PKM familiarity
inputDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelPmodAnalysisBinary\familiarity\Fam12\';
dataTImage = [inputDir, 'spmT_0001.img'];
% p=.005 threshold
savefigName = 'ParametricModulationBinaryFamiliarity005-10v';
savefigNote = [dataTImage,'___',savefigName,'____Low_High_p = .005'];
outDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\picPairFigures\';
makeBrainNetSurfacePlot(dataTImage,savefigName,savefigNote,outDir,...
    2.861,5,'MediumView', 10); %'MediumView'

savefigName = 'ParametricModulationBinaryFamiliarity05-10v';
savefigNote = [dataTImage,'___',savefigName,'____Low_High_p = .05'];
outDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\picPairFigures\';
makeBrainNetSurfacePlot(dataTImage,savefigName,savefigNote,outDir,...
    1.73,5,'MediumView', 10); %'MediumView'


%PKM attractiveness
inputDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelPmodAnalysisBinary\attractivenessPartSubj\Fam12\';
dataTImage = [inputDir, 'spmT_0001.img'];
% p=.005 threshold
savefigName = 'ParametricModulationBinaryAttractive005-10v';
savefigNote = [dataTImage,'___',savefigName,'____Low_High_p = .005'];
outDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\picPairFigures\';
makeBrainNetSurfacePlot(dataTImage,savefigName,savefigNote,outDir,...
    2.861,5,'MediumView', 10); %'MediumView'

savefigName = 'ParametricModulationBinaryAttractive05-10v';
savefigNote = [dataTImage,'___',savefigName,'____Low_High_p = .05'];
outDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\picPairFigures\';
makeBrainNetSurfacePlot(dataTImage,savefigName,savefigNote,outDir,...
    1.73,5,'MediumView', 10); %'MediumView'

%overlap between pkm+ and fame effect(fam-nonfam)

%encding fame effects:  famousnon-famous
xSPM.swd       = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelAnalysis\famEffect_Fam-NonFam';
xSPM.Ic        = 1; % index of contrast
xSPM.n         = 1; % conjunction number (next update)
xSPM.u         = 0.005;
% xSPM.Im        =[]; % if no masking
% if need masking
xSPM.Im        = {'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelPmodAnalysisBinary\binaryPKM+.img'};
xSPM.Ex        = 0; % 0 inclusive 1, exclusive
xSPM.thresDesc = 'none'; % 'FWE', or 'FDR'-if using FDR defaults.stats.topFDR need be changed from 1 to 0
xSPM.title     = '';
xSPM.k         = 10;
xSPM.units     = {'mm' 'mm' 'mm'};
defaultCor     = [24 -14 -18]; % for right hippocampus
encodingNonFam_fam005_10= batchProduceOutputFigAndTable(xSPM,defaultCor,0,'encodingfam-nfamOverlapPKM+005_10');
defaultCor     = [24 -14 -18]; % for right hippocampus
encodingNonFam_fam005_10= batchProduceOutputFigAndTable(xSPM,defaultCor,1,'encodingfam-nfamOverlapPKM+005005_10');


%***************************************************************************
%pmod subsequent memory effects famous condition
inputDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelPmodAnalysis\performance\Fam12\';
dataTImage = [inputDir, 'spmT_0001.img'];
% p=.005 threshold
savefigName = 'ParametricModulationSubsequentMemory005-10v-newview';
savefigNote = [dataTImage,'___',savefigName,'____Memorized_Forgotten_p = .005'];
outDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\picPairFigures\';
makeBrainNetSurfacePlot(dataTImage,savefigName,savefigNote,outDir,...
    2.861,5,'MediumView+', 10); %'MediumView'


xSPM.swd   = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelPmodAnalysis\performance\Fam12';
xSPM.Ic    = 1; xSPM.n = 1; xSPM.u  = 0.005; xSPM.Im  =[];xSPM.thresDesc = 'none'; xSPM.title = '';
xSPM.k     = 10; xSPM.units     = {'mm' 'mm' 'mm'};
defaultCor = [-18 -8 -15]; % for left hippocampus
encodingNonFam_fam005_10= batchProduceOutputFigAndTable(xSPM,defaultCor,0,'PmodSubseqentMemFamous005_10');
encodingNonFam_fam005_10= batchProduceOutputFigAndTable(xSPM,defaultCor,1,'PmodSubseqentMemFamous005_10');




%pmod subsequent memory effects nonfamous condition
inputDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelPmodAnalysis\performance\NFam12\';
dataTImage = [inputDir, 'spmT_0001.img'];
% p=.005 threshold
savefigName = 'ParametricModulationSubsequentMemoryNONfam005-10v-newview';
savefigNote = [dataTImage,'___',savefigName,'____Memorized_Forgotten_p = .005'];
outDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\picPairFigures\';
makeBrainNetSurfacePlot(dataTImage,savefigName,savefigNote,outDir,...
    2.861,5,'MediumView+', 10); %'MediumView'

xSPM.swd       = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelPmodAnalysis\performance\NFam12';
xSPM.Ic    = 1; xSPM.n = 1; xSPM.u  = 0.005; xSPM.Im  =[];xSPM.thresDesc = 'none'; xSPM.title = '';
xSPM.k     = 10; xSPM.units     = {'mm' 'mm' 'mm'};
defaultCor = [-18 -8 -15]; % for left hippocampus
encodingNonFam_fam005_10= batchProduceOutputFigAndTable(xSPM,defaultCor,0,'PmodSubseqentMemNONFamous005_10');
encodingNonFam_fam005_10= batchProduceOutputFigAndTable(xSPM,defaultCor,1,'PmodSubseqentMemNONFamous005_10');


%pmod subsequent memory effect fam-nonfam table
%not used in publication (too many regions)
xSPM.swd       = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelPmodAnalysis\performance\Fam12-NFam12';
xSPM.Ic    = 1; xSPM.n = 1; xSPM.u  = 0.005; xSPM.Im  =[];xSPM.thresDesc = 'none'; xSPM.title = '';
xSPM.k     = 10; xSPM.units     = {'mm' 'mm' 'mm'};
defaultCor = [-18 -8 -15]; % for left hippocampus
% encodingNonFam_fam005_10= batchProduceOutputFigAndTable(xSPM,defaultCor,0,'PmodSubseqentMemNONFamous005_10');
encodingNonFam_fam005_10= batchProduceOutputFigAndTable(xSPM,defaultCor,1,'PmodSubseqentMemFam-NONFamous005_10');




%************************************************************************
%ppi results
% famous - nonfamous
xSPM.swd       = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelPPIAnalysis\R_HPC\fam-nonfam';
xSPM.Ic        = 1; % index of contrast
xSPM.n         = 1; % conjunction number (next update)
xSPM.u         = 0.005;
xSPM.Im        =[]; % if no masking
% if need masking
% xSPM.Im        = {'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelAnalysis\picEffect_Pic-Scramble\L_HPC.img'};
% xSPM.Ex        = 0; % 0 inclusive 1, exclusive
xSPM.thresDesc = 'none'; % 'FWE', or 'FDR'-if using FDR defaults.stats.topFDR need be changed from 1 to 0
xSPM.title     = '';
xSPM.k         = 10;
xSPM.units     = {'mm' 'mm' 'mm'};
defaultCor     = [24 -14 -18]; % for right hippocampus
encodingFam_nonfam005_10= batchProduceOutputFigAndTable(xSPM,defaultCor,0,'PPIfam-nfam005_10');
encodingFam_nonfam005_10= batchProduceOutputFigAndTable(xSPM,defaultCor,1,'PPIfam-nfam005_10');


% nonfamous - famous
xSPM.swd       = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelPPIAnalysis\R_HPC\fam-nonfam';
xSPM.Ic        = 2; % index of contrast
xSPM.n         = 1; % conjunction number (next update)
xSPM.u         = 0.005;
xSPM.Im        =[]; % if no masking
% if need masking
% xSPM.Im        = {'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelAnalysis\picEffect_Pic-Scramble\L_HPC.img'};
% xSPM.Ex        = 0; % 0 inclusive 1, exclusive
xSPM.thresDesc = 'none'; % 'FWE', or 'FDR'-if using FDR defaults.stats.topFDR need be changed from 1 to 0
xSPM.title     = '';
xSPM.k         = 10;
xSPM.units     = {'mm' 'mm' 'mm'};
defaultCor     = [24 -14 -18]; % for right hippocampus
encodingFam_nonfam005_10= batchProduceOutputFigAndTable(xSPM,defaultCor,0,'PPInonfam-fam005_10');
encodingFam_nonfam005_10= batchProduceOutputFigAndTable(xSPM,defaultCor,1,'PPInonfam-fam005_10');


% famous - nonfamous
xSPM.swd       = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelPPIAnalysis\L_HPC\fam-nonfam';
xSPM.Ic        = 1; % index of contrast
xSPM.n         = 1; % conjunction number (next update)
xSPM.u         = 0.005;
xSPM.Im        =[]; % if no masking
% if need masking
% xSPM.Im        = {'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelAnalysis\picEffect_Pic-Scramble\L_HPC.img'};
% xSPM.Ex        = 0; % 0 inclusive 1, exclusive
xSPM.thresDesc = 'none'; % 'FWE', or 'FDR'-if using FDR defaults.stats.topFDR need be changed from 1 to 0
xSPM.title     = '';
xSPM.k         = 10;
xSPM.units     = {'mm' 'mm' 'mm'};
defaultCor     = [24 -14 -18]; % for right hippocampus
encodingFam_nonfam005_10= batchProduceOutputFigAndTable(xSPM,defaultCor,0,'L-HPC-PPIfam-nonfam005_10');
encodingFam_nonfam005_10= batchProduceOutputFigAndTable(xSPM,defaultCor,1,'L-HPC-PPIfam-nonfam005_10');

%nonfam-fam
xSPM.swd       = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelPPIAnalysis\L_HPC\fam-nonfam';
xSPM.Ic        = 2; % index of contrast
xSPM.n         = 1; % conjunction number (next update)
xSPM.u         = 0.005;
xSPM.Im        =[]; % if no masking
% if need masking
% xSPM.Im        = {'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelAnalysis\picEffect_Pic-Scramble\L_HPC.img'};
% xSPM.Ex        = 0; % 0 inclusive 1, exclusive
xSPM.thresDesc = 'none'; % 'FWE', or 'FDR'-if using FDR defaults.stats.topFDR need be changed from 1 to 0
xSPM.title     = '';
xSPM.k         = 10;
xSPM.units     = {'mm' 'mm' 'mm'};
defaultCor     = [24 -14 -18]; % for right hippocampus
encodingFam_nonfam005_10= batchProduceOutputFigAndTable(xSPM,defaultCor,0,'L-HPC-PPInonfam-fam005_10');
encodingFam_nonfam005_10= batchProduceOutputFigAndTable(xSPM,defaultCor,1,'L-HPC-PPInonfam-fam005_10');

% ppi brainnet plot
preparPPIBrainNetPlotBatch % prepare the node adege file using sortedForm2 data

% using BrainNet, select the corresponding node adeg, 152tal surface file,
% and 10 rois file using 5 descrite color by uploading saved
% ppi-fameEffect-confg.mat file


% ppi subsequent memory
%famous .005
%left hpc
xSPM.swd       = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelPPIAnalysisSubsequentMem\L_HPC\rem-nonrem-fm';
xSPM.Ic    = 1; xSPM.n = 1; xSPM.u  = 0.005; xSPM.Im  =[];xSPM.thresDesc = 'none'; xSPM.title = '';
xSPM.k     = 10; xSPM.units     = {'mm' 'mm' 'mm'};
defaultCor = [-18 -8 -15]; % for left hippocampus
batchProduceOutputFigAndTable(xSPM,defaultCor,0,'PPI-subsequentMemFam-LHPC-005_10');
batchProduceOutputFigAndTable(xSPM,defaultCor,1,'PPI-subsequentMemFam-LHPC-005_10');

%right hpc
xSPM.swd       = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelPPIAnalysisSubsequentMem\R_HPC\rem-nonrem-fm';
xSPM.Ic    = 1; xSPM.n = 1; xSPM.u  = 0.005; xSPM.Im  =[];xSPM.thresDesc = 'none'; xSPM.title = '';
xSPM.k     = 10; xSPM.units     = {'mm' 'mm' 'mm'};
defaultCor = [-18 -8 -15]; % for left hippocampus
batchProduceOutputFigAndTable(xSPM,defaultCor,0,'PPI-subsequentMemFam-RHPC-005_10');
batchProduceOutputFigAndTable(xSPM,defaultCor,1,'PPI-subsequentMemFam-RHPC-005_10');

%nonfamous .005
%left hpc
xSPM.swd       = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelPPIAnalysisSubsequentMem\L_HPC\rem-nonrem-nfm';
xSPM.Ic    = 1; xSPM.n = 1; xSPM.u  = 0.005; xSPM.Im  =[];xSPM.thresDesc = 'none'; xSPM.title = '';
xSPM.k     = 10; xSPM.units     = {'mm' 'mm' 'mm'};
defaultCor = [-18 -8 -15]; % for left hippocampus
batchProduceOutputFigAndTable(xSPM,defaultCor,0,'PPI-subsequentMemNonFam-LHPC-005_10');
batchProduceOutputFigAndTable(xSPM,defaultCor,1,'PPI-subsequentMemNonFam-LHPC-005_10');

%right hpc
xSPM.swd       = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelPPIAnalysisSubsequentMem\R_HPC\rem-nonrem-nfm';
xSPM.Ic    = 1; xSPM.n = 1; xSPM.u  = 0.005; xSPM.Im  =[];xSPM.thresDesc = 'none'; xSPM.title = '';
xSPM.k     = 10; xSPM.units     = {'mm' 'mm' 'mm'};
defaultCor = [-18 -8 -15]; % for left hippocampus
batchProduceOutputFigAndTable(xSPM,defaultCor,0,'PPI-subsequentMemNonFam-RHPC-005_10');
batchProduceOutputFigAndTable(xSPM,defaultCor,1,'PPI-subsequentMemNonFam-RHPC-005_10');

%famous .05
%left hpc
xSPM.swd       = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelPPIAnalysisSubsequentMem\L_HPC\rem-nonrem-fm';
xSPM.Ic    = 1; xSPM.n = 1; xSPM.u  = 0.05; xSPM.Im  =[];xSPM.thresDesc = 'none'; xSPM.title = '';
xSPM.k     = 10; xSPM.units     = {'mm' 'mm' 'mm'};
defaultCor = [-18 -8 -15]; % for left hippocampus
batchProduceOutputFigAndTable(xSPM,defaultCor,0,'PPI-subsequentMemFam-LHPC-05_10');
batchProduceOutputFigAndTable(xSPM,defaultCor,1,'PPI-subsequentMemFam-LHPC-05_10');

%right hpc
xSPM.swd       = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelPPIAnalysisSubsequentMem\R_HPC\rem-nonrem-fm';
xSPM.Ic    = 1; xSPM.n = 1; xSPM.u  = 0.05; xSPM.Im  =[];xSPM.thresDesc = 'none'; xSPM.title = '';
xSPM.k     = 10; xSPM.units     = {'mm' 'mm' 'mm'};
defaultCor = [-18 -8 -15]; % for left hippocampus
batchProduceOutputFigAndTable(xSPM,defaultCor,0,'PPI-subsequentMemFam-RHPC-05_10');
batchProduceOutputFigAndTable(xSPM,defaultCor,1,'PPI-subsequentMemFam-RHPC-05_10');

%nonfamous .05
%left hpc
xSPM.swd       = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelPPIAnalysisSubsequentMem\L_HPC\rem-nonrem-nfm';
xSPM.Ic    = 1; xSPM.n = 1; xSPM.u  = 0.05; xSPM.Im  =[];xSPM.thresDesc = 'none'; xSPM.title = '';
xSPM.k     = 10; xSPM.units     = {'mm' 'mm' 'mm'};
defaultCor = [-18 -8 -15]; % for left hippocampus
batchProduceOutputFigAndTable(xSPM,defaultCor,0,'PPI-subsequentMemNonFam-LHPC-05_10');
batchProduceOutputFigAndTable(xSPM,defaultCor,1,'PPI-subsequentMemNonFam-LHPC-05_10');

%right hpc
xSPM.swd       = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelPPIAnalysisSubsequentMem\R_HPC\rem-nonrem-nfm';
xSPM.Ic    = 1; xSPM.n = 1; xSPM.u  = 0.05; xSPM.Im  =[];xSPM.thresDesc = 'none'; xSPM.title = '';
xSPM.k     = 10; xSPM.units     = {'mm' 'mm' 'mm'};
defaultCor = [-18 -8 -15]; % for left hippocampus
batchProduceOutputFigAndTable(xSPM,defaultCor,0,'PPI-subsequentMemNonFam-RHPC-05_10');
batchProduceOutputFigAndTable(xSPM,defaultCor,1,'PPI-subsequentMemNonFam-RHPC-05_10');


%famous .01
%left hpc
xSPM.swd       = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelPPIAnalysisSubsequentMem\L_HPC\rem-nonrem-fm';
xSPM.Ic    = 1; xSPM.n = 1; xSPM.u  = 0.01; xSPM.Im  =[];xSPM.thresDesc = 'none'; xSPM.title = '';
xSPM.k     = 10; xSPM.units     = {'mm' 'mm' 'mm'};
defaultCor = [-18 -8 -15]; % for left hippocampus
batchProduceOutputFigAndTable(xSPM,defaultCor,0,'PPI-subsequentMemFam-LHPC-01_10');
batchProduceOutputFigAndTable(xSPM,defaultCor,1,'PPI-subsequentMemFam-LHPC-01_10');

%right hpc
xSPM.swd       = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelPPIAnalysisSubsequentMem\R_HPC\rem-nonrem-fm';
xSPM.Ic    = 1; xSPM.n = 1; xSPM.u  = 0.01; xSPM.Im  =[];xSPM.thresDesc = 'none'; xSPM.title = '';
xSPM.k     = 10; xSPM.units     = {'mm' 'mm' 'mm'};
defaultCor = [-18 -8 -15]; % for left hippocampus
batchProduceOutputFigAndTable(xSPM,defaultCor,0,'PPI-subsequentMemFam-RHPC-01_10');
batchProduceOutputFigAndTable(xSPM,defaultCor,1,'PPI-subsequentMemFam-RHPC-01_10');





%nonfamous .01
%left hpc
xSPM.swd       = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelPPIAnalysisSubsequentMem\L_HPC\rem-nonrem-nfm';
xSPM.Ic    = 1; xSPM.n = 1; xSPM.u  = 0.01; xSPM.Im  =[];xSPM.thresDesc = 'none'; xSPM.title = '';
xSPM.k     = 10; xSPM.units     = {'mm' 'mm' 'mm'};
defaultCor = [-18 -8 -15]; % for left hippocampus
batchProduceOutputFigAndTable(xSPM,defaultCor,0,'PPI-subsequentMemNonFam-LHPC-01_10');
batchProduceOutputFigAndTable(xSPM,defaultCor,1,'PPI-subsequentMemNonFam-LHPC-01_10');

%right hpc
xSPM.swd       = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelPPIAnalysisSubsequentMem\R_HPC\rem-nonrem-nfm';
xSPM.Ic    = 1; xSPM.n = 1; xSPM.u  = 0.01; xSPM.Im  =[];xSPM.thresDesc = 'none'; xSPM.title = '';
xSPM.k     = 10; xSPM.units     = {'mm' 'mm' 'mm'};
defaultCor = [-18 -8 -15]; % for left hippocampus
batchProduceOutputFigAndTable(xSPM,defaultCor,0,'PPI-subsequentMemNonFam-RHPC-01_10');
batchProduceOutputFigAndTable(xSPM,defaultCor,1,'PPI-subsequentMemNonFam-RHPC-01_10');


%ppi regression
%possitive
%right hpc nonfam
xSPM.swd       = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelReg_PPI\R_HPC\pairMemoryNonFam';
xSPM.Ic    = 1; xSPM.n = 1; xSPM.u  = 0.005; xSPM.Im  =[];xSPM.thresDesc = 'none'; xSPM.title = '';
xSPM.k     = 10; xSPM.units     = {'mm' 'mm' 'mm'};
defaultCor = [-18 -8 -15]; % for left hippocampus
batchProduceOutputFigAndTable(xSPM,defaultCor,0,'PPI-RegressionMemNonFam-RHPC-Possi005_10');
batchProduceOutputFigAndTable(xSPM,defaultCor,1,'PPI-RegressionMemNonFam-RHPC-Possi005_10');

%left hpc nonfam
xSPM.swd       = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelReg_PPI\L_HPC\pairMemoryNonFam';
xSPM.Ic    = 1; xSPM.n = 1; xSPM.u  = 0.005; xSPM.Im  =[];xSPM.thresDesc = 'none'; xSPM.title = '';
xSPM.k     = 10; xSPM.units     = {'mm' 'mm' 'mm'};
defaultCor = [-18 -8 -15]; % for left hippocampus
batchProduceOutputFigAndTable(xSPM,defaultCor,0,'PPI-RegressionMemNonFam-LHPC-Possi005_10');
batchProduceOutputFigAndTable(xSPM,defaultCor,1,'PPI-RegressionMemNonFam-LHPC-Possi005_10');

%negative
%right hpc nonfam
xSPM.swd       = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelReg_PPI\R_HPC\pairMemoryNonFam';
xSPM.Ic    = 2; xSPM.n = 1; xSPM.u  = 0.005; xSPM.Im  =[];xSPM.thresDesc = 'none'; xSPM.title = '';
xSPM.k     = 10; xSPM.units     = {'mm' 'mm' 'mm'};
defaultCor = [-18 -8 -15]; % for left hippocampus
batchProduceOutputFigAndTable(xSPM,defaultCor,0,'PPI-RegressionMemNonFam-RHPC-Negati005_10');
batchProduceOutputFigAndTable(xSPM,defaultCor,1,'PPI-RegressionMemNonFam-RHPC-Negati005_10');

%left hpc nonfam
xSPM.swd       = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelReg_PPI\L_HPC\pairMemoryNonFam';
xSPM.Ic    = 2; xSPM.n = 1; xSPM.u  = 0.005; xSPM.Im  =[];xSPM.thresDesc = 'none'; xSPM.title = '';
xSPM.k     = 10; xSPM.units     = {'mm' 'mm' 'mm'};
defaultCor = [-18 -8 -15]; % for left hippocampus
batchProduceOutputFigAndTable(xSPM,defaultCor,0,'PPI-RegressionMemNonFam-LHPC-Negati005_10');
batchProduceOutputFigAndTable(xSPM,defaultCor,1,'PPI-RegressionMemNonFam-LHPC-Negati005_10');


%possitive
%right hpc fam
xSPM.swd       = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelReg_PPI\R_HPC\pairMemoryFam';
xSPM.Ic    = 1; xSPM.n = 1; xSPM.u  = 0.005; xSPM.Im  =[];xSPM.thresDesc = 'none'; xSPM.title = '';
xSPM.k     = 10; xSPM.units     = {'mm' 'mm' 'mm'};
defaultCor = [-18 -8 -15]; % for left hippocampus
batchProduceOutputFigAndTable(xSPM,defaultCor,0,'PPI-RegressionMemFam-RHPC-Possi005_10');
batchProduceOutputFigAndTable(xSPM,defaultCor,1,'PPI-RegressionMemFam-RHPC-Possi005_10');

%left hpc fam
xSPM.swd       = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelReg_PPI\L_HPC\pairMemoryFam';
xSPM.Ic    = 1; xSPM.n = 1; xSPM.u  = 0.005; xSPM.Im  =[];xSPM.thresDesc = 'none'; xSPM.title = '';
xSPM.k     = 10; xSPM.units     = {'mm' 'mm' 'mm'};
defaultCor = [-18 -8 -15]; % for left hippocampus
batchProduceOutputFigAndTable(xSPM,defaultCor,0,'PPI-RegressionMemFam-LHPC-Possi005_10');
batchProduceOutputFigAndTable(xSPM,defaultCor,1,'PPI-RegressionMemFam-LHPC-Possi005_10');

%negative
%right hpc fam
xSPM.swd       = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelReg_PPI\R_HPC\pairMemoryFam';
xSPM.Ic    = 2; xSPM.n = 1; xSPM.u  = 0.005; xSPM.Im  =[];xSPM.thresDesc = 'none'; xSPM.title = '';
xSPM.k     = 10; xSPM.units     = {'mm' 'mm' 'mm'};
defaultCor = [-18 -8 -15]; % for left hippocampus
batchProduceOutputFigAndTable(xSPM,defaultCor,0,'PPI-RegressionMemFam-RHPC-Negati005_10');
batchProduceOutputFigAndTable(xSPM,defaultCor,1,'PPI-RegressionMemFam-RHPC-Negati005_10');

%left hpc fam
xSPM.swd       = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelReg_PPI\L_HPC\pairMemoryFam';
xSPM.Ic    = 2; xSPM.n = 1; xSPM.u  = 0.005; xSPM.Im  =[];xSPM.thresDesc = 'none'; xSPM.title = '';
xSPM.k     = 10; xSPM.units     = {'mm' 'mm' 'mm'};
defaultCor = [-18 -8 -15]; % for left hippocampus
batchProduceOutputFigAndTable(xSPM,defaultCor,0,'PPI-RegressionMemFam-LHPC-Negati005_10');
batchProduceOutputFigAndTable(xSPM,defaultCor,1,'PPI-RegressionMemFam-LHPC-Negati005_10');


%%%%% figure 9 ppi regress memory
inputDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelReg_PPI\R_HPC\pairMemoryNonFam\';
dataTImage = [inputDir, 'spmT_0001.img'];
% p=.005 threshold
savefigName = 'R-HPCPPIRegressionWithMemNONfam005-10v-newview_extremeval';
savefigNote = [dataTImage,'___',savefigName,'____R-HPCPPIRegressionNfam_p = .005'];
outDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\picPairFigures\';
makeBrainNetSurfacePlot(dataTImage,savefigName,savefigNote,outDir,...
    2.92,5,'MediumView', 10); %'MediumView'%ppi regression brainnet view

inputDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelReg_PPI\L_HPC\pairMemoryNonFam\';
dataTImage = [inputDir, 'spmT_0001.img'];
% p=.005 threshold
savefigName = 'L-HPCPPIRegressionWithMemNONfam005-10v-newview_extremeval';
savefigNote = [dataTImage,'___',savefigName,'____L-HPCPPIRegressionNfam_p = .005'];
outDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\picPairFigures\';
makeBrainNetSurfacePlot(dataTImage,savefigName,savefigNote,outDir,...
    2.92,5,'MediumView', 10); %'MediumView'%ppi regression brainnet view

inputDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelReg_PPI\R_HPC\pairMemoryFam\';
dataTImage = [inputDir, 'spmT_0001.img'];
% p=.005 threshold
savefigName = 'R-HPCPPIRegressionWithMemfam005-10v-newview_extremeval';
savefigNote = [dataTImage,'___',savefigName,'____R-HPCPPIRegressionfam_p = .005'];
outDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\picPairFigures\';
makeBrainNetSurfacePlot(dataTImage,savefigName,savefigNote,outDir,...
    2.92,5,'MediumView', 10); %'MediumView'%ppi regression brainnet view

inputDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelReg_PPI\L_HPC\pairMemoryFam\';
dataTImage = [inputDir, 'spmT_0001.img'];
% p=.005 threshold
savefigName = 'L-HPCPPIRegressionWithMemfam005-10v-newview_extremeval';
savefigNote = [dataTImage,'___',savefigName,'____L-HPCPPIRegressionfam_p = .005'];
outDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\picPairFigures\';
makeBrainNetSurfacePlot(dataTImage,savefigName,savefigNote,outDir,...
    2.92,5,'MediumView', 10); %'MediumView'%ppi regression brainnet view


%%%%%
inputDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelReg_PPI\R_HPC\pairMemoryNonFam\';
dataTImage = [inputDir, 'spmT_0001.img'];
% p=.05 threshold
savefigName = 'R-HPCPPIRegressionWithMemNONfam05-10v-newview';
savefigNote = [dataTImage,'___',savefigName,'____R-HPCPPIRegressionNfam_p = .05'];
outDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\picPairFigures\';
makeBrainNetSurfacePlot(dataTImage,savefigName,savefigNote,outDir,...
    1.746,5,'MediumView+', 10); %'MediumView'%ppi regression brainnet view

inputDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelReg_PPI\L_HPC\pairMemoryNonFam\';
dataTImage = [inputDir, 'spmT_0001.img'];
% p=.05 threshold
savefigName = 'L-HPCPPIRegressionWithMemNONfam05-10v-newview';
savefigNote = [dataTImage,'___',savefigName,'____L-HPCPPIRegressionNfam_p = .05'];
outDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\picPairFigures\';
makeBrainNetSurfacePlot(dataTImage,savefigName,savefigNote,outDir,...
    1.746,5,'MediumView+', 10); %'MediumView'%ppi regression brainnet view

inputDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelReg_PPI\R_HPC\pairMemoryFam\';
dataTImage = [inputDir, 'spmT_0001.img'];
% p=.05 threshold
savefigName = 'R-HPCPPIRegressionWithMemfam05-10v-newview';
savefigNote = [dataTImage,'___',savefigName,'____R-HPCPPIRegressionfam_p = .05'];
outDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\picPairFigures\';
makeBrainNetSurfacePlot(dataTImage,savefigName,savefigNote,outDir,...
    1.746,5,'MediumView+', 10); %'MediumView'%ppi regression brainnet view

inputDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelReg_PPI\L_HPC\pairMemoryFam\';
dataTImage = [inputDir, 'spmT_0001.img'];
% p=.05 threshold
savefigName = 'L-HPCPPIRegressionWithMemfam05-10v-newview';
savefigNote = [dataTImage,'___',savefigName,'____L-HPCPPIRegressionfam_p = .05'];
outDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\picPairFigures\';
makeBrainNetSurfacePlot(dataTImage,savefigName,savefigNote,outDir,...
    1.746,5,'MediumView+', 10); %'MediumView'%ppi regression brainnet view



%****************************************************************************
%***************************************************************************
%*********** for kang lab meeting****
% localizer task
% face-house
inputDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelAnalysisLocalizer\face-house\';
dataTImage = [inputDir, 'spmT_0001.img'];
% p=.05 threshold
savefigName = 'face-house-001-fullview';
savefigNote = [dataTImage,'___',savefigName,'___face-house_p = .001'];
outDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\picPairFigures\';
makeBrainNetSurfacePlot(dataTImage,savefigName,savefigNote,outDir,...
    3.579,8,'FullView+', 10); %'MediumView'%ppi regression brainnet view


% face-(house+object)

inputDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelAnalysisLocalizer\face-house-object\';
dataTImage = [inputDir, 'spmT_0001.img'];
% p=.05 threshold
savefigName = 'face-house-object-001';
savefigNote = [dataTImage,'___',savefigName,'___face-object-house_p = .001'];
outDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\picPairFigures\';
makeBrainNetSurfacePlot(dataTImage,savefigName,savefigNote,outDir,...
    3.579,8,'MediumView+', 10); %'MediumView'%ppi regression brainnet view

% house-face
inputDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelAnalysisLocalizer\house-face-object\';
dataTImage = [inputDir, 'spmT_0001.img'];
% p=.05 threshold
savefigName = 'house-face-object-001';
savefigNote = [dataTImage,'___',savefigName,'___house-face-object_p = .001'];
outDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\picPairFigures\';
makeBrainNetSurfacePlot(dataTImage,savefigName,savefigNote,outDir,...
    3.579,8,'MediumView+', 10); %'MediumView'%ppi regression brainnet view

% FFA connectivity
inputDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelPPIAnalysis\L_FFA\fam-nonfam\';
dataTImage = [inputDir, 'spmT_0001.img'];
% p=.05 threshold
savefigName = 'L-FFA-PPI-Fam-Nonfam-05';
savefigNote = [dataTImage,'___',savefigName,'___L-FFA-PPI-Fam-Nonfam-005_p = .05'];
outDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\picPairFigures\';
makeBrainNetSurfacePlot(dataTImage,savefigName,savefigNote,outDir,...
    1.746,4,'MediumView+', 10); %'MediumView'%ppi regression brainnet view

inputDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelPPIAnalysis\R_FFA\fam-nonfam\';
dataTImage = [inputDir, 'spmT_0001.img'];
% p=.05 threshold
savefigName = 'R-FFA-PPI-Fam-Nonfam-05';
savefigNote = [dataTImage,'___',savefigName,'___R-FFA-PPI-Fam-Nonfam-005_p = .05'];
outDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\picPairFigures\';
makeBrainNetSurfacePlot(dataTImage,savefigName,savefigNote,outDir,...
    1.746,4,'MediumView+', 10); %'MediumView'%ppi regression brainnet view

% figure 9 of the encoding paper ppi hpc-vmpfc and hpc-basal gangalia correlation with memory across paraticipants
plotPPIregressionScatter;

%**************************************************************************
%*********** encoding strategy group coomparison
% ****** results original saved under C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelReg\singleReg
% but after calculation picpairfMRI\secondLevelReg_encodingStrategy\
secondLevelEncodingStrategyGroupComparisonRegress_encoding;
secondLevelEncodingStrategyGroupComparisonRegress_PPI_HPC
secondLevelEncodingStrategyGroupComparisonRegress_PPI_vmP
secondLevelEncodingStrategyGroupComparisonRegress_PMODEmotion %only using famous and binary i..e., emotion-11 folder contrasts


%making PMOD variable using raw rating (emotion) scores, which will be used
%as covariates
for i = 1:20
    makeMultiPmodFileAsCovariate_usingOriginalEmotionRatingScores(i, 'emotion',0,0);
end
% first level analsys using the pmod vairalbes calculated above
for i = 2:20
    firstlevelPmodAsCovariates(i,'emotion',0,0);
end
% second level analsys using the pmod vairalbes calculated above
secondLevelvoxelEncodingPmodEmotionAsCovriates;

%using covariate analysis at first level (the parametric analysis cannot be
%used as covariate because the paramatric modulation variable is
%automatically centered.
makeMultipleRegressionUsingFameRatingforFirstLevelAnalysis
for i = 2:20
    firstlevelAnalysisBasic_forFaceEvalCovAnalysis(i,'emotion');
end
secondLevelvoxelEncodingforFaceEvalCovAnalysis('emotion');

%second level marshbar analyses for encoding strategy
rDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelReg_encodingStrategy\encodingStrategyBinaryRegress_encoding'

SecondLevelROIMarsbarAnalysisGeneral(rDir);
inputDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelReg_encodingStrategy\encodingStrategyBinaryRegress_encoding\pic-scrmb\';
dataTImage = [inputDir, 'spmT_0001.img'];
% p=.005 threshold
savefigName = 'vmPFCEncodingStrategyUser-NoUser-005-10v-newview_extremeval';
savefigNote = [dataTImage,'___',savefigName,'___regression_p = .005'];
outDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\picPairFigures\';
makeBrainNetSurfacePlot(dataTImage,savefigName,savefigNote,outDir,...
    2.92,5,'MediumView+', 10); % t = 2.92 because this is a regression analysis
% fam
xSPM.swd       = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelReg_encodingStrategy\encodingStrategyBinaryRegress_encoding\pic-scrmb';
xSPM.Ic    = 1; xSPM.n = 1; xSPM.u  = 0.005; xSPM.Im  =[];xSPM.thresDesc = 'none'; xSPM.title = '';
xSPM.k     = 10; xSPM.units     = {'mm' 'mm' 'mm'};
defaultCor = [-5 27 -16]; % for left hippocampus
batchProduceOutputFigAndTable(xSPM,defaultCor,0,'EncodingStrategy_005_10');
defaultCor = [-54 7 -8];
batchProduceOutputFigAndTable(xSPM,defaultCor,0,'EncodingStrategy_005_10');
xSPM.Ic    = 2;
batchProduceOutputFigAndTable(xSPM,defaultCor,1,'EncodingStrategy_noStr-Stry005_10');


%the two encoding strategy group have no performance differences: sucks :(
rootDir='C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\matlabFunctions\';
load([rootDir,'encodingStrategy.mat']);

rootDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\';
load([rootDir,'matlabFunctions\performanceDataConcatenated.mat']);
[a b c d]=ttest2(pairMem.intactFam(encodingStrategy==1),pairMem.intactFam(encodingStrategy==-1))
[a b c d]=ttest2(pairMem.recomFam(encodingStrategy==1),pairMem.recomFam(encodingStrategy==-1))
[a b c d]=ttest2(pairMem.avgFam(encodingStrategy==1),pairMem.avgFam(encodingStrategy==-1))
[a b c d]=ttest2(pairMem.avgNFam(encodingStrategy==1),pairMem.avgNFam(encodingStrategy==-1))
[a b c d]=ttest2(pairMem.avgFam(encodingStrategy==1)-pairMem.avgNFam(encodingStrategy==1),pairMem.avgFam(encodingStrategy==-1)-pairMem.avgNFam(encodingStrategy==-1))
[a b c d]=ttest2(pairMem.intactFam(encodingStrategy==1)-pairMem.intactNFam(encodingStrategy==1),pairMem.intactFam(encodingStrategy==-1)-pairMem.intactNFam(encodingStrategy==-1))
%using regresson controlling for age and fame order
rootDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\';
[subjInfo a]=xlsread([rootDir,'matlabFunctions\picpairSubjInfo.xlsx']);
fameOrder = zeros(size(subjInfo,1),1);
fameOrder(1:2:end,1) = 1;
age = subjInfo(:,2);
[B,BINT,R,RINT,STATS] = robustfit([encodingStrategy,age,fameOrder],pairMem.intactFam);
aaa = regstats(pairMem.intactNFam,[encodingStrategy,age,fameOrder],'linear')
aaa.tstat.pval

%*************************************************************************
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%         revision for resubmission to J of neurosci
%%%************************************************************************

%small volume correction: initial threshold p = .005, k = 10,
maskDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\masks';
rois = {'L_HPC.img', 'R_HPC.img', 'L_PPA.img', 'R_PPA.img',...
    'L_FFA.img', 'R_FFA.img', 'L_TPL.img', 'R_TPL.img',...
    'L_vmP.img', 'R_vmP.img'};

spmDir{1}  = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelAnalysis\famEffect_Fam-NonFam';
spmDir{2}  = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelPmodAnalysis\performance\Fam12\';
spmDir{3}  = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelPmodAnalysis\performance\NFam12\';
spmDir{4}  = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelPmodAnalysis\performance\Fam12-NFam12\';
spmDir{5}  = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelPmodAnalysisBinary\emotionPartSubj\Fam12\';
spmDir{6}  = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelPmodAnalysisBinary\memory\Fam12\';
spmDir{7}  = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelPmodAnalysisBinary\familiarity\Fam12\';
spmDir{8}  = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelPmodAnalysisBinary\attractivenessPartSubj\Fam12\';
spmDir{9}  = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelReg_encodingStrategy\encodingStrategyBinaryRegress_encoding\pic-scrmb';
spmDir{10}  = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelPPIAnalysis\R_HPC\fam-nonfam';
spmDir{11} = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelPPIAnalysis\L_HPC\fam-nonfam';
spmDir{12} = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelPPIAnalysisSubsequentMem\L_HPC\rem-nonrem-fm';
spmDir{13} = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelPPIAnalysisSubsequentMem\R_HPC\rem-nonrem-fm';
spmDir{14} = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelReg_PPI\R_HPC\pairMemoryNonFam\';
spmDir{15} = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelReg_PPI\L_HPC\pairMemoryNonFam\';
spmDir{16} = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelReg_PPI\R_HPC\pairMemoryFam\';
spmDir{17} = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelReg_PPI\L_HPC\pairMemoryFam\';
spmDir{18} = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelAnalysis\picEffect_Pic-Scramble\';

contrastId = 1;
%small volume correction: initial threshold p = .005, k = 10,
for j = 1:length(spmDir)
    svcTabLine1 = nan(10,11);
    for i = 1:length(rois)
        maskFile = fullfile(maskDir,rois{i});
        svcTab{i,2} = SVCUsingROIMask(spmDir{j} , maskFile, contrastId, .01);
        svcTab{i,1} = rois{i};
        if ~isempty(svcTab{i,2}.dat)
            pcorrected{i} = min(min(cell2mat(svcTab{i,2}.dat(1,[1 3 4 7 8 ]))));
            svcTabLine1(i,:) =cell2mat(svcTab{i,2}.dat(1,1:11));
        else
            pcorrected{i} = 'not sig';
             svcTabLine1(i,:) =1;
        end
        newName = ['svc-contrast',num2str(contrastId),'-p01k10.mat'];
        outputName = fullfile(spmDir{j},newName);
        save(outputName,'svcTab','pcorrected','svcTabLine1');
    end
    pcorrectAll{j}=pcorrected;
    svcTabAll{j}=svcTab;
    svcTabLine1All{j}=svcTabLine1;
end

maskDir1 = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelAnalysis\picEffect_Pic-Scramble';
maskDir2 = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\masks';
rois = {'L_HPC.img', 'R_HPC.img', 'L_PPA.img', 'R_PPA.img',...
    'L_FFA.img', 'R_FFA.img', 'L_TMP.img', 'R_TMP.img',...
    'L_vmP.img', 'R_vmP.img'};
spmDir{1}  = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelPPIAnalysis\R_HPC\fam-nonfam\';
spmDir{2} = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelPPIAnalysis\L_HPC\fam-nonfam\';
spmDir{3} = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelPPIAnalysisSubsequentMem\L_HPC\rem-nonrem-fm\';
spmDir{4} = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelPPIAnalysisSubsequentMem\R_HPC\rem-nonrem-fm\';
spmDir{5} = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelReg_PPI\R_HPC\pairMemoryNonFam\';
spmDir{6} = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelReg_PPI\L_HPC\pairMemoryNonFam\';
spmDir{7} = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelReg_PPI\R_HPC\pairMemoryFam\';
spmDir{8} = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelReg_PPI\L_HPC\pairMemoryFam\';

contrastId = 1;
%small volume correction: initial threshold p = .05, k = 10,
for j = 1:length(spmDir)
    svcTabLine1 = nan(10,11);
    for i = 1:length(rois)
        if i ==3 || i ==4 || i==5 || i==6 
            maskDir = maskDir2;
        else
            maskDir = maskDir1;
        end
        maskFile = fullfile(maskDir,rois{i});
        svcTab{i,2} = SVCUsingROIMask(spmDir{j} , maskFile, contrastId, .05);
        svcTab{i,1} = rois{i};
        if ~isempty(svcTab{i,2}.dat)
            pcorrected{i} = min(min(cell2mat(svcTab{i,2}.dat(1,[1 3 4 7 8 ]))));
            svcTabLine1(i,:) =cell2mat(svcTab{i,2}.dat(1,1:11));
        else
            pcorrected{i} = 'not sig';
             svcTabLine1(i,:) =1;
        end
        newName = ['svc-contrast',num2str(contrastId),'-p01k10.mat'];
        outputName = fullfile(spmDir{j},newName);
        save(outputName,'svcTab','pcorrected','svcTabLine1');
    end
    pcorrectPPI05{j}=pcorrected;
    svcTabPPI05{j}=svcTab;
    svcTabLine1PPI05{j}=svcTabLine1;
end



spmDir{1}  = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelAnalysis\famEffect_Fam-NonFam\';
spmDir{2}  = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelPmodAnalysis\performance\Fam12\';
spmDir{3}  = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelPmodAnalysis\performance\NFam12\';
spmDir{4}  = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelPmodAnalysis\performance\Fam12-NFam12\';
spmDir{5}  = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelPmodAnalysisBinary\emotionPartSubj\Fam12\';
spmDir{6}  = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelPmodAnalysisBinary\memory\Fam12\';
spmDir{7}  = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelPmodAnalysisBinary\familiarity\Fam12\';
spmDir{8}  = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelPmodAnalysisBinary\attractivenessPartSubj\Fam12\';
spmDir{9}  = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelReg_encodingStrategy\encodingStrategyBinaryRegress_encoding\pic-scrmb\';
spmDir{10}  = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelPPIAnalysis\R_HPC\fam-nonfam\';
spmDir{11} = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelPPIAnalysis\L_HPC\fam-nonfam\';
spmDir{12} = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelPPIAnalysisSubsequentMem\L_HPC\rem-nonrem-fm\';
spmDir{13} = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelPPIAnalysisSubsequentMem\R_HPC\rem-nonrem-fm\';
spmDir{14} = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelReg_PPI\R_HPC\pairMemoryNonFam\';
spmDir{15} = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelReg_PPI\L_HPC\pairMemoryNonFam\';
spmDir{16} = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelReg_PPI\R_HPC\pairMemoryFam\';
spmDir{17} = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelReg_PPI\L_HPC\pairMemoryFam\';
spmDir{18} = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelAnalysis\picEffect_Pic-Scramble\';

for j = 1:length(spmDir)
    load([spmDir{j},'marsbarROIAnalysis.mat']);
    for i=1:10
        tp{i,1}= marsS{1,i}.P(1);
        tp{i,2}=marsS{1,i}.stat(1);
        tp{i,5}= marsS{1,i}.P(2);
        tp{i,6}=marsS{1,i}.stat(2);
    end
    
    tp(:,3)= {'L_HPC.img', 'R_HPC.img', 'L_PPA.img', 'R_PPA.img',...
        'L_FFA.img', 'R_FFA.img', 'L_TPL.img', 'R_TPL.img',...
        'L_vmP.img', 'R_vmP.img'};
    
    p=cell2mat(tp(:,1));
    
    [p_fdr, p_masked] = fdr( p,.05);
    p(p_masked==0)=1;
    p_fdrAll10(:,j) = p;
end

%alphasim
spmDir{1} = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelAnalysis\picEffect_Pic-Scramble\';
spmDir{2}  = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelAnalysis\famEffect_Fam-NonFam\';
spmDir{3}  = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelPPIAnalysis\R_HPC\fam-nonfam\';
input_file = 'spmT_0001.img';
maskDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\masks';
masks{1} = {'R_vmP_BBxChanged','L_TPL_BBxChanged','R_TPL_BBxChanged'};
masks{2} = {'L_HPC_BBxChanged'};
masks{3} = {'R_vmP_BBxChanged','L_TPL_BBxChanged','R_TPL_BBxChanged'};
clusSize=zeros(3,3);
for i = 1:3 %2:length(spmDir)    
    for j = 1:length(masks{i}) %1:length(maskName)
        clusSize(i,j) = claculateClusterSizeUseAlphaSim(spmDir{i}, input_file, maskDir, masks{i}{j});
    end
end


spmdir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelPPIAnalysis\L_HPC\fam-nonfam\';
maskName = 'L_vmP_BBxChanged';
        a=claculateClusterSizeUseAlphaSim(spmdir, input_file, maskDir, maskName);

        
% face rating correlations
load('faceEvalMTotal.mat');
a=corr([faceEvalMTotal.emotion(:,1),...
        faceEvalMTotal.memory(:,1),...
        faceEvalMTotal.familiarity(:,1),...
        faceEvalMTotal.attractiveness(:,1)])

% a =
% 
%     1.0000    0.5341    0.4490    0.3867
%     0.5341    1.0000    0.6626    0.5014
%     0.4490    0.6626    1.0000    0.3474
%     0.3867    0.5014    0.3474    1.0000

% plot subsequent memory encoding bar graphs for resubmission to j of
% neuroscience
plotEncodingSubsequentMemEffectBarGraphs('Fam12','NFam12');
plotEncodingFameEffectSingleBarGraphs;
plotEncodingFameEffectBarGraphs;

% plot easydifficult bar graphs
plotEasyDiffPicVsScrambleBarGraphs;%  pscyhological science paper 

% plot easydifficult trail memory performance
plotEasyDiffTrialCountsAndPairMemPerformance

%get hpc volume not 
for i = 1:20
inputfiles(i,:)  =['D:\myStudy\picpairfMRI\s', sprintf('%03d',i),'\scanImgData\run_0003\vol_0001.img'];
end
Hvolume = spm_HV(inputfiles);

%load saved HPC volume
load('C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\matlabFunctions\Hvolume.mat');

for i = 1:20
hvl(i) = (Hvolume{1,i}.gm_hippocampus_L);
hvr(i) = (Hvolume{1,i}.gm_hippocampus_R);
gv(i) = (Hvolume{1,i}.grey_matter_volume);
end

figure;
subplot(2,1,1)
plot(hvl,'r');
hold on;
plot(hvr,'b');
subplot(2,1,2)
plot(hvl./gv,'r');
hold on;
plot(hvr./gv,'b');

load(['C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\matlabFunctions\performanceDataConcatenated.mat']);
figure;
scatter(hvl./gv,pairMem.intactFam,'b');
hold on;
scatter(hvr./gv,pairMem.intactFam,'r');

figure;
scatter(hvl./gv,pairMem.intactNFam,'b');
hold on;
scatter(hvr./gv,pairMem.intactNFam,'r');

condName = 'easyDifficultControMem_012onlyGoodMemSubj'; 
[yfam, fh] = plotEasyDiffPicVsScrambleBarGraphsFHOnly(condName)

condName = 'easyDifficultControMem';
[yfam, fhall] = plotEasyDiffPicVsScrambleBarGraphsFHOnly(condName); % supplementary pscyhological science paper 

condName = 'easyDifficultControMem';
dataDir = 'Fam12';
[yfam, fh] = plotEasyDiffPicVsScrambleBarGraphsFHOnlyFamNfamSeparate(condName,dataDir, 1)
dataDir = 'NFam12';
[ynfam, nfh] = plotEasyDiffPicVsScrambleBarGraphsFHOnlyFamNfamSeparate(condName,dataDir, 1)

outdir = 'D:\myStudy\picpairfMRI\secondLevelPmodAnalysis\easyDifficultPic&ScrmmultiCondPmod-EncodingRespond16CondsonlyGoodMemSubj';
SecondLevelROIMarsbarAnalysisGeneral(outdir);


% adding contrast for subsequent memory analysis
addingContrastToSubsequentMemoryAnalysisMore(2:20)
% ***** subsequent memory analysis second level***************************
%*************************************************************************
% calculate remembered trial count
subID=1:20;
nSub = length(subID);
for i = 1:nSub
    [a b associativeCountFam(i) d e associativeCountNFam(i)]=getMemoryTrialCount(i,1);
end

idFamDel = find(associativeCountFam<5);
idNFamDel = find(associativeCountNFam<5);
idDel = union(idFamDel, idNFamDel);
idIncluded = setdiff(1:20,idDel);
secondLevelEncodingTaskSubsequentMemoryAnalysis(idIncluded);

secondLevelEncodingTaskSubsequentMemoryAnalysis_allContrast(1:20);

plotEncodingSubsequentMemEffectBarGraphs('fam1','NFam1');
plotEncodingSubsequentMemEffectBarGraphs('fam2','NFam2');
plotEncodingSubsequentMemEffectBarGraphs('Fam12','NFam12');

%remember forgotten separate vs. famous nonfamous anaova for each roi:
%using run1 and run2 combined.
figDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\encodingResubmissionFigures\';
statsall = plotEncodingSubseqMemEffectSepRemNonRem('remFam','remNonFam','nonremFam','nonremNonFam',figDir)

figDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\encodingResubmissionFigures\subseqRun1\';
statsall = plotEncodingSubseqMemEffectSepRemNonRem('remFam1','remNonFam1','nonremFam1','nonremNonFam1',figDir)


figDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\encodingResubmissionFigures\subseqRun2\';
statsallrun2 = plotEncodingSubseqMemEffectSepRemNonRem('remFam2','remNonFam2','nonremFam2','nonremNonFam2',figDir)

figDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\encodingResubmissionFigures\subseqMem_AllSubj_run12\';
statsall = plotEncodingSubseqMemEffectSepRemNonRem('remFam','remNonFam','nonremFam','nonremNonFam',figDir)


%picture vs scramble run1
plotEncodingFHScrambEffectBarGraphs('Fam1','NonFam1');
plotEncodingFHScrambEffectBarGraphs('Fam2','NonFam2');

figDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\encodingResubmissionFigures\';
plotEncodingSubseqMemEffectOneCondition('remFam','nonremFam',figDir);
plotEncodingSubseqMemEffectOneCondition('remFam1','nonremFam1',figDir);
plotEncodingSubseqMemEffectOneCondition('remFam2','nonremFam2',figDir);
plotEncodingSubseqMemEffectOneCondition('remNonFam','nonremNonFam',figDir);

%% ppi pls analysis using hpc as seed
%all not significant (run1, run2 ,run1+run2)
resultRotated = HPCseedVoxelPPIPLS('L_HPC','fam1','nonfam1',1:20);

%% ppi pls using rois, run1 p = .041 run1+run2 reach a weak trend p= .095
rois = { 'L_PPA.img', 'R_PPA.img',...
    'L_FFA.img', 'R_FFA.img', 'L_TPL.img', 'R_TPL.img',...
    'L_vmP.img', 'R_vmP.img'};
seedName='L_HPC'; contrastfam='fam1',contrastnfam='nonfam1';
dosingleROI=0; doAllROIs =1;
PPI_ROIPLS(seedName,contrastfam,contrastnfam,rois,dosingleROI,doAllROIs);

contrastfam='fam1+fam2',contrastnfam='nonfam1+nonfam2';
PPI_ROIPLS(seedName,contrastfam,contrastnfam,rois,dosingleROI,doAllROIs);

contrastfam='fam2',contrastnfam='nonfam2';
PPI_ROIPLS(seedName,contrastfam,contrastnfam,rois,dosingleROI,doAllROIs);




%adding pic-scramble contrast for run1 and run2
addingContrastToEncodingEffectPicScramble(1:20)


%roi marsbar for pic-scramble
rootDir = 'D:\myStudy\picpairfMRI\secondLevelAnalysis'
SecondLevelROIMarsbarAnalysisGeneral(rootDir);
plotEncodingEncodingFHScrambleEffectSingleBarGraphs('picEffect1_Pic1-Scramble1');
plotEncodingEncodingFHScrambleEffectSingleBarGraphs('picEffect2_Pic2-Scramble2');
plotEncodingEncodingFHScrambleEffectSingleBarGraphs;

% plot run by fame anova
% ylimvalue=[0 3; 0 3;0 3; 0 5;0 1.5; 0 1.5;-.5 1; -.5 .5; -.5, 1.5; -.5, 1]
        
statsall = plotEncodingfamNfamRun12Anova

% PLS PPI roi matrix plot
contrastfam='fam1';
contrastnfam='nonfam1'
plotROI_PPI_PLS_matrix(contrastfam,contrastnfam);

contrastfam='fam2';
contrastnfam='nonfam2'
plotROI_PPI_PLS_matrix(contrastfam,contrastnfam);

contrastfam='fam1+fam2';
contrastnfam='nonfam1+nonfam2'
plotROI_PPI_PLS_matrix(contrastfam,contrastnfam);


% pmod analysis trial counts
condName = {'emotion','familiarity','attractiveness','memory'};
numExcl = 0;

for k =1: 4

    for i = 1:20
            filename = ['D:\myStudy\picpairfMRI\s',sprintf('%03d',i),'\performanceData\',condName{k},'multiCondPmod-1.mat']
    load(filename);
        disp([k i])
        trialCountH(i,k)=length(find(cell2mat(pmod(1).param) ==1));       
        trialCountL(i,k)=length(find(cell2mat(pmod(1).param) ==-1));

        if isempty(find(cell2mat(pmod(1).param) ==1)==1) ||isempty(find(cell2mat(pmod(1).param) ==-1)==1)
            numExcl = numExcl+1;
            excludeSession(numExcl,1)=i;
            excludeSession(numExcl,2)=k;
        end
    end
end

%exclude subj with < 5 trials
for i = 1:4
    a{i} = find(trialCountH(:,i)<10);
    b{i} = find(trialCountL(:,i)<10);
    c{i} = unique(union(a{i},b{i}));
end
dataNames = {'emotion','familiarity','attractiveness','memory'}; % the order of the dataNames SHOULD NOT BE CHANGED because the excluded ID is calculatedd in this order
isFamOnly = [1 1 1 1];
for i = 1:4
    idIncld = setdiff(1:20,c{i});
    secondLevelvoxelPmodAnaysis_Binary(dataNames{i},isFamOnly(i),idIncld);
end

rootDir = 'D:\myStudy\picpairfMRI\secondLevelPmodAnalysisBinaryWith5MoreTrial\memory';
SecondLevelROIMarsbarAnalysisGeneral(rootDir);
rootDir = 'D:\myStudy\picpairfMRI\secondLevelPmodAnalysisBinaryWith5MoreTrial\attractivenessPartSubj';
SecondLevelROIMarsbarAnalysisGeneral(rootDir);
rootDir = 'D:\myStudy\picpairfMRI\secondLevelPmodAnalysisBinaryWith5MoreTrial\emotionPartSubj';
SecondLevelROIMarsbarAnalysisGeneral(rootDir);
rootDir = 'D:\myStudy\picpairfMRI\secondLevelPmodAnalysisBinaryWith5MoreTrialfamiliarityPartSubj';
SecondLevelROIMarsbarAnalysisGeneral(rootDir);


rootDir = 'D:\myStudy\picpairfMRI\secondLevelPmodAnalysisBinaryWith10MoreTrial\memoryPartSubj';
SecondLevelROIMarsbarAnalysisGeneral(rootDir);
rootDir = 'D:\myStudy\picpairfMRI\secondLevelPmodAnalysisBinaryWith10MoreTrial\attractivenessPartSubj';
SecondLevelROIMarsbarAnalysisGeneral(rootDir);
rootDir = 'D:\myStudy\picpairfMRI\secondLevelPmodAnalysisBinaryWith10MoreTrial\emotionPartSubj';
SecondLevelROIMarsbarAnalysisGeneral(rootDir);
rootDir = 'D:\myStudy\picpairfMRI\secondLevelPmodAnalysisBinaryWith10MoreTrial\familiarityPartSubj';
SecondLevelROIMarsbarAnalysisGeneral(rootDir);

%plot postencoding data
postencodingRestingHPCcorrelation;
postEncodingThesisAppendixAnteriorPosteriorHPCConnectivity

%reinstatement predicted encoding brain activity
% no sig effects were found for both fame conditions in roi anaysis
% whole brain with p = .005 only found post cingulate showed positive
% prediction in famous condition and superrior frontal gyrus cluster in
% nonfamous condiiton. cannot interpret. treat all as null findings.
% negative contrast, i.e., more activation with lower reinstatement scores,
% showed more activated regions, such as thalamus, ventral occiptial,
% dorsal medial superior frontal regions.

isCovari = 1;
secondLevelRegression1PredictorPairReinstMem(isCovari);
rootDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelReg\singleReg\pairReinstMemContr1';
SecondLevelROIMarsbarAnalysisGeneral(rootDir);


for i = 1
    datapath = ['D:\myStudy\picpairfMRI\',...
        's', sprintf('%03d',i),'\performanceData\'];
    outpath = datapath;
    saveOrNot = 1;
    getRetrievalData_v1(i,saveOrNot,datapath,outpath);
end


testingMeanMovementAcrossPostEncodingRestings
for i = 1:20
[faceCountFam(i), houseCountFam(i),associativeCountFam(i),...
    faceCountNFam(i), houseCountNFam(i), associativeCountNFam(i)] = ...
    getMemoryTrialCount(i, 0);

[triTypeFam, triTypeNFam, trialCountFam(:,:,i), trialCountNFam(:,:,i)] = ...
    getDifferentMemoryTrials(i, 0,1);
makeMultiCondMatFileUsingAllDiffMems(i);
firstlevelDiffMemoryTypeAnalysis(i)
end

% setup 4 conditions for face-house pairs based on survey on trial count
%1 association, 2 pair withno association,3, face only, 4 house only and no memory


% calculate trial counts for each rating. thesis revision to kang's
% comments
dataNames = {'memory','emotion','familiarity','attractiveness'};
isFamOnly = [1 1 1 1];

for subID = 1:20
data1(:,:,subID) = calculatePmodTrialCount(subID, dataNames(1),1,0);
data2(:,:,subID) = calculatePmodTrialCount(subID, dataNames(2),1,0);

data3(:,:,subID) = calculatePmodTrialCount(subID, dataNames(3),1,0);

data4(:,:,subID) = calculatePmodTrialCount(subID, dataNames(4),1,0);

end
figure;
hist(reshape(squeeze(data1(:,1,:)),60*20,1));
figure;
hist(reshape(squeeze(data2(:,1,:)),60*20,1));
figure;
hist(reshape(squeeze(data3(:,1,:)),60*20,1));
figure;
hist(reshape(squeeze(data4(:,1,:)),60*20,1));

%first level analysis on different memory trials for defense
for subj = 1:20
firstlevelDiffMemoryTypeAnalysis(subj);
end
%second level analysis on different memory trials for defense
secondLevelEncodingDifferentMemoryAnalysis(1:20);
%roi marsbar
rDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelDifferentMem'
SecondLevelROIMarsbarAnalysisGeneral(rDir);
%add contrast
addContrastToDifferentSubseqMemAnalysisForDefense;
secondLevelEncodingDifferentMemoryAnalysis(1:20);
rDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelDifferentMem'
SecondLevelROIMarsbarAnalysisGeneral(rDir);
% for defense Lila question
[p tval a b c] = prepostEncodingCorr(1:20,3,1);
[p tval a b c] = prepostEncodingCorr(1:20,3,0);
[p tval famCorrGrpLR nonfamCorrGrpLR] = ...
    EncodingCorrUsingOriginalData5ROIs(1:20,'restTimeSNotResi.mat',3,1);
[p tval famCorrGrpLR nonfamCorrGrpLR] = ...
    EncodingCorrUsingOriginalData5ROIs(1:20,'restTimeSNotResi.mat',3,0);

% test slop differences
[dataAll, orderEffectFam, slopFamNfamDiff slopFamDiff] = postencodingRestingHPCcorrelation_orderEffectForDefense
load('C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\matlabFunctions\postEncodingOrderEffectResultsForDefense.mat');
load('priorFaceRatingPCAData.mat', 'fam1PCA')
for i = 1:6
famCorr=replaceOutliers(dataAll{i}.famdata,2.5,2);
nonfamCorr=replaceOutliers(dataAll{i}.nonfamdata,2.5,2);
mean([famCorr(1:2:20),nonfamCorr(2:2:20)])
[a b c d]=ttest2(famCorr(1:2:20),nonfamCorr(2:2:20));
pval(i)=b;
tval{i}=d;

[e f]=corr(replaceOutliers(mean(fam1PCA)',2.5,2),replaceOutliers(famCorr,2.5,2));
corrrval(i)=e; corrpval(i)=f;
end

for i = 1:5
    a(i,:) = [slopFamDiff.PairMem{i}.method2.slopeDiffp,...
    slopFamDiff.FaceMem{i}.method2.slopeDiffp,...
    slopFamDiff.HouseMem{i}.method2.slopeDiffp];
    b(i,:) = [slopFamDiff.PairMem{i}.method2.slopeDifft,...
    slopFamDiff.FaceMem{i}.method2.slopeDifft,...
    slopFamDiff.HouseMem{i}.method2.slopeDifft]
end

for i = 1:6
    slopFamNfamDiff{i}.method2.slopeDiffp
end
    % control for order effect for encoding Lila's comments
  secondLevelvoxelBasedProcessingEncodingTask_ControOder; 
  rDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelAnalysis-contrOrder';
SecondLevelROIMarsbarAnalysisGeneral(rDir);


%% cerebral cortex revision
% memory performance separated for high vs. low face ratings
[pval.memory,tstats.memory dataRaw.memory.easy dataRaw.memory.diffi] = plotFaceRatingEffectsOnMemPerformance('memory')
[pval.emotion,tstats.emotion dataRaw.emotion.easy dataRaw.emotion.diffi] = plotFaceRatingEffectsOnMemPerformance('emotion')
[pval.familiarity,tstats.familiarity dataRaw.familiarity.easy dataRaw.familiarity.diffi] = plotFaceRatingEffectsOnMemPerformance('familiarity')
[pval.attractiveness,tstats.attractiveness dataRaw.attractiveness.easy dataRaw.attractiveness.diffi] = plotFaceRatingEffectsOnMemPerformance('attractiveness')
%pca using >60 percentile to define high vs. low prior knowledge.
[pval.pca,tstats.pca dataRaw.pca.easy dataRaw.pca.diffi] = plotFaceRatingEffectsOnMemPerformance('pca')
 
%pca using >50 percentile to define high vs. low prior knowledge, i.e., median split.
[pval.pca50,tstats.pca50 dataRaw.pca50.easy dataRaw.pca50.diffi] = plotFaceRatingEffectsOnMemPerformance('pca50percentile')

% only fam condition parametric modulation
for i = 1:20
        makeMultiPmodFile(i, 'pca',1,1);
        firstlevelPmodFamousOnly(i,'pca',1,1);   
end
secondLevelvoxelPmodAnaysis_general({'pca'},1,1,1:20);
rDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelPmodAnalysis\pca';
SecondLevelROIMarsbarAnalysisGeneral(rDir);

% using pca original data no binarization
for i = 1:20
        makeMultiPmodFile(i, 'pca',1,0);
        firstlevelPmodFamousOnly_twoFlags(i,'pca',1,0);   
end
secondLevelvoxelPmodAnaysis_general({'pca'},1,0,1:20);
rDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelPmodAnalysis\pca';
SecondLevelROIMarsbarAnalysisGeneral(rDir);

%using binarized pca
dataName={'performance','pca'};
isFamOnly = [0 1];
for i = 1:20
makeMultiPmodFileCombingPerformanceWithFaceRating(i,dataName,isFamOnly);
firstlevelPmodFamousOnly_mulitiPmod(i,dataName,isFamOnly,1)
end

secondLevelvoxelPmodAnaysis_general(dataName,isFamOnly,1,1:20);
rDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelPmodAnalysis\performancepca';
SecondLevelROIMarsbarAnalysisGeneral(rDir);



% mediation test suggested by cerebral reviwer1
secondlevelMeidationPairedTtest_job

outdir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelMediationPairedTtest_binarized';
SecondLevelROIMarsbarAnalysisGeneral(outdir);


%using continous pca
dataName={'performance','pca'};
isFamOnly = [0 1];
isBinarized=0;
for i = 2:20
makeMultiPmodFileCombingPerformanceWithFaceRating_twoFlags(i,dataName,isFamOnly,isBinarized);
firstlevelPmodFamousOnly_mulitiPmod_twoFlags(i,dataName,isFamOnly,isBinarized)
end

secondLevelvoxelPmodAnaysis_general(dataName,isFamOnly,isBinarized,1:20);
rDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelPmodAnalysis\performancepca';
SecondLevelROIMarsbarAnalysisGeneral(rDir);



% mediation test suggested by cerebral reviwer1
secondlevelMeidationPairedTtest_continuousPCA;

outdir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelMediationPairedTtest_continuousPCA';
SecondLevelROIMarsbarAnalysisGeneral(outdir);




%using binarized pca
dataName={'performance','emotion'};
isFamOnly = [0 1];
for i = 1%:20
makeMultiPmodFileCombingPerformanceWithFaceRating(i,dataName,isFamOnly);
firstlevelPmodFamousOnly_mulitiPmod(i,dataName,isFamOnly,1)
end

secondLevelvoxelPmodAnaysis_general(dataName,isFamOnly,1,1:20);
rDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelPmodAnalysis\performancepca';
SecondLevelROIMarsbarAnalysisGeneral(rDir);


%using binarized all ratings
dataName={'emotion','memory','familiarity','attractiveness'};
isFamOnly = [1 1 1 1];
for i = 2:20
makeMultiPmodFileCombingPerformanceWithFaceRating(i,dataName,isFamOnly);
firstlevelPmodFamousOnly_mulitiPmod(i,dataName,isFamOnly,1)
end

secondLevelvoxelPmodAnaysis_general(dataName,isFamOnly,1,1:20);
rDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelPmodAnalysis\emotionmemoryfamiliarityattractiveness';
SecondLevelROIMarsbarAnalysisGeneral(rDir);


rDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelSubsequentMemoryAnalysis_AllSubj';
SecondLevelROIMarsbarAnalysisGeneral(rDir);

dataDir ='C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelPmodAnalysis\pca-continuous\fam12\';
figDir='C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\picPairFigures\';
figName='PKM-pcaContinous';
plotSecondLevelBarGraphsGeneral(dataDir, figDir,figName)



dataDir ='C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelPmodAnalysis\performancepca_continuous\pca-fam12\';
figDir='C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\picPairFigures\';
figName='PKM-pcaContinousControllingSubseqMem';
plotSecondLevelBarGraphsGeneral(dataDir, figDir,figName)


dataDir ='C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelPmodAnalysis\performancepca_continuous\performance-fam12\';
figDir='C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\picPairFigures\';
figName='PKM-SubseqMemEffectControllingforPiorPCAeffects';
plotSecondLevelBarGraphsGeneral(dataDir, figDir,figName)

dataDir ='C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelMediationPairedTtest_continuousPCA\secondLevelMediationPairedTtest_memoryAsMediator_fam12\';
figDir='C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\picPairFigures\';
figName='PKM-SubseqMemMediatePiorPCAeffects';
plotSecondLevelBarGraphsPairedTtest(dataDir, figDir,figName)

dataDir ='C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelMediationPairedTtest_continuousPCA\secondLevelMediationPairedTtest_priorknowledgeAsMedi_fam12\';
figDir='C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\picPairFigures\';
figName='PKM-PriorPCAEffMediateSubseqMemEffects';
plotSecondLevelBarGraphsPairedTtest(dataDir, figDir,figName)


rDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelSubsequentMemoryAnalysis';
SecondLevelROIMarsbarAnalysisGeneral(rDir);

% new pmod pca result table
xSPM.swd       = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelPmodAnalysis\pca-continuous\fam12\';
xSPM.Ic        = 1; % index of contrast
xSPM.n         = 1; % conjunction number (next update)
xSPM.u         = 0.005;
xSPM.Im        =[]; % if no masking
% if need masking
% xSPM.Im        = {'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelAnalysis\picEffect_Pic-Scramble\L_HPC.img'};
% xSPM.Ex        = 0; % 0 inclusive 1, exclusive
xSPM.thresDesc = 'none'; % 'FWE', or 'FDR'-if using FDR defaults.stats.topFDR need be changed from 1 to 0
xSPM.title     = '';
xSPM.k         = 10;
xSPM.units     = {'mm' 'mm' 'mm'};
defaultCor     = [24 -14 -18]; % for right hippocampus
% encodingFam_nonfam005_10= batchProduceOutputFigAndTable(xSPM,defaultCor,0,'encodingFam_nonfam005_10');
encodingFam_nonfam005_10= batchProduceOutputFigAndTable(xSPM,defaultCor,1,'famPKMpmodPCAcontinuous_005_10');

xSPM.swd       = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelPmodAnalysis\pca-continuous\fam12\';
xSPM.Ic        = 1; % index of contrast
xSPM.n         = 1; % conjunction number (next update)
xSPM.u         = 0.005;
xSPM.Im        =[]; % if no masking
% if need masking
xSPM.Im        = {'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelAnalysis\famEffect_Fam-NonFam\fameEffecThreshold005-10vox.img'};
xSPM.Ex        = 0; % 0 inclusive 1, exclusive
xSPM.thresDesc = 'none'; % 'FWE', or 'FDR'-if using FDR defaults.stats.topFDR need be changed from 1 to 0
xSPM.title     = '';
xSPM.k         = 10;
xSPM.units     = {'mm' 'mm' 'mm'};
defaultCor     = [24 -14 -18]; % for right hippocampus
% encodingFam_nonfam005_10= batchProduceOutputFigAndTable(xSPM,defaultCor,0,'encodingFam_nonfam005_10');
encodingFam_nonfam005_10= batchProduceOutputFigAndTable(xSPM,defaultCor,1,'famPKMpmodPCAcontinuous_OverlapFameEff_005_10');


xSPM.swd       = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelPmodAnalysis\pca-continuous\fam12\';
xSPM.Ic        = 1; % index of contrast
xSPM.n         = 1; % conjunction number (next update)
xSPM.u         = 0.005;
xSPM.Im        =[]; % if no masking
% if need masking
xSPM.Im        = {'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelPmodAnalysis\performance-UsedinCereCor\Fam12\subseqMemEffnarry00510.img'};
xSPM.Ex        = 0; % 0 inclusive 1, exclusive
xSPM.thresDesc = 'none'; % 'FWE', or 'FDR'-if using FDR defaults.stats.topFDR need be changed from 1 to 0
xSPM.title     = '';
xSPM.k         = 10;
xSPM.units     = {'mm' 'mm' 'mm'};
defaultCor     = [24 -14 -18]; % for right hippocampus
% encodingFam_nonfam005_10= batchProduceOutputFigAndTable(xSPM,defaultCor,0,'encodingFam_nonfam005_10');
encodingFam_nonfam005_10= batchProduceOutputFigAndTable(xSPM,defaultCor,1,'famPKMpmodPCAcontinuous_OverlapSubseqMemEff_005_10');


xSPM.swd       = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelAnalysis\famEffect_Fam-NonFam\';
xSPM.Ic        = 1; % index of contrast
xSPM.n         = 1; % conjunction number (next update)
xSPM.u         = 0.005;
xSPM.Im        =[]; % if no masking
% if need masking
xSPM.Im        = {'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelPmodAnalysis\performance-UsedinCereCor\Fam12\subseqMemEffnarry00510.img'};
xSPM.Ex        = 0; % 0 inclusive 1, exclusive
xSPM.thresDesc = 'none'; % 'FWE', or 'FDR'-if using FDR defaults.stats.topFDR need be changed from 1 to 0
xSPM.title     = '';
xSPM.k         = 10;
xSPM.units     = {'mm' 'mm' 'mm'};
defaultCor     = [24 -14 -18]; % for right hippocampus
% encodingFam_nonfam005_10= batchProduceOutputFigAndTable(xSPM,defaultCor,0,'encodingFam_nonfam005_10');
encodingFam_nonfam005_10= batchProduceOutputFigAndTable(xSPM,defaultCor,1,'fameEffect_OverlapSubseqMemEff_005_10');
load('priorFaceRatingOnMemoryPerformance_noOutliers_updated.mat');
plotBarFig([mean(dataRaw.pca50.easy(:,1)),mean(dataRaw.pca50.diffi(:,1))],...
    [std(dataRaw.pca50.easy(:,1)),std(dataRaw.pca50.diffi(:,1))]/sqrt(20),...
    'PKM-Behavioral-PCA-50Percential', 7, 'Hit rate',pwd,[3 6]);


%check my own understanding that first parametric modulator effects will
%not change no matter whether regressor orthog is turned off or not.
%if the first condition regression correlated with first paramertric
%regressor, the first condition effects will be reduced if orthog is turned
%off.
isFamOnly =0;
dataNames = {'performance'};
for i = 2:20
    disp(i)
    
    
    firstlevelPmodBothFamNFam_NoOrthog(i,dataNames{1},isFamOnly);
    
end

dataNames = {'performance'};
isFamOnly = 0;


secondLevelvoxelPmodAnaysis_NoOrthog(dataNames{1},isFamOnly);


rDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelPmodAnalysis\performance_NoOrthog';
SecondLevelROIMarsbarAnalysisGeneral(rDir);

% easy remember/forgotten vs. difficult remember/forgotten
makeMultiPmod_RememberVsForgotten(1:20);
for subj=2:20
firstlevelAnalysisEasyVsDiff_RememberVsForgotten(subj);
end
secondLevel_EasyVsDifficult_RememberVsForgotten;
rDir = 'D:\myStudy\picpairfMRI\secondLevelAnalysis-EasyDiffRemForgotten';
SecondLevelROIMarsbarAnalysisGeneral(rDir);


% june 13,2017

%contrast 9 and 10 are for fam1 and fam2
for i = 1:20
filenames1{i}=['D:\myStudy\picpairfMRI\s',sprintf('%03d',i),'\encoding\analysis\con_0009.img'];
filenames2{i}=['D:\myStudy\picpairfMRI\s',sprintf('%03d',i),'\encoding\analysis\con_0010.img'];


end
maskDir2 = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\masks';
rois = {'L_HPC.img', 'R_HPC.img', 'L_PPA.img', 'R_PPA.img',...
    'L_FFA.img', 'R_FFA.img', 'L_TMP.img', 'R_TMP.img',...
    'L_vmP.img', 'R_vmP.img'};

