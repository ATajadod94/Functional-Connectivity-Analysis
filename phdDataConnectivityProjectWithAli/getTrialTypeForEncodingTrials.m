function trialType = getTrialTypeForEncodingTrials(typeFlag)
rootDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\';
codeDir= [rootDir,'matlabFunctions\'];
load([codeDir,'myDesigntestPicpairFinal.mat']);
load([codeDir,'stim1Concat.mat']);
load([codeDir,'stim2Concat.mat']);
    idScrm = find(cell2mat(stimEncode1.fmpair(:,5))==999); %scrambles id
    idPics = setdiff(1:96, idScrm)'; %pictures id

idIntactInRetr = cell2mat(testpair.flist(:,7))==typeFlag; % 1: intact 2 recombined
idFamInRetr = cell2mat(testpair.flist(:,6))==1;
idNFamInRetr = cell2mat(testpair.flist(:,6))==0;

idFamInRetr = idFamInRetr.*idIntactInRetr;
idNFamInRetr = idNFamInRetr.*idIntactInRetr;

faceNameFam = testpair.flist(find(idFamInRetr==1),1);
faceNameNFam = testpair.flist(find(idNFamInRetr==1),1);
houseNameFam = testpair.flist(find(idFamInRetr==1),2);
houseNameNFam = testpair.flist(find(idNFamInRetr==1),2);

[idd,idaF1,idbF]=intersect(stimEncode1.fmpair(:,1),faceNameFam);
[idd,idaH1,idbH]=intersect(stimEncode1.fmpair(:,2),houseNameFam);
[idd,idaF2,idbF]=intersect(stimEncode1.fmShuffled{1}(:,1),faceNameFam);
[idd,idaH2,idbH]=intersect(stimEncode1.fmShuffled{1}(:,2),houseNameFam);


trialType=zeros(96,4);
trialType(idaF1,1)=1;
trialType(idaF2,2)=1;

%nonfamouse

[idd,idaF3,idbF]=intersect(stimEncode1.nfmpair(:,1),faceNameNFam);
[idd,idaH3,idbH]=intersect(stimEncode1.nfmpair(:,2),houseNameNFam);
[idd,idaF4,idbF]=intersect(stimEncode1.nfmShuffled{1}(:,1),faceNameNFam);
[idd,idaH4,idbH]=intersect(stimEncode1.nfmShuffled{1}(:,2),houseNameNFam);
trialType(idaF3,3)=1;
trialType(idaF4,4)=1;