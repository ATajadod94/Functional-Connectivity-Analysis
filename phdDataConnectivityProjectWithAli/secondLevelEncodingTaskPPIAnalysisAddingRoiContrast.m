function secondLevelEncodingTaskPPIAnalysisAddingRoiContrast(regionName,subID)
% List of open inputs
% Factorial design specification: Directory - cfg_files
% Factorial design specification: Scans - cfg_files
% Contrast Manager: Name - cfg_entry
% Contrast Manager: Name - cfg_entry

rootDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\';
subjDir=dir([rootDir,'s0*.*']);

% % load the gPPI setup file P matrix where the contrast names locate
% load(['C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\s001\encoding\analysis\',...
%     '_analysis_',regionName,'.mat']);

jobfile = {'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\matlabFunctions\secondLevelvoxelBasedProcessingEncodingTask_job.m'};
jobs = repmat(jobfile, 1, 1);
inputs = cell(4, 1);

for nFolder = 1
    %create new folder for each PPI regions and for each firstlevel
    %contrast within the region folder
    if ~exist([rootDir,'secondLevelPPIAnalysis\',regionName,'\',regionName],'dir')
        mkdir([rootDir,'secondLevelPPIAnalysis\',regionName,'\',regionName]);
    end
    inputs{1,1} = {[rootDir,'secondLevelPPIAnalysis\',regionName,'\',regionName,'\']}; % Factorial design specification: Directory - cfg_files
    
    for n = 1:length(subID)
        %list the specific contrast files for participants subID, if some
        %subject need be taken out, just list the included subj in subID
        inputs{2, 1}(n) = {[rootDir,subjDir(n).name,'\encoding\analysis\','PPI_', regionName,'\',...
            'con_0025.img']};
    end
    inputs{3, 1} = [regionName,'  1']; % Contrast Manager: Name - cfg_entry
    inputs{4, 1} = [regionName,' -1']; % Contrast Manager: Name - cfg_entry
    spm('defaults', 'FMRI');
    spm_jobman('serial', jobs, '', inputs{:});
end %nfolder





