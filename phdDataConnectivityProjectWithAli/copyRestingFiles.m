function copyRestingFiles(subID)

participantNum=sprintf('%03d',subID);

fameOrder = checkFameOrder(subID); % get checked fame order from another func

if fameOrder ==0
    error('please check fame order');
end

%make participant folder
projDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\';

if ~exist([projDir,'s',participantNum],'dir')
    mkdir([projDir,'s',participantNum]);
end
rootDir = [projDir,'s',participantNum,'\'];

if ~exist([rootDir,'prepostEncoding\preBaseline'],'dir')
    mkdir([rootDir,'prepostEncoding\preBaseline']);
end

if ~exist([rootDir,'prepostEncoding\postFam'],'dir')
    mkdir([rootDir,'prepostEncoding\postFam']);
end

if ~exist([rootDir,'prepostEncoding\postNonFam'],'dir')
    mkdir([rootDir,'prepostEncoding\postNonFam']);
end

copyImgHdrFiles([rootDir,'scanImgData\run_0004\'],...
    [rootDir,'prepostEncoding\preBaseline\']);

if mod(str2num(participantNum),2)~=0
    copyImgHdrFiles([rootDir,'scanImgData\run_0007\'],...
        [rootDir,'prepostEncoding\postFam\']);
    
    copyImgHdrFiles([rootDir,'scanImgData\run_0010\'],...
        [rootDir,'prepostEncoding\postNonFam\']);
end

if mod(str2num(participantNum),2)==0
    copyImgHdrFiles([rootDir,'scanImgData\run_0010\'],...
        [rootDir,'prepostEncoding\postFam\']);
    
    copyImgHdrFiles([rootDir,'scanImgData\run_0007\'],...
        [rootDir,'prepostEncoding\postNonFam\']);
end

function copyImgHdrFiles(inputFolder,outputFolder)
f = dir([inputFolder,'s*.img']);
for i = 1:length(f)
    copyfile([inputFolder,f(i).name],...
        [outputFolder,sprintf('%04d',i),'.img']);
end
f = dir([inputFolder,'s*.hdr']);
for i = 1:length(f)
    copyfile([inputFolder,f(i).name],...
        [outputFolder,sprintf('%04d',i),'.hdr']);
end