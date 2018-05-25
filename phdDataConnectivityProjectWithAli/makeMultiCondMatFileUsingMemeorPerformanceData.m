function makeMultiCondMatFileUsingMemeorPerformanceData(subID,dataName,isFamOnly)

rootDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\';
codeDir= [rootDir,'matlabFunctions\'];
subDir = [rootDir, 's',sprintf('%03d',subID),'\'];
behavDataDir = [subDir,'performanceData\'];

%load design data
load([codeDir,'myDesigntestPicpairFinal.mat']);
load([codeDir,'stim1Concat.mat']);
load([codeDir,'stim2Concat.mat']);

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

if strcmp(dataName, 'performance')
    load([behavDataDir,'retrievalDataUpdatedMethod.mat']);
    data = [intactRecogFam1 + recomRecogFam1(:,3),...
        intactRecogFam2 + recomRecogFam2(:,3),...
        intactRecogNFam1 + recomRecogNFam1(:,3),...
        intactRecogNFam2 + recomRecogNFam2(:,3)];
end

if strcmp(dataName, 'easyDifficult')
    load([behavDataDir,'easyDifficultEval.mat']);
    data = picsEval(:,1:4);
else
    
    idScrm = find(cell2mat(stimEncode1.fmpair(:,5))==999); %scrambles id
    idPics = setdiff(1:96, idScrm)'; %pictures id
    
    data = data(idPics,:);
end



if strcmp(dataName, 'performance')
    data(find(data==0))=-1;
elseif strcmp(dataName, 'easyDifficult')
    data(find(data==2))=-1; %difficult trails coded as -1
else
    data = data-repmat(mean(data),size(data,1),1);
end

idFam1Rem = find(data(:,1)==1);
idFam1NonRem = find(data(:,1)==-1);

idFam2Rem = find(data(:,2)==1);
idFam2NonRem = find(data(:,2)==-1);

idNFam1Rem = find(data(:,3)==1);
idNFam1NonRem = find(data(:,3)==-1);

idNFam2Rem = find(data(:,4)==1);
idNFam2NonRem = find(data(:,4)==-1);

names = cell(1,12);
durations = cell(1,12);
onsets =cell(1,12);

names{1} = 'Fam1_rem';
names{2} = 'Fam1_notRem';
names{3} = 'FamScramble_1';
names{4} = 'Fam2_rem';
names{5} = 'Fam2_notRem';
names{6} = 'FamScramble_2';
names{7} = 'NFam1_rem';
names{8} = 'NFam1_nonRem';
names{9} = 'NFamScramble_1';
names{10} = 'NFam2';
names{11} = 'NFam2_nonRem';
names{12} = 'NFamScramble2';

[durations{1:12}]=deal(0);

onsets{1} = stim1(idFam1Rem,1);
onsets{2} = stim1(idFam1NonRem,1);
onsets{3} = stim2(:,1);
onsets{4} = stim1(idFam2Rem,2);
onsets{5} = stim1(idFam2NonRem,2);
onsets{6} = stim2(:,2);
onsets{7} = stim1(idNFam1Rem,3);
onsets{8} = stim1(idNFam1NonRem,3);
onsets{9} = stim2(:,3);
onsets{10} = stim1(idNFam2Rem,4);
onsets{11} = stim1(idNFam2NonRem,4);
onsets{12} = stim2(:,4);

save([behavDataDir,dataName,'MultiCond-',num2str(isFamOnly),'.mat'],'names','durations','onsets');





    
    
    
    
    
    
    
