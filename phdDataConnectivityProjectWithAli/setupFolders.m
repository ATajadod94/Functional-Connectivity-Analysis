function setupFolders(subID)
%******************************* making folders***************************
% this only need be done once for each subject at the very beginning, before
% any real analysis starts.

participantNumber = ['s',sprintf('%03d',subID)];
participantNum=sprintf('%03d',subID);

%make participant folder
projDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\';

if ~exist([projDir,participantNumber],'dir')
    mkdir([projDir,participantNumber]);
end

%make subfolders for the participant
rootDir = [projDir,participantNumber,'\'];

if ~exist([rootDir,'scanImgData'],'dir')
    mkdir([rootDir,'scanImgData']);
end

if ~exist([rootDir,'scanRawData'],'dir')
    mkdir([rootDir,'scanRawData']);
end


if ~exist([rootDir,'physioData'],'dir')
    mkdir([rootDir,'physioData']);
end

if ~exist([rootDir,'performanceData'],'dir')
    mkdir([rootDir,'performanceData']);
end

if ~exist([rootDir,'prepostEncoding'],'dir')
    mkdir([rootDir,'prepostEncoding']);
end


if ~exist([rootDir,'encoding'],'dir')
    mkdir([rootDir,'encoding']);
end

if ~exist([rootDir,'encoding\taskRunsConcatenate'],'dir')
    mkdir([rootDir,'encoding\taskRunsConcatenate']);
end

if ~exist([rootDir,'encoding\analysis'],'dir')
    mkdir([rootDir,'encoding\analysis']);
end

if ~exist([rootDir,'localization'],'dir')
    mkdir([rootDir,'localization']);
end

if ~exist([rootDir,'resting'],'dir')
    mkdir([rootDir,'resting']);
end