function preprocessingAllRuns(subID)
% List of open inputs
% Slice Timing: Session - cfg_files
% Slice Timing: Session - cfg_files
% Slice Timing: Session - cfg_files
% Slice Timing: Session - cfg_files
% Slice Timing: Session - cfg_files
% Slice Timing: Session - cfg_files
% Slice Timing: Session - cfg_files
% Slice Timing: Session - cfg_files
% Slice Timing: Session - cfg_files
% Slice Timing: Session - cfg_files
% Coregister: Estimate: Source Image - cfg_files

nrun = length(subID); % enter the number of runs here
jobfile = {'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\matlabFunctions\preprocessingAll_job.m'};
jobs = repmat(jobfile, 1, nrun);
rootDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\';
inputs={};

for isub=1:length(subID)
    FUNCDIR = [rootDir,'s',sprintf('%03d',subID(isub)),'\scanImgData'];
    
    for run = 4:13
        n=run-3;
        inputs{n,isub} = GetImageList4D([FUNCDIR,'\run_',sprintf('%04d',run)], WildcardFilename('v*.img'));
    end
    % inputs = cell(11, nrun);
    
    inputs{n+1,isub} = GetImageList3D([FUNCDIR,'\run_',sprintf('%04d',3)], PlainFilename('vol_0001.img'));
end
spm('defaults', 'FMRI');
spm_jobman('serial', jobs, '', inputs{:});
