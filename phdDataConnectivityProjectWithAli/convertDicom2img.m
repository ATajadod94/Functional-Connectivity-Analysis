% %%
% %******************************* making folders***************************
% % this only need be done once for each subject at the very beginning, before
% % any real analysis starts.
% subID=[7];
% participantNumber = ['s',sprintf('%03d',subID)];
% participantNum=sprintf('%03d',subID);
% 
% %make participant folder
% projDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\';
% 
% if ~exist([projDir,participantNumber],'dir')
%     mkdir([projDir,participantNumber]);
% end
% 
% %make subfolders for the participant
% rootDir = [projDir,participantNumber,'\'];
% 
% if ~exist([rootDir,'scanImgData'],'dir')
%     mkdir([rootDir,'scanImgData']);
% end
% 
% if ~exist([rootDir,'scanRawData'],'dir')
%     mkdir([rootDir,'scanRawData']);
% end
% 
% 
% if ~exist([rootDir,'physioData'],'dir')
%     mkdir([rootDir,'physioData']);
% end
% 
% if ~exist([rootDir,'performanceData'],'dir')
%     mkdir([rootDir,'performanceData']);
% end
% 
% if ~exist([rootDir,'prepostEncoding'],'dir')
%     mkdir([rootDir,'prepostEncoding']);
% end
% 
% 
% if ~exist([rootDir,'encoding'],'dir')
%     mkdir([rootDir,'encoding']);
% end
% 
% if ~exist([rootDir,'encoding\taskRunsConcatenate'],'dir')
%     mkdir([rootDir,'encoding\taskRunsConcatenate']);
% end
% 
% if ~exist([rootDir,'encoding\analysis'],'dir')
%     mkdir([rootDir,'encoding\analysis']);
% end
% 
% if ~exist([rootDir,'localization'],'dir')
%     mkdir([rootDir,'localization']);
% end
% 
% if ~exist([rootDir,'resting'],'dir')
%     mkdir([rootDir,'resting']);
% end

%%
% ********************convert dicom to img/hrd format for spm8************
% this only need be done once for each subject at the very beginning, before
% any real analysis starts. need spmtool

% for run = 3:13
% dicom2nifti('dicom_dir',[rootDir,'scanRawData\SCANS\',num2str(run),'\DICOM'],...
%       'subject_dir', [rootDir,'scanImgData'],'format','img','autodetect','no');
% end

%%
%**************************************************************************
%************* Delete the first a few volumes******************************
%**************************************************************************
%**************************************************************************
%elete the first 3 volumes (if change this parameter, we also need to
%change the design matric time point; therefore, this parameter should be
%connected with design matric, e.g., if nRunDel > 3, then the design
%matrix and behavioral data, also should be modified.
nVolDel = 3
for run = 4:13
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
    
    % if ismember(run, [4 7 10 12 13])
    %    delete([funDir,funVol(184).name]);
    % delete([funDir,funHDR(184).name]);
    % end
end
%%

% delete useless processing files after finish preprocessing
for run = 4:13
    funDir = [rootDir,'scanImgData\run_',sprintf('%04d',run),'\'];
    delete([funDir,'v*.*']); % delete original volumes
    delete([funDir,'av*.*']); % delete time slicing corrected volumes
    delete([funDir,'ra*.*']); % delete relicing volumes
    delete([funDir,'wr*.*']);% delete normalized volumes (before smoothing)
end
    
%%
%copy files to different task folders

%call a self-made functin to concatenate the runs
concatenateTaskRuns(2,participantNum); % 2: fame order nonfamous first '02' subject number, related to the folder containing subject's data
concatenateMotionData(2,participantNum,0);
getLocalizerBlockOnsetTime(participantNum);


% for run = [5 6 8 9]
%     funDir = [rootDir,'scanImgData\run_',sprintf('%04d',run),'\'];
%     delete([funDir,'v*.*']); %BE CAREFUL NOT delete all files because motion parameters should be kept ***
% end

