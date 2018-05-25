function normalizeGrayWhiteCSF(subID)
% List of open inputs
% Normalise: Write: Parameter File - cfg_files
% Normalise: Write: Images to Write - cfg_files
projDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\';
subDir = [projDir,'s',sprintf('%03d',subID),'\'];
imgDir = [subDir,'scanImgData\run_0003\'];
imgFiles{1,1} = [imgDir,'c1vol_0001.img'];
imgFiles{2,1} = [imgDir,'c2vol_0001.img'];
imgFiles{3,1} = [imgDir,'c3vol_0001.img'];
nrun = 1; % enter the number of runs here
jobfile = {'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\matlabFunctions\normalizeGrayWhiteCSF_job.m'};
jobs = repmat(jobfile, 1, nrun);
inputs = cell(2, nrun);
for crun = 1:nrun
    inputs{1, crun} = {[imgDir,'vol_0001_seg_sn.mat']}; % Normalise: Write: Parameter File - cfg_files
    inputs{2, crun} = imgFiles; % Normalise: Write: Images to Write - cfg_files
end
spm('defaults', 'FMRI');
spm_jobman('serial', jobs, '', inputs{:});
