function makeMultipleRegressionUsingFameRatingforFirstLevelAnalysis
dataName='emotion';
rootDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\';
codeDir= [rootDir,'matlabFunctions\'];

%load design data
load([codeDir,'myDesigntestPicpairFinal.mat']);
load([codeDir,'stim1Concat.mat']);
load([codeDir,'stim2Concat.mat']);
% get design time series
picdesign = myDesignEncode1;
allTimePoint = floor(sum(picdesign.event(:,1))+4);
timePointCond1=zeros(1,allTimePoint');

%switch 1 sec to make the first indx 1 not zero
%make stim stick function
stickCond1=[];
stickCond1=floor(picdesign.tmpnt_stmcond1)+1;
stimdur1=mean(picdesign.intvl_stmcond1);
for i = 1:stimdur1
timePointCond1(stickCond1') = 1;
stickCond1=floor(stickCond1)+1;
end

idScrm = find(cell2mat(stimEncode1.fmpair(:,5))==999); %scrambles id
idPics = setdiff(1:96, idScrm)'; %pictures id


dataRootDir = 'D:\myStudy\picpairfMRI\';
for subID = 1:20
    disp(subID)
subDir = [dataRootDir, 's',sprintf('%03d',subID),'\'];
behavDataDir = [subDir,'performanceData\'];
regDataDir = [subDir,'encoding\taskRunsConcatenate\'];

%load behavorial data
if strcmp(dataName, 'memory')
    load([behavDataDir,'memoryEval.mat']);
    data = memoryEval(:,1:2);
end
if strcmp(dataName, 'emotion')
    load([behavDataDir,'emotionEval.mat']);
    data = emotionEval(:,1:4);
end

if strcmp(dataName, 'familiarity')
    load([behavDataDir,'familiarityEval.mat']);
    data = familiarityEval(:,1:4);
end

if strcmp(dataName, 'attractiveness')
    load([behavDataDir,'attractivenessEval.mat']);
    data = attractivenessEval(:,1:4);
end

data = data(idPics,:);
data([1 2 59 60],:) = repmat(mean(data(3:58,:),1),4,1);
tpdif=diff(timePointCond1);
tpStim = [1,find(tpdif==1)]
tp1=zeros(576,4);
tp1(tpStim,:)=1;
tp1(tpStim,:) =data;
for i = 1:4
tp2(:,i)=conv(tp1(:,i),spm_hrf(1));
end
tp2 = tp2(1:2:574,:);
tpFinal = cat(1,tp2(:,1),tp2(:,2),tp2(:,3),tp2(:,4));

motionReg = textread([regDataDir,'motionParameter.txt']);
motionFaceEvalReg = cat(2,tpFinal,motionReg);
save([regDataDir,'motionFaceEvalReg-',dataName,'.txt'],'-ascii', 'motionFaceEvalReg');

clear tpdif tpStim tp1 tp2 tpFinal data;
end