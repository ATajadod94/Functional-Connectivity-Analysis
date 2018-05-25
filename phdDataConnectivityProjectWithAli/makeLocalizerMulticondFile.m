function makeLocalizerMulticondFile(subID)
dataDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\matlabFunctions\';
load([dataDir,'localizerBlockOnsets.mat']);
load([dataDir, 'balancedAndRandomizedTasklist.mat']);

picSeq = cell2mat(localizerList{subID}(1:2:6,4));
% picCat = {{'Face'},{'House'},{'Object'},{'Face_fix'},{'House_fix'},{'Object_Fix'}};
picCat = {'Face','House','Object','Face_fix','House_fix','Object_Fix'};

names = cell(1,6);
durations = cell(1,6);
onsets =cell(1,6);
for i = 1:6
names{i} = picCat{i};
end

for i = 1:3
onsets{i} = localizerBlockOnsets(:,find(picSeq==i));
onsets{i+3}=onsets{i}+16.1;
end

[durations{1:3}]=deal(16.1);
[durations{4:6}]=deal(16);

save([dataDir,'localizerMulticond_s',sprintf('%03d',subID),'.mat'],'names','onsets','durations');