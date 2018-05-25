function makeMultiCondMatFileUsingAllDiffMems(subID)

rootDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\';
codeDir= [rootDir,'matlabFunctions\'];
subDir = ['D:\myStudy\picpairfMRI\s',sprintf('%03d',subID),'\'];
behavDataDir = [subDir,'performanceData\'];

%load design data
load([codeDir,'myDesigntestPicpairFinal.mat']);
load([codeDir,'stim1Concat.mat']);
load([codeDir,'stim2Concat.mat']);
%load behavorial data
load([behavDataDir,'RetrivalMemTypeFileForMakingMulitCond.mat']);

data=[];
data(:,1)=triTypeFam(:,2);
data(:,2)=triTypeFam2(:,2);
data(:,3)=triTypeNFam(:,2);
data(:,4)=triTypeNFam2(:,2);

idScrm = find(cell2mat(stimEncode1.fmpair(:,5))==999); %scrambles id
idPics = setdiff(1:96, idScrm)'; %pictures id

data = data(idPics,:);



idFam1PairAssoRem = find(data(:,1)==3);
idFam1PairNoAssoRem = find(data(:,1)==2);
idFam1FaceOnlyRem = find(data(:,1)==4);
idFam1HouseNonRem = find(data(:,1)==5 | data(:,1)==0 | data(:,1)==1);
length([idFam1PairAssoRem;idFam1PairNoAssoRem;idFam1FaceOnlyRem;idFam1HouseNonRem])

idFam2PairAssoRem = find(data(:,2)==3);
idFam2PairNoAssoRem = find(data(:,2)==2);
idFam2FaceOnlyRem = find(data(:,2)==4);
idFam2HouseNonRem = find(data(:,2)==5 | data(:,2)==0 | data(:,2)==1);
length([idFam2PairAssoRem;idFam2PairNoAssoRem;idFam2FaceOnlyRem;idFam2HouseNonRem])

idNFam1PairAssoRem = find(data(:,3)==3);
idNFam1PairNoAssoRem = find(data(:,3)==2);
idNFam1FaceOnlyRem = find(data(:,3)==4);
idNFam1HouseNonRem = find(data(:,3)==5 | data(:,3)==0 | data(:,3)==1);
length([idNFam1PairAssoRem;idNFam1PairNoAssoRem;idNFam1FaceOnlyRem;idNFam1HouseNonRem])

idNFam2PairAssoRem = find(data(:,4)==3);
idNFam2PairNoAssoRem = find(data(:,4)==2);
idNFam2FaceOnlyRem = find(data(:,4)==4);
idNFam2HouseNonRem = find(data(:,4)==5 | data(:,4)==0 | data(:,4)==1);
length([idNFam2PairAssoRem;idNFam2PairNoAssoRem;idNFam2FaceOnlyRem;idNFam2HouseNonRem])


names = cell(1,20);
durations = cell(1,20);
onsets =cell(1,20);

names{1} = 'Fam1_PairAssoRem';
names{2} = 'Fam1_PairNoAssoRem';
names{3} = 'Fam1_FaceOnlyRem';
names{4} = 'Fam1_HouseNonRem';

names{5} = 'FamScramble_1';

names{6} = 'Fam2_PairAssoRem';
names{7} = 'Fam2_PairNoAssoRem';
names{8} = 'Fam2_FaceOnlyRem';
names{9} = 'Fam2_HouseNonRem';

names{10} = 'FamScramble_2';

names{11} = 'NFam1_PairAssoRem';
names{12} = 'NFam1_PairNoAssoRem';
names{13} = 'NFam1_FaceOnlyRem';
names{14} = 'NFam1_HouseNonRem';

names{15} = 'NFamScramble_1';

names{16} = 'NFam2_PairAssoRem';
names{17} = 'NFam2_PairNoAssoRem';
names{18} = 'NFam2_FaceOnlyRem';
names{19} = 'NFam2_HouseNonRem';

names{20} = 'NFamScramble2';

[durations{1:20}]=deal(0);

onsets{1} = stim1(idFam1PairAssoRem,1);
onsets{2} = stim1(idFam1PairNoAssoRem,1);
onsets{3} = stim1(idFam1FaceOnlyRem,1);
onsets{4} = stim1(idFam1HouseNonRem,1);
onsets{5} = stim2(:,1);

onsets{6} = stim1(idFam2PairAssoRem,2);
onsets{7} = stim1(idFam2PairNoAssoRem,2);
onsets{8} = stim1(idFam2FaceOnlyRem,2);
onsets{9} = stim1(idFam2HouseNonRem,2);

onsets{10} = stim2(:,2);

onsets{11} = stim1(idNFam1PairAssoRem,3);
onsets{12} = stim1(idNFam1PairNoAssoRem,3);
onsets{13} = stim1(idNFam1FaceOnlyRem,3);
onsets{14} = stim1(idNFam1HouseNonRem,3);

onsets{15} = stim2(:,3);

onsets{16} = stim1(idNFam2PairAssoRem,4);
onsets{17} = stim1(idNFam2PairNoAssoRem,4);
onsets{18} = stim1(idNFam2FaceOnlyRem,4);
onsets{19} = stim1(idNFam2HouseNonRem,4);

onsets{20} = stim2(:,4);

save([behavDataDir,'DiffMmeTypeMultiCond.mat'],'names','durations','onsets');

