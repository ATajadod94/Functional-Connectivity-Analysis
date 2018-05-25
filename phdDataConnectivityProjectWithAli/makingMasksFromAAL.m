% List of open inputs
% Image Calculator: Output Filename - cfg_entry
% Image Calculator: Expression - cfg_entry

%************ using AAL list names***************************************
%**************116 regions including cerebelum***************************
%************************************************************************
jobfile = {'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\matlabFunctions\makingMasksFromAAL_job.m'};
dataPath = 'C:\Users\Zhongxu\Documents\MATLAB\myMatLabTools\majorNeuroImagingTools\spm8\toolbox\AAL\';
maskData = load([dataPath, 'ROI_MNI_V4_list.mat']);
nrun = size(ROI,2); % enter the number of runs here
jobs = repmat(jobfile, 1, nrun);
inputs = cell(2, nrun);
for crun = 1:nrun
    inputs{1, crun} = [ROI(crun).Nom_L,'.img']; % Image Calculator: Output Filename - cfg_entry
    inputs{2, crun} = ['i1==',num2str(ROI(crun).ID)]; % Image Calculator: Expression - cfg_entry
end
spm('defaults', 'FMRI');
spm_jobman('serial', jobs, '', inputs{:});

%************ using  salvador 2005 list ********************************
%**************names only 90 cerebral regions****************************
%******************** no cerebellum  ***********************************
jobfile = {'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\matlabFunctions\makingMasksFromAAL_job.m'};
dataPath = 'C:\Users\Zhongxu\Documents\MATLAB\myMatLabTools\majorNeuroImagingTools\spm8\toolbox\AAL\';
maskData = load([dataPath, 'ROI_abbr_Salvador2005.mat']);
nrun = 90% size(ROI,2); % enter the number of runs here
jobs = repmat(jobfile, 1, nrun);
inputs = cell(2, nrun);
for crun = 1:nrun
    inputs{1, crun} = [ROI_abbr_Salvador2005(crun).abbr,'.img']; % Image Calculator: Output Filename - cfg_entry
    inputs{2, crun} = ['i1==',num2str(ROI_abbr_Salvador2005(crun).ID)]; % Image Calculator: Expression - cfg_entry
end
spm('defaults', 'FMRI');
spm_jobman('serial', jobs, '', inputs{:});

