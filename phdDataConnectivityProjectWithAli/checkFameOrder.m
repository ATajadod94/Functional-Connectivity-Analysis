function checkedORder = checkFameOrder(subID)
% this function is used to check the fame order during the encoding task,
% by retrieving the eprime txt file and finding Fam vs Nfam strings
% if correct, it will output 1 famous first or 2 nonfamous first
% if not correct, it will outupt zero
% zhongxu Liu

rootDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\';
dataDir = [rootDir,'s',sprintf('%03d',subID),'\performanceData\',...
    's',sprintf('%03d',subID),'\'];

if mod(subID,2) == 1
    fameOrder =1;
elseif mod(subID,2)==0
    fameOrder =2;
end


fileName1 = ['PicPairfMRI_',sprintf('%02d',subID),'-1-3.txt'];
fileName2 = ['PicPairfMRI_',sprintf('%02d',subID),'-1-4.txt'];
fileName3 = ['PicPairfMRI_',sprintf('%02d',subID),'-1-6.txt'];
fileName4 = ['PicPairfMRI_',sprintf('%02d',subID),'-1-7.txt'];


[a dataBlc_1] = xlsread([dataDir,fileName1]);
[a dataBlc_2] = xlsread([dataDir,fileName2]);
[a dataBlc_3] = xlsread([dataDir,fileName3]);
[a dataBlc_4] = xlsread([dataDir,fileName4]);

if fameOrder ==1
realBlcOrder(1)= strncmp(dataBlc_1(53,3),'StudyFamPairTrialList1',22);
realBlcOrder(2)= strncmp(dataBlc_2(25,3),'StudyFamPairTrialList2',22);

realBlcOrder(3)= strncmp(dataBlc_3(53,3),'StudyNFamPairTrialList1',23);
realBlcOrder(4)= strncmp(dataBlc_4(53,3),'StudyNFamPairTrialList2',23);

elseif fameOrder ==2
realBlcOrder(1)= strncmp(dataBlc_3(53,3),'StudyFamPairTrialList1',22);
realBlcOrder(2)= strncmp(dataBlc_4(25,3),'StudyFamPairTrialList2',22);

realBlcOrder(3)= strncmp(dataBlc_1(53,3),'StudyNFamPairTrialList1',23);
realBlcOrder(4)= strncmp(dataBlc_2(53,3),'StudyNFamPairTrialList2',23);
end

if sum(realBlcOrder) == 4
    disp('order checked, correct!')    
    checkedORder =fameOrder;
else
    disp('!!!order may be incorrected!!!!')
    
    checkedORder =0; 
end