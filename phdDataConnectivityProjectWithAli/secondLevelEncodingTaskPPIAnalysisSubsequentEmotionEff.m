function secondLevelEncodingTaskPPIAnalysisSubsequentEmotionEff(regionName,subID)
% List of open inputs
% Factorial design specification: Directory - cfg_files
% Factorial design specification: Scans - cfg_files
% Contrast Manager: Name - cfg_entry
% Contrast Manager: Name - cfg_entry

rootDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\';


% load the gPPI setup file P matrix where the contrast names locate
% load(['C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\s001\encoding\analysis-subsequentEmotionEffects\',...
%     '_analysis_',regionName,'.mat']);

jobfile = {'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\matlabFunctions\secondLevelvoxelBasedProcessingEncodingTask_job.m'};
jobs = repmat(jobfile, 1, 1);
inputs = cell(4, 1);

P.Contrasts(1).name = 'rem-nonrem-fm';
    P.Contrasts(1).left = {'Fam1_rem','Fam2_rem'};
    P.Contrasts(1).right = {'Fam1_notRem','Fam2_notRem'};
    
%     %contrast 3
%     P.Contrasts(3).name = 'rem-nonrem-nfm';
%     P.Contrasts(3).left = {'NFam1_rem', 'NFam2'};
%     P.Contrasts(3).right = {'NFam1_nonRem','NFam2_nonRem'};
%     
      %contrast 4
    P.Contrasts(2).name = 'rem-nonrem-fm1';
    P.Contrasts(2).left = {'Fam1_rem'};
    P.Contrasts(2).right = {'Fam1_notRem'};
    
     
      %contrast 5
    P.Contrasts(3).name = 'rem-nonrem-fm2';
       P.Contrasts(3).left = {'Fam2_rem'};
    P.Contrasts(3).right = {'Fam2_notRem'}; 
    
%        %contrast 6
%     P.Contrasts(6).name = 'rem-nonrem-nfm1';
%     P.Contrasts(6).left = {'NFam1_rem'};
%     P.Contrasts(6).right = {'NFam1_nonRem'};
%     
%        %contrast 7
%     P.Contrasts(7).name = 'rem-nonrem-nfm2';
%     P.Contrasts(7).left = {'NFam2'};
%     P.Contrasts(7).right = {'NFam2_nonRem'};
%     
       %contrast 8

      P.Contrasts(4).name = 'rem-fm1-fm2';
    P.Contrasts(4).left = {'Fam1_rem'};
    P.Contrasts(4).right = {'Fam2_rem'}; 
    
        %contrast 9
    P.Contrasts(5).name = 'nonrem-fm1-fm2';
    P.Contrasts(5).left = {'Fam1_notRem'};
    P.Contrasts(5).right = {'Fam2_notRem'};

for nFolder = 1:size(P.Contrasts,2)
    %create new folder for each PPI regions and for each firstlevel
    %contrast within the region folder
    if ~exist([rootDir,'secondLevelPPIAnalysisSubsequentEmotionEff\',regionName,'\',P.Contrasts(nFolder).name],'dir')
        mkdir([rootDir,'secondLevelPPIAnalysisSubsequentEmotionEff\',regionName,'\',P.Contrasts(nFolder).name]);
    end
    inputs{1,1} = {[rootDir,'secondLevelPPIAnalysisSubsequentEmotionEff\',regionName,'\',P.Contrasts(nFolder).name,'\']}; % Factorial design specification: Directory - cfg_files
    nn=1;
    for n = subID
        %list the specific contrast files for participants subID, if some
        %subject need be taken out, just list the included subj in subID
        inputs{2, 1}(nn) = {[rootDir,'s',sprintf('%03d',n),'\encoding\analysis-subsequentEmotionEffects\','PPI_', regionName,'\',...
            'con_PPI_',P.Contrasts(nFolder).name,'_s',sprintf('%03d',n),'.img']};
        nn=nn+1;
    end
    inputs{3, 1} = [P.Contrasts(nFolder).name,'  1']; % Contrast Manager: Name - cfg_entry
    inputs{4, 1} = [P.Contrasts(nFolder).name,' -1']; % Contrast Manager: Name - cfg_entry
    spm('defaults', 'FMRI');
    spm_jobman('serial', jobs, '', inputs{:});
end %nfolder





