
for i = 1:20
dataDir = ['D:\myStudy\picpairfMRI\s',sprintf('%03d',i),'\performanceData\'];
if strcmp(memType,'pair')==1
    load([dataDir,'retrievalDataUpdatedMethod.mat']);
    memData(:,i) = intactRecogFam1;% + recomRecogFam1(:,3);
end

load([dataDir,'familiarityEval.mat']);
load([dataDir,'memoryEval.mat']);
load([dataDir,'emotionEval.mat']);
load([dataDir,'attractivenessEval.mat']);
fData(:,i)=familiarityEval(:,1);
mData(:,i) = memoryEval(:,1);
eData(:,i) = emotionEval(:,1);
aData(:,i) = attractivenessEval(:,1);
end
load(['C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\matlabFunctions\myDesigntestPicpairFinal.mat']);

idOldOld1 = cell2mat(testpair.flist(:,7))==1;
idOldOld2= cell2mat(testpair.flist(:,7))==2;
idOldOld=idOldOld1+idOldOld2;
faceNameON = testpair.flist(logical(idOldOld),1);
[a b c]=intersect(faceNameON,stimEncode1.fmpair(:,1));
idOldOld = false(96,1);
idOldOld(c) = true;

fData = fData(idOldOld,:);
mData = mData(idOldOld,:);
eData = eData(idOldOld,:);
aData = aData(idOldOld,:);
memData = memData(idOldOld,:);

fData = fData(c,:);
mData = mData(c,:);
eData = eData(c,:);
aData = aData(c,:);
memData = memData(c,:);

% for i = 1:20
%     [R1subj(:,:,i),P1subj(:,:,i)]=corr([memData(:,i),aData(:,i),eData(:,i),fData(:,i),mData(:,i)]);
%  
% end

data=[mean(memData,2),mean(aData,2),mean(eData,2),mean(fData,2),mean(mData,2)];
corr(data)

data=[mean(memData,1)',mean(aData,1)',mean(eData,1)',mean(fData,1)',mean(mData,1)'];
[r p]=corr(data)

data=[reshape(memData,size(memData,1)*size(memData,2),1),...
    reshape(aData,size(aData,1)*size(aData,2),1),...
    reshape(eData,size(eData,1)*size(eData,2),1),...
    reshape(fData,size(fData,1)*size(fData,2),1),...
    reshape(mData,size(mData,1)*size(mData,2),1)];
corr(data)
figure; scatter(data(:,5),data(:,1));