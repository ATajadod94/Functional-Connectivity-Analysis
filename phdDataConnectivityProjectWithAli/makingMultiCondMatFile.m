% making multirun mat file for separated runs.
load stim1Concat
load stim2Concat
for i = 1:4
names = cell(1,2);
durations = cell(1,2);
onsets =cell(1,2);
names{1} = ['picpair',num2str(i)];
names{2} = ['scrmpair',num2str(i)];
[durations{1:2}]=deal(0);
onsets{1} = stim1(:,1);
onsets{2}= stim2(:,1);
save(['mulitcond-run',num2str(i),'.mat'],'names','onsets','durations');
end