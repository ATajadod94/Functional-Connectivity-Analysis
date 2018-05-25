function copyDataToPLS

%******************************* making folders***************************
% this only need be done once for each subject once
participantNumber = 'participant01';

%make participant folder
projDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\';



%make PLSData subfolders for the participant
rootDir = [projDir,participantNumber,'\'];

if ~exist([rootDir,'PLSData'],'dir')
    mkdir([rootDir,'PLSData']);
end

%copy preprocessed scanImgData files to PLSData. the preprocessing is done
%before the normalization

for run = 3:13
    
if ~exist([rootDir,'PLSData\','run_',sprintf('%04d',run)],'dir')
    mkdir([rootDir,'PLSData\','run_',sprintf('%04d',run)]);
end
 
end


sourceDir = [rootDir,'scanImgData\'];
PLSDir = [rootDir,'PLSData\'];
for run = 3:13
    if run ==3
        fileNames = '*.*';
    else
        fileNames = 'a*.*';
    end
    
    copyfile( fullfile(sourceDir,['run_',sprintf('%04d',run)],fileNames),...
         [PLSDir,'run_',sprintf('%04d',run),'\']);
     
end

