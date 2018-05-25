function deleteFirstNVol(subID, nVolDel,allRuns, restRuns)
%**************************************************************************
%************* Delete the first a few volumes******************************
%**************************************************************************
%**************************************************************************
%elete the first 3 volumes (if change this parameter, we also need to
%change the design matric time point; therefore, this parameter should be
%connected with design matric, e.g., if nRunDel > 3, then the design
%matrix and behavioral data, also should be modified.

if nargin<2
nVolDel = 3;
allRuns=[4:13];
restRuns = [4 7 10 12 13];
end

if nargin<3
allRuns=[4:13];
restRuns = [4 7 10 12 13];
end


participantNumber = ['s',sprintf('%03d',subID)];
projDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\';
rootDir = [projDir,participantNumber,'\'];

for run = allRuns
    funDir = [rootDir,'scanImgData\run_',sprintf('%04d',run),'\'];
    funVol = dir([funDir,'*.img']);
    funHDR = dir([funDir,'*.hdr']);
    
    %delete the first nVolDel volumes
    if strcmp(funVol(1).name, 'vol_0001.img')
        for i = 1:nVolDel
            delete([funDir,funVol(i).name]);
            delete([funDir,funHDR(i).name]);
        end
    else
        disp(['For run***',num2str(run)]);
        disp('*** The first volume has been deleted already.');
        disp('*** Please check the data');
        disp('*** Therefore, no new deletion is made');
    end
    
    %there is one extra volume for all rest tasks, including the last two
    %active rest tasks. for that volume the EPRIME is already finish the gray
    %"rest" screen. But the participant should not know and still in the rest
    %ask model. therefore, we can keep this volume. but if we think this may be
    %contaminated by the white screen the participant may still feel the light,
    %we should take it out and add it at the beginning. then we can have an
    %extra to delete so that our real first volume will be less affected.
    
    if ismember(run, restRuns)
       delete([funDir,funVol(184).name]);
       delete([funDir,funHDR(184).name]);
    end
end