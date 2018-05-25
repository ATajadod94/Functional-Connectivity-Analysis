function ppi_wrapper_forPPIPlot(regionnumber,firstsubject,lastsubject)

projDir='C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\';
%User input required (directories and subjects)
addpath('C:\Users\Zhongxu\Documents\MATLAB\myMatLabTools\majorNeuroImagingTools\gPPIforSPM')
% addpath('spm8directory')

%User input required (region names)
% region={'L-tempole','L-ParaHipp'};

region={'L-tempole4mm05','L-parahipp4mm05',...
    'R-TPL12mm05','L-parahipp12mm05','R-vmp12mm05'};

for i=firstsubject:lastsubject;
    
    Subjects{i}=['s',sprintf('%03d',i)];
    %User input required (region files)
    regionfile={[projDir,'secondLevelPPIAnalysis\R_HPC\fam-nonfam\','L-tempole4mm05.img'],...
        [projDir,'secondLevelPPIAnalysis\R_HPC\fam-nonfam\','L-parahipp4mm05.img'],...
        [projDir,'secondLevelPPIAnalysis\R_HPC\fam-nonfam\','R-TPL12mm05.img'],...
        [projDir,'secondLevelPPIAnalysis\R_HPC\fam-nonfam\','L-parahipp12mm05.img'],...
        [projDir,'secondLevelPPIAnalysis\R_HPC\fam-nonfam\','R-vmp12mm05.img']};
    
    
    
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
    
    P.Estimate=0;
    P.Weights=[];
    P.CompContrast =0;
    
      
    
    %User input required (change analysis to be more specific)
    save([subjPPIDir, '_analysis_' region{regionnumber},'.mat'],'P');
    try
        PPPI([subjPPIDir, '_analysis_' region{regionnumber},'.mat']);
    catch
        disp(['Failed: ' Subjects{i}])
    end
end
end
