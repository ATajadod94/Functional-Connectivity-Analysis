function getLocalizerBlockOnsetTime(participantNum)
% this is to get the onset for the 3 picture blocks and the output is
% stored in the participant's localization folder. Because another function
% makeLocalizerMulticondFile was made later, this function is not used. but
% it can be used to check whether the output form the two function match to
% make sure the design matrix is correct.
% zhongxu Liu

n=str2double(participantNum);
rootFolder = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\matlabFunctions\';
outFolder = ['C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\s',...
                    participantNum,'\localization\'];
load([rootFolder 'balancedAndRandomizedTaskList.mat']);
load([rootFolder 'localizerBlockOnsets.mat']);
blockSequn = cell2mat(localizerList{n}(1:2:6,4));
[a blockSequn]=sort(blockSequn);
blockOnsets = localizerBlockOnsets(:,blockSequn);
save([outFolder, 'blockOnsets.mat'],'blockOnsets');
