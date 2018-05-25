function ppi_wrapper_encodingSubsquentEmotionEff(regionnumber,subjectID)

projDir='C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\';
%User input required (directories and subjects)
addpath('C:\Users\Zhongxu\Documents\MATLAB\myMatLabTools\majorNeuroImagingTools\gPPIforSPM')
% addpath('spm8directory')

%User input required (region names)
region={'L_PPAnative','R_PPAnative','L_FFAnative','R_FFAnative',...
    'L_PPA','R_PPA','L_FFA','R_FFA',...
    'L_HPC','R_HPC','L_aHC','R_aHC',...
    'L_mHC','R_mHC','L_pHC','R_pHC',...
    'L_preCun','R_preCun','L_TMP','R_TMP','L_vmP','R_vmP'};

for i=subjectID;
    
    Subjects{i}=['s',sprintf('%03d',i)];
    %User input required (region files)
    regionfile={[projDir,Subjects{i},'\localization\','L_PPA.img'],...
        [projDir,Subjects{i},'\localization\','R_PPA.img'],...
        [projDir,Subjects{i},'\localization\','L_FFA.img'],...
        [projDir,Subjects{i},'\localization\','R_FFA.img'],...
        [projDir,'secondLevelAnalysis\picEffect_Pic-Scramble\','L_PPA.img'],...
        [projDir,'secondLevelAnalysis\picEffect_Pic-Scramble\','R_PPA.img'],...
        [projDir,'secondLevelAnalysis\picEffect_Pic-Scramble\','L_FFA.img'],...
        [projDir,'secondLevelAnalysis\picEffect_Pic-Scramble\','R_FFA.img'],...
        [projDir,'secondLevelAnalysis\picEffect_Pic-Scramble\','L_HPC.img'],...
        [projDir,'secondLevelAnalysis\picEffect_Pic-Scramble\','R_HPC.img'],...
        [projDir,'secondLevelAnalysis\picEffect_Pic-Scramble\','L_aHC.img'],...
        [projDir,'secondLevelAnalysis\picEffect_Pic-Scramble\','R_aHC.img'],...
        [projDir,'secondLevelAnalysis\picEffect_Pic-Scramble\','L_mHC.img'],...
        [projDir,'secondLevelAnalysis\picEffect_Pic-Scramble\','R_mHC.img'],...
        [projDir,'secondLevelAnalysis\picEffect_Pic-Scramble\','L_pHC.img'],...
        [projDir,'secondLevelAnalysis\picEffect_Pic-Scramble\','R_pHC.img'],...
        [projDir,'secondLevelAnalysis\picEffect_Pic-Scramble\','L_preCun.img'],...
        [projDir,'secondLevelAnalysis\picEffect_Pic-Scramble\','R_preCun.img'],...
        [projDir,'secondLevelAnalysis\picEffect_Pic-Scramble\','L_TMP.img'],...
        [projDir,'secondLevelAnalysis\picEffect_Pic-Scramble\','R_TMP.img'],...
        [projDir,'secondLevelAnalysis\picEffect_Pic-Scramble\','L_vmP.img'],...
        [projDir,'secondLevelAnalysis\picEffect_Pic-Scramble\','R_vmP.img']};
    
    
    
    subjPPIDir = [projDir,'s',sprintf('%03d',i),'\encoding\analysis-subsequentEmotionEffects\'];
    %  subjPPIDir=[projDir,Subjects{i},'\encoding\analysisPPI\',...
    %                    region{regionnumber},'\'];
    % if ~exist(subjPPIDir,'dir')
    %     mkdir(subjPPIDir);
    % end
    
    % originalAnalysisDir=[projDir,'s',sprintf('%03d',i),'\encoding\analysis\'];
    % %copy spm.mat to subjPPIDir (from originalAnalysisDir)
    % copyfile([originalAnalysisDir,'SPM.mat'],  [subjPPIDir,'SPM.mat']);
    
    %User input required (master template)
    load('ppi_master_template.mat')
    
    P.VOI=regionfile{regionnumber};
    P.Region=region{regionnumber};
    
    cd(subjPPIDir)
    
    P.subject=Subjects{i};
    P.directory=subjPPIDir;
    P.method='cond'; % try traditional ppi first to check with spm then we can swithc to gPPI
    P.equalroi=0; %not equal roi across participants
    P.extract = 'eig';
    P.Tasks = { '0','Fam1_rem', 'Fam1_notRem','FamScramble_1',...
        'Fam2_rem' ,'Fam2_notRem', 'FamScramble_2',...
        'NFam1_rem', 'NFam1_nonRem','NFamScramble_1',...
        'NFam2' , 'NFam2_nonRem', 'NFamScramble2'};
    
    
    P.Weights=[];
    P.CompContrast =1;
    
    for nContrast = 1:5
        P.Contrasts(nContrast).MinEvents=5;
        P.Contrasts(nContrast).Weighted=0;
        P.Contrasts(nContrast).STAT = 'T';
    end
    
    %contrast 1
%     P.Contrasts(1).name = 'rem-nonrem-allfame';
%     P.Contrasts(1).left = {'Fam1_rem','Fam2_rem','NFam1_rem', 'NFam2'};
%     P.Contrasts(1).right = {'Fam1_notRem','Fam2_notRem','NFam1_nonRem','NFam2_nonRem'};
    
    %contrast 2
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
    
%         %contrast 10
%     P.Contrasts(10).name = 'rem-nfm1-nfam2';
%     P.Contrasts(10).left = {'NFam1_rem' };
%     P.Contrasts(10).right = {'NFam2'};
%         %contrast 11
%     P.Contrasts(11).name = 'nonrem-nfm1-nfm2';
%     P.Contrasts(11).left = {'NFam1_nonRem'};
%     P.Contrasts(11).right = {'NFam2_nonRem'};
%     
    
    
    %User input required (change analysis to be more specific)
    save([subjPPIDir, '_analysis_' region{regionnumber},'.mat'],'P');
    try
        PPPI([subjPPIDir, '_analysis_' region{regionnumber},'.mat']);
    catch
        disp(['Failed: ' Subjects{i}])
    end
end
end
