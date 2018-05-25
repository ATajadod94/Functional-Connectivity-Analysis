function concatenateMotionData(subID,runGlobalReg)
%concatenate task runs


participantNumber = sprintf('%03d',subID);

rootDir = ['C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\s',...
    participantNumber,'\'];
fileInitial = 'rp';
outputDir = [rootDir,'encoding\','taskRunsConcatenate\'];


fameOrder = checkFameOrder(subID); % get checked fame order from another func

if fameOrder ==0
error('please check fame order');
end

if fameOrder ==1
    
    rootRun1 = [rootDir,'scanImgData\run_0005\'];
    rootRun2 = [rootDir,'scanImgData\run_0006\'];
    rootRun3 = [rootDir,'scanImgData\run_0008\'];
    rootRun4 = [rootDir,'scanImgData\run_0009\'];
else    
    rootRun1 = [rootDir,'scanImgData\run_0008\'];
    rootRun2 = [rootDir,'scanImgData\run_0009\'];
    rootRun3 = [rootDir,'scanImgData\run_0005\'];
    rootRun4 = [rootDir,'scanImgData\run_0006\'];
end

%famouse encoding 1

run1 = dir([rootRun1,'rp*.txt']);
motion1 = textread([rootRun1,run1.name]);


%famouse encoding 2

run2 = dir([rootRun2,'rp*.txt']);
motion2 = textread([rootRun2,run2.name]);



%nonfamouse encoding 1
run3 = dir([rootRun3,'rp*.txt']);
motion3 = textread([rootRun3,run3.name]);

%nonfamouse encoding 2
run4 = dir([rootRun4,'rp*.txt']);
motion4 = textread([rootRun4,run4.name]);

motion = cat(1,motion1,motion2,motion3,motion4);

load runDrift; %within run linear drift, caluclation method got from Connie

if runGlobalReg ==1
load runGlobal;
motionParameter = cat(2,motion,runDrift,runGlobal);
else
 motionParameter = cat(2,motion,runDrift);
end

save([outputDir,'motionParameter.txt'],'-ascii', 'motionParameter');