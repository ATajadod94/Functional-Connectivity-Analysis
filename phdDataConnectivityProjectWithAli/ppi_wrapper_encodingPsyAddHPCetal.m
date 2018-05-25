function ppi_wrapper_encodingPsyAddHPCetal(regionnumber,firstsubject,lastsubject)

projDir='C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\';
%User input required (directories and subjects)
addpath('C:\Users\Zhongxu\Documents\MATLAB\myMatLabTools\majorNeuroImagingTools\gPPIforSPM')
% addpath('spm8directory')

%User input required (region names)
region={'L_HPC','R_HPC','L_aHC','R_aHC','L_mHC','R_mHC','L_pHC','R_pHC',...
    'L_preCun','R_preCun','L_TMP','R_TMP','L_vmP','R_vmP'};

for i=firstsubject:lastsubject;
    
    Subjects{i}=['s',sprintf('%03d',i)];
    %User input required (region files)
    regionfile={[projDir,'secondLevelAnalysis\picEffect_Pic-Scramble\','L_HPC.img'],...
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
    
    
    
    subjPPIDir = [projDir,'s',sprintf('%03d',i),'\encoding\analysis\'];
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
    P.Tasks = { '0', 'fam1','fam1-scrmble','fam2','fam2-scrmble',...
        'nonfam1','nonfam1-scrmble','nonfam2','nonfam2-scrmble'};
    
    
    P.Weights=[];
    P.CompContrast =1;
    
    for nContrast = 1:24
        P.Contrasts(nContrast).MinEvents=5;
        P.Contrasts(nContrast).Weighted=0;
        P.Contrasts(nContrast).STAT = 'T';
    end
    
    %contrast 1
    P.Contrasts(1).name = 'pic-scrmble';
    P.Contrasts(1).left = {'fam1','fam2','nonfam1','nonfam2'};
    P.Contrasts(1).right = {'fam1-scrmble','fam2-scrmble','nonfam1-scrmble','nonfam2-scrmble'};
    
    %contrast 2
    P.Contrasts(2).name = 'fam-nonfam';
    P.Contrasts(2).left = {'fam1','fam2','nonfam1-scrmble','nonfam2-scrmble'};
    P.Contrasts(2).right = {'nonfam1','nonfam2','fam1-scrmble','fam2-scrmble'};
    
    %contrast 3
    P.Contrasts(3).name = 'repMainEff_1-2';
    P.Contrasts(3).left = {'fam1','fam2-scrmble','nonfam1','nonfam2-scrmble'};
    P.Contrasts(3).right = {'fam2','fam1-scrmble','nonfam2','nonfam1-scrmble'};
    
    %contrast 4
    P.Contrasts(4).name = 'scramble-pic';
    P.Contrasts(4).left = {'fam1-scrmble','fam2-scrmble','nonfam1-scrmble','nonfam2-scrmble'};
    P.Contrasts(4).right = {'fam1','fam2','nonfam1','nonfam2'};
        
    %contrast 5
    P.Contrasts(5).name = 'nonfam-fam';
    P.Contrasts(5).left = {'nonfam1','nonfam2','fam1-scrmble','fam2-scrmble'};
    P.Contrasts(5).right = {'fam1','fam2','nonfam1-scrmble','nonfam2-scrmble'};
    
    %contrast 6
    P.Contrasts(6).name = 'repMainEff_2-1';
    P.Contrasts(6).left = {'fam2','fam1-scrmble','nonfam2','nonfam1-scrmble'};
    P.Contrasts(6).right = {'fam1','fam2-scrmble','nonfam1','nonfam2-scrmble'};
    
    %contrast 7
    P.Contrasts(7).name = 'repXfame_famRep12-nonFamRep12';
    P.Contrasts(7).left = {'fam1','nonfam2','fam2-scrmble','nonfam1-scrmble'};
    P.Contrasts(7).right = {'nonfam1','fam1-scrmble','nonfam2-scrmble','fam2'};
    
    %contrast 8
    P.Contrasts(8).name = 'repXfame_famRep21-nonFamRep21';
    P.Contrasts(8).left = {'nonfam1','fam1-scrmble','nonfam2-scrmble','fam2'};
    P.Contrasts(8).right = {'fam1','nonfam2','fam2-scrmble','nonfam1-scrmble'};
    
    %contrast 9
    P.Contrasts(9).name = 'fam1';
    P.Contrasts(9).left = {'fam1'};
    P.Contrasts(9).right = {'fam1-scrmble'};
    
    %contrast 10
    P.Contrasts(10).name = 'fam2';
    P.Contrasts(10).left = {'fam2'};
    P.Contrasts(10).right = {'fam2-scrmble'};
    
    %contrast 11
    P.Contrasts(11).name = 'nonfam1';
    P.Contrasts(11).left = {'nonfam1'};
    P.Contrasts(11).right = {'nonfam1-scrmble'};
    
    %contrast 12
    P.Contrasts(12).name = 'nonfam2';
    P.Contrasts(12).left = {'nonfam2',};
    P.Contrasts(12).right = {'nonfam2-scrmble'};
    
    %contrast 13
    P.Contrasts(13).name = 'fam1+fam2';
    P.Contrasts(13).left = {'fam1','fam2'};
    P.Contrasts(13).right = {'fam1-scrmble','fam2-scrmble'};
    
    %contrast 14
    P.Contrasts(14).name = 'fam1-fam2';
    P.Contrasts(14).left = {'fam1','fam2-scrmble'};
    P.Contrasts(14).right = {'fam2','fam1-scrmble'};
    
    %contrast 15
    P.Contrasts(15).name = 'nonfam1+nonfam2';
    P.Contrasts(15).left = {'nonfam1','nonfam2',};
    P.Contrasts(15).right = {'nonfam1-scrmble','nonfam2-scrmble'};
    
    %contrast 16
    P.Contrasts(16).name = 'nonfam1-nonfam2';
    P.Contrasts(16).left = {'nonfam1','nonfam2-scrmble'};
    P.Contrasts(16).right = {'nonfam2','nonfam1-scrmble'};
    
    %contrast 17
    P.Contrasts(17).name = 'fam1-nonfam1';
    P.Contrasts(17).left = {'fam1','nonfam1-scrmble'};
    P.Contrasts(17).right = {'nonfam1','fam1-scrmble'};
    
    %contrast 18
    P.Contrasts(18).name = 'fam2-nonfam2';
    P.Contrasts(18).left = {'fam2','nonfam2-scrmble'};
    P.Contrasts(18).right = {'nonfam2','fam2-scrmble'};
    
     %contrast 19
    P.Contrasts(19).name = 'fam-nonfam_noscrmble';
    P.Contrasts(19).left =  {'fam1','fam2'};
    P.Contrasts(19).right = {'nonfam1','nonfam2'};
    
    %contrast 20
    P.Contrasts(20).name = 'repMainEff_1-2_noscrmble';
    P.Contrasts(20).left = {'fam1','nonfam1'};
    P.Contrasts(20).right = {'fam2','nonfam2'};

    %contrast 21
    P.Contrasts(21).name = 'fam1-fam2_noscrmble';
    P.Contrasts(21).left = {'fam1'};
    P.Contrasts(21).right = {'fam2'};  
    
    %contrast 22
    P.Contrasts(22).name = 'nonfam1-nonfam2_noscrmble';
    P.Contrasts(22).left = {'nonfam1'};
    P.Contrasts(22).right = {'nonfam2'};
    
    %contrast 23
    P.Contrasts(23).name = 'fam1-nonfam1_noscrmble';
    P.Contrasts(23).left = {'fam1'};
    P.Contrasts(23).right = {'nonfam1'}; 
    
    %contrast 24
    P.Contrasts(24).name = 'fam2-nonfam2_noscrmble';
    P.Contrasts(24).left = {'fam2'};
    P.Contrasts(24).right = {'nonfam2'};    
    
    %User input required (change analysis to be more specific)
    save([subjPPIDir, '_analysis_' region{regionnumber},'.mat'],'P');
    try
        PPPI([subjPPIDir, '_analysis_' region{regionnumber},'.mat']);
    catch
        disp(['Failed: ' Subjects{i}])
    end
end
end
