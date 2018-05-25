% List of open inputs
% fMRI model specification: Directory - cfg_files
% fMRI model specification: Scans - cfg_files
% fMRI model specification: Multiple regressors - cfg_files
nrun = 20; % enter the number of runs here
jobfile = {'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\matlabFunctions\firstLevelRestingCovariateoutMotion1_job.m'};
jobs = repmat(jobfile, 1, nrun);
inputs = cell(3, nrun);
for crun = 1:nrun
    FUNCDIR = ['D:\myStudy\picpairfMRI\s',sprintf('%03d',crun),'\prepostEncoding'];
    inputs{1, crun} = {[FUNCDIR,'\preBaselineMotionOut']}; % fMRI model specification: Directory - cfg_files
    if ~exist([FUNCDIR,'\preBaselineMotionOut'],'dir')
    mkdir(inputs{1, crun});
    end
    inputs{2, crun} = GetImageList4D([FUNCDIR,'\preBaseline'], WildcardFilename('*.img'));  % fMRI model specification: Scans - cfg_files
    if size(inputs{2, crun},1) == 181
    inputs{2, crun}(end,:)=[];
    end
    inputs{3, crun} = {[FUNCDIR,'\preBaseline\rp_avol_0004-180.txt']}; % fMRI model specification: Multiple regressors - cfg_files
end
spm('defaults', 'FMRI');
spm_jobman('serial', jobs, '', inputs{:});
