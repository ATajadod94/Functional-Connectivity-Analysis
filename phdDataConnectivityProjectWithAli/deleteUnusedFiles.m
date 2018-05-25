function deleteUnusedFiles(subID,allRuns)
% delete useless processing files after finish preprocessing, including
% av*. v* r*

if nargin <2
    allRuns = [4:13];
end
participantNumber = ['s',sprintf('%03d',subID)];
projDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\';
rootDir = [projDir,participantNumber,'\'];

for run = allRuns
    funDir = [rootDir,'scanImgData\run_',sprintf('%04d',run),'\'];
    delete([funDir,'v*.*']); % delete original volumes
    delete([funDir,'av*.*']); % delete time slicing corrected volumes
    delete([funDir,'ra*.*']); % delete relicing volumes
%     delete([funDir,'wr*.*']);% delete normalized volumes (before smoothing)
end

%delete scanRawData and folder
if exist([rootDir,'\scanRawData'],'dir')
    fRaw = dir([rootDir,'\scanRawData\SCANS\']);
    for run = [3:length(fRaw)]-2
        delete([rootDir,'\scanRawData\SCANS\', num2str(run),'\DICOM\','*.*']);
    end
    rmdir([rootDir,'\scanRawData'],'s');
end