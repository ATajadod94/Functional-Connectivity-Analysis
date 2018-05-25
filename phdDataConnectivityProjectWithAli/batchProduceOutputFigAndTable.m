function outputfile = batchProduceOutputFigAndTable(xSPM,defaultCor,isPlotTable,outputExcleName)

% see spm email list https://www.jiscmail.ac.uk/cgi-bin/webadmin?A2=spm;ffca832.1003
%                    https://www.jiscmail.ac.uk/cgi-bin/webadmin?A2=spm;a17fad01.0911
%                    https://www.jiscmail.ac.uk/cgi-bin/wa.exe?A2=ind0911&L=SPM&P=R95216&I=-3&d=No+Match%3BMatch%3BMatches&m=35105
% define xSPM in the following way. if there is a xSPM in the workspace,
% be careful to check the parameters.

% xSPM.swd       = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelAnalysis\picEffect_Pic-Scramble';
% xSPM.Ic        = 2; % index of contrast
% xSPM.n         = 1; % conjunction number (next update)
% xSPM.u         = 0.005;
% xSPM.Im        =[]; % if no masking
% if need masking
% xSPM.Im        = {'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelAnalysis\picEffect_Pic-Scramble\L_HPC.img'};
% xSPM.Ex        = 0; % 0 inclusive 1, exclusive
% xSPM.thresDesc = 'none'; % 'FWE', or 'FDR'-if using FDR defaults.stats.topFDR need be changed from 1 to 0
% xSPM.title     = '';
% xSPM.k         = 10;
% xSPM.units     = {'mm' 'mm' 'mm'};
% defaultCor     = [24 -14 -18]; % for right hippocampus
% isPlotTable      =1, plot activation table, 0 plot figure
%outputExcleName the output excle file name which has the activation table
spm('defaults','fmri');

% these two commands can do  the same work to generate figures tables
 [hReg, xSPM, SPM] = spm_results_ui('setup', xSPM); 
%[SPM xSPM]    = spm_getSPM(xSPM);


% print tables:
if isPlotTable ==1
    outputfile = makingResultsTableFromAALSPMOutputTables(xSPM,outputExcleName);
else
    %plot results
    spm_check_registration(fullfile(spm('Dir'),'canonical','single_subj_T1.nii'));
    spm_orthviews('AddBlobs',1,xSPM.XYZ,xSPM.Z,xSPM.M);
    spm_orthviews('Reposition',defaultCor); % any coordinates you want {mm} e.g., hippo [24 -14 -18]
    spm_orthviews('Redraw');
    outputfile = [];
end


% this code seems fine for plot figure and table, but cannot add mask image
%job = struct('swd', 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelAnalysis\picEffect_Pic-Scramble', ...
%           'Ic',1, ...
%            'u', .005, ...
%           'thresDesc', 'none', ...
%           'title', 'pic-scrmble', ...
%          'k', 10);
% 
%  [hReg, xSPM, SPM] = spm_results_ui('setup', job);
%  close(get(gcf,'name')); %zhongxu added; otherwise, give error info
%  spm_sections(xSPM,hReg,fullfile(spm('Dir'),'canonical','single_subj_T1.nii'));
%  spm_orthviews('Reposition',[0  0 0]);
%  TabDat = spm_list('List',xSPM,hReg);
