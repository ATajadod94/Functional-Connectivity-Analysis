function concatenateTaskRuns(subID)
%concatenate task runs for famour first condition run005 6 8 9
% for nonfamous first condition run 008 9 5 6
%zhongxu liu

participantNumber = sprintf('%03d',subID);
rootDir = ['C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\s',...
    participantNumber,'\'];
fileInitial = 'sw';
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
elseif fameOrder ==2    
    rootRun1 = [rootDir,'scanImgData\run_0008\'];
    rootRun2 = [rootDir,'scanImgData\run_0009\'];
    rootRun3 = [rootDir,'scanImgData\run_0005\'];
    rootRun4 = [rootDir,'scanImgData\run_0006\'];
end

%famouse encoding 1
%copy .img files
run1 = dir([rootRun1,fileInitial,'*.img']);
for i = 1:length(run1)
    disp(i)
    copyfile([rootRun1,run1(i).name],[outputDir,sprintf('%04d',i),'.img']);
end
%copy.hdr files
run1 = dir([rootRun1,fileInitial,'*.hdr']);
for i = 1:length(run1)
    disp(i)
    copyfile([rootRun1,run1(i).name],[outputDir,sprintf('%04d',i),'.hdr']);
end


%famouse encoding 2
%copy .img files
run2 = dir([rootRun2,fileInitial,'*.img']);
for i = 1:length(run2)
       disp(i)
    copyfile([rootRun2,run2(i).name],[outputDir,sprintf('%04d',i+length(run1)),'.img']);
end
%copy.hdr files
run2 = dir([rootRun2,fileInitial,'*.hdr']);
for i = 1:length(run2)
       disp(i)
    copyfile([rootRun2,run2(i).name],[outputDir,sprintf('%04d',i+length(run1)),'.hdr']);
end



%nonfamouse encoding 1
%copy .img files
run3 = dir([rootRun3,fileInitial,'*.img']);
for i = 1:length(run3)
       disp(i)
    copyfile([rootRun3,run3(i).name],[outputDir,sprintf('%04d',i+length(run1)+length(run2)),'.img']);
end
%copy.hdr files
run3 = dir([rootRun3,fileInitial,'*.hdr']);
for i = 1:length(run3)
       disp(i)
    copyfile([rootRun3,run3(i).name],[outputDir,sprintf('%04d',i+length(run1)+length(run2)),'.hdr']);
end

%nonfamouse encoding 2
%copy .img files
run4 = dir([rootRun4,fileInitial,'*.img']);
for i = 1:length(run4)
       disp(i)
    copyfile([rootRun4,run4(i).name],[outputDir,sprintf('%04d',i+length(run1)+length(run2)+length(run3)),'.img']);
end
%copy .hdr files
run4 = dir([rootRun4,fileInitial,'*.hdr']);
for i = 1:length(run4)
       disp(i)
    copyfile([rootRun4,run4(i).name],[outputDir,sprintf('%04d',i+length(run1)+length(run2)+length(run3)),'.hdr']);
end



