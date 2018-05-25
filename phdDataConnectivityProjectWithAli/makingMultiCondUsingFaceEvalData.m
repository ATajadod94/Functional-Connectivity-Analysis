participantNumber = '004';    
datapath = ['C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\',...
        's', participantNumber,'\performanceData\'];
    outpath = datapath;
   
%load face evaluation data
load ([datapath,'memoryEval.mat']);
load ([datapath,'familiarityEval.mat']);
load myDesigntestPicpairFinal
load stim1Concat
load stim2Concat

idPicpair = find(myDesignEncode1.picDur==3500);
idScramble = find(myDesignEncode1.picDur==1500);
faceFamiliarEval = familiarityEval(idPicpair,:);
faceMemoryEval = memoryEval(idPicpair,:);

%find memory evaluation score >= 3 trials

[idHighEval,j] = find(faceMemoryEval(:,:)>=3);
idHighEvalEncode1 = idHighEval(j==1); %for encoding 1
idHighEvalEncode2 = idHighEval(j==2); %for encoding 2

[idLowEval,j] = find(faceMemoryEval(:,:)<=2);
idLowEvalEncode1 = idLowEval(j==1); %for encoding 1
idLowEvalEncode2 = idLowEval(j==2); %for encoding 2
%make design matrix mulitcond mat file
%10 conditions
names = cell(1,10);
durations = cell(1,10);
onsets =cell(1,10);

names{1} = 'FamHighEval_1';
names{2} = 'FamLowEval_1';
names{3} = 'FamScramble_1';

names{4} = 'FamHighEval_2';
names{5} = 'FamLowEval_2';
names{6} = 'FamScramble_2';

names{7} = 'NFam_1';
names{8} = 'NFamScramble_1';

names{9} = 'NFam_2';
names{10} = 'NFamScramble_2';

[durations{1:10}]=deal(0);
onsets{1} = stim1(idHighEvalEncode1,1);
onsets{2} = stim1(idLowEvalEncode1,1);
onsets{3} = stim2(:,1);

onsets{4} = stim1(idHighEvalEncode2,2);
onsets{5} = stim1(idLowEvalEncode2,2);
onsets{6} = stim2(:,2);

onsets{7} = stim1(:,3);
onsets{8} = stim2(:,3);

onsets{9} = stim1(:,4);
onsets{10} = stim2(:,4);

save([outpath,'multiCond-faceEval.mat'],'names','durations','onsets');