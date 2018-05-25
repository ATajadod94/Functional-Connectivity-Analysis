participantNumber = '004';    
datapath = ['C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\',...
        's', participantNumber,'\performanceData\'];
    outpath = datapath;
   
%load face evaluation data
load ([datapath,'RetrievalDataForfMRIDesign.mat']);

load myDesigntestPicpairFinal
load stim1Concat
load stim2Concat

idPicpair = find(myDesignEncode1.picDur==3500);
idScramble = find(myDesignEncode1.picDur==1500);




% choose the performance data we need to use
data = singleHouse;
stimSequenceFam1 = zeros(96,1);
stimSequenceFam1(data.fam{1},1) = 1;

stimSequenceFam2 = zeros(96,1);
stimSequenceFam2(data.fam{2},1) = 1;

stimSequenceNFam1 = zeros(96,1);
stimSequenceNFam1(data.nfam{1},1) = 1;

stimSequenceNFam2 = zeros(96,1);
stimSequenceNFam2(data.nfam{2},1) = 1;

%calculate the ids for remembered and forgotten items/pairs
idRememberedFam1 = find(stimSequenceFam1(idPicpair,:)==1);
idRememberedFam2 = find(stimSequenceFam2(idPicpair,:)==1);
idRememberedNFam1 = find(stimSequenceNFam1(idPicpair,:)==1);
idRememberedNFam2 = find(stimSequenceNFam2(idPicpair,:)==1);

idForgottenFam1 = find(stimSequenceFam1(idPicpair,:)==0);
idForgottenFam2 = find(stimSequenceFam2(idPicpair,:)==0);
idForgottenNFam1 = find(stimSequenceNFam1(idPicpair,:)==0);
idForgottenNFam2 = find(stimSequenceNFam2(idPicpair,:)==0);

%make design matrix mulitcond mat file
%10 conditions
names = cell(1,12);
durations = cell(1,12);
onsets =cell(1,12);

names{1} = 'FamRemembered_1';
names{2} = 'FamForgotten_1';
names{3} = 'FamScramble_1';

names{4} = 'FamRemembered_2';
names{5} = 'FamForgotten_2';
names{6} = 'FamScramble_2';

names{7} = 'NFamRemembered_1';
names{8} = 'NFamForgotten_1';
names{9} = 'NFamScramble_1';

names{10} = 'NFamRemembered_2';
names{11} = 'NFamForgotten_2';
names{12} = 'NFamScramble_2';


[durations{1:12}]=deal(0);

onsets{1} = stim1(idRememberedFam1,1);
onsets{2} = stim1(idForgottenFam1,1);
onsets{3} = stim2(:,1);

onsets{4} = stim1(idRememberedFam2,2);
onsets{5} = stim1(idForgottenFam2,2);
onsets{6} = stim2(:,2);

onsets{7} = stim1(idRememberedNFam1,3);
onsets{8} = stim1(idForgottenNFam1,3);
onsets{9} = stim2(:,3);

onsets{10} = stim1(idRememberedNFam2,4);
onsets{11} = stim1(idForgottenNFam2,4);
onsets{12} = stim2(:,4);


save([outpath,'multiCond-MemoryPerformanceSingleHouse.mat'],'names','durations','onsets');