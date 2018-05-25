function MultiCondForRestingMotionCovAnalysis
for i = 1:180
names{i} = sprintf('%03d',i);

[durations{i}]=0;

onsets{i} = (i-1)*2;
end


save('C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\matlabFunctions\MultiCond-ForRestingMotionCovAnalysis.mat','names','durations','onsets');

