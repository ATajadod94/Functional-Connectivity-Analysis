function pmod = makeMultiPmodFileAsCovariate_usingOriginalEmotionRatingScores(subID, dataName,isFamOnly,isBinarized)

if nargin <4
    isBinarized =0;
end
rootDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\';
codeDir= [rootDir,'matlabFunctions\'];
dataRootDir = 'D:\myStudy\picpairfMRI\';
subDir = [dataRootDir, 's',sprintf('%03d',subID),'\'];
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
    data = picsEval(:,1:4); %already only 60 picpair
else
    
    idScrm = find(cell2mat(stimEncode1.fmpair(:,5))==999); %scrambles id
    idPics = setdiff(1:96, idScrm)'; %pictures id
    
    data = data(idPics,:);% delete scramble id, keep the 60 picpair
end



if strcmp(dataName, 'performance')
    data(find(data==0))=-1;
elseif strcmp(dataName, 'easyDifficult')
    data(find(data==2))=-1; %difficult trails coded as -1
elseif isBinarized ==1;
    data(find(data<4))=-1;
    data(find(data>3))=1;
else data = data; %-repmat(mean(data),size(data,1),1);
end



names = cell(1,8);
durations = cell(1,8);
onsets =cell(1,8);

names{1} = 'Fam1';
names{2} = 'FamScramble_1';
names{3} = 'Fam2';
names{4} = 'FamScramble_2';
names{5} = 'NFam_1';
names{6} = 'NFamScramble_1';
names{7} = 'NFam_2';
names{8} = 'NFamScramble_2';

[durations{1:8}]=deal(0);

onsets{1} = stim1(:,1);
onsets{2} = stim2(:,1);
onsets{3} = stim1(:,2);
onsets{4} = stim2(:,2);
onsets{5} = stim1(:,3);
onsets{6} = stim2(:,3);
onsets{7} = stim1(:,4);
onsets{8} = stim2(:,4);

%parameter modulation
pmod = struct('name',{''},'param',{},'poly',{});

pmod(1).name{1} = [dataName,'_Fam1'];
pmod(1).param{1} = data(:,1);
pmod(1).poly{1} = 1;

pmod(3).name{1} = [dataName,'_Fam2'];
pmod(3).param{1} = data(:,2);
pmod(3).poly{1} = 1;

if isFamOnly==0
    
    pmod(5).name{1} = [dataName,'_NFam1'];
    pmod(5).param{1} = data(:,3);
    pmod(5).poly{1} = 1;
    
    pmod(7).name{1} = [dataName,'_NFam2'];
    pmod(7).param{1} = data(:,4);
    pmod(7).poly{1} = 1;
end

save([behavDataDir,dataName,'multiCondPmod-AsCovariateUsingRawRating-',num2str(isFamOnly),'.mat'],'names','durations','onsets',...
    'pmod');





    
    
    
    
    
    
    
