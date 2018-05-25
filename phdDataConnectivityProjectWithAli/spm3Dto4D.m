function spm3Dto4D(subID)
subj3DDir = ['C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\s',...
    sprintf('%03d',subID),'\encoding\taskRunsConcatenate\'];
subj4DDir = ['C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\s',...
    sprintf('%03d',subID),'\plsData\'];
if ~exist(subj4DDir,'dir')
    mkdir(subj4DDir);
end
file3D = dir([subj3DDir,'*.img']);
% List of open inputs
% 3D to 4D File Conversion: 3D Volumes - cfg_files
% 3D to 4D File Conversion: Output Filename - cfg_entry


nrun = 1; % enter the number of runs here
jobfile = {'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\matlabFunctions\spm3Dto4D_job.m'};
jobs = repmat(jobfile, 1, nrun);
inputs = cell(2, nrun);
for crun = 1:nrun
    
    for k = 1:size(file3D,1)

        inputs{1, crun}(k) = {[subj3DDir,file3D(k).name]}; % 3D to 4D File Conversion: 3D Volumes - cfg_files
    end
    inputs{2, crun} = [subj4DDir,'plsDataRun',num2str(crun)]; % 3D to 4D File Conversion: Output Filename - cfg_entry
end
spm('defaults', 'FMRI');
spm_jobman('serial', jobs, '', inputs{:});





% nrun = 4; % enter the number of runs here
% jobfile = {'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\matlabFunctions\spm3Dto4D_job.m'};
% jobs = repmat(jobfile, 1, nrun);
% inputs = cell(2, nrun);
% for crun = 1:nrun
%     
%     for k = 1:287
%         m=(crun-1)*287+1:crun*287;
%         inputs{1, crun}(k) = {[subj3DDir,file3D(m(k)).name]}; % 3D to 4D File Conversion: 3D Volumes - cfg_files
%     end
%     inputs{2, crun} = [subj4DDir,'plsDataRun',num2str(crun)]; % 3D to 4D File Conversion: Output Filename - cfg_entry
% end
% spm('defaults', 'FMRI');
% spm_jobman('serial', jobs, '', inputs{:});
