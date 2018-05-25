function trialCountStats

rootDir = 'D:\myStudy\picpairfMRI\';
for i = 1:20
    subjDir = [rootDir,'s',sprintf('%03d',i),'\performanceData\'];
    varName = 'emotionEval';
    [bEmotion(i,:) bbEmotion(i,:)] = getTheTrialNum(varName,subjDir);
    
        varName = 'memoryEval';
    [bMemory(i,:) bbMemory(i,:)] = getTheTrialNum(varName,subjDir);
    
        varName = 'familiarityEval';
    [bFamiliarity(i,:) bbFamiliarity(i,:)] = getTheTrialNum(varName,subjDir);
    
        varName = 'attractivenessEval';
    [bAttract(i,:) bbAttract(i,:)] = getTheTrialNum(varName,subjDir);
    
end


mEmotion = mean(bbEmotion)
mMemory = mean(bbMemory)
mFamiliarity = mean(bbFamiliarity)
mAttract = mean(bbAttract)




function [b bb] = getTheTrialNum(varName,subjDir)

load([subjDir,varName,'.mat']);
dataEval = eval(varName);
b=[length(find(dataEval(:,1) ==1)),...
   length(find(dataEval(:,1) ==2)),...
   length(find(dataEval(:,1) ==3)),...
   length(find(dataEval(:,1) ==4)),...
   length(find(dataEval(:,1) ==5))];
bb=[sum(b(1:3)),sum(b(4:5))];