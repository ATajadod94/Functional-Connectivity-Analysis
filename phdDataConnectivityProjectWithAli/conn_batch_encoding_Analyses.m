function conn_batch_encoding_Analyses
% example batch process for ANALYSES step. Edit the fields below
% This example performs first-level bivariate correlation connectivity analyses using four seeds.

rootfolder='E:\myStudy\picpairfMRI\encodingConnectivityConn_usingResidualData';
batch.filename=...                   % conn_* project file to be created/modified
    fullfile(rootfolder,'conn_eoncodingUsingResidualData.mat');

batch.Analysis.analysis_number=1;       % Sequential number identifying each set of independent first-level analyses
batch.Analysis.measure=1;               % connectivity measure used {1 = 'correlation (bivariate)', 2 = 'correlation (semipartial)', 3 = 'regression (bivariate)', 4 = 'regression (multivariate)';
batch.Analysis.weight=2;                % within-condition weight used {1 = 'none', 2 = 'hrf', 3 = 'hanning';
% batch.Analysis.sources.names=...              % Sources names (seeds) for connectivity analyses - these correspond to a subset of ROI file names in the ROI folder (if this variable does not exist the toolbox will perform the analyses for all of the ROI files imported in the Setup step which are not defined as confounds in the Preprocessing step 
%     {'V2','V5'};
% batch.Analysis.sources.dimensions={1,1};
% batch.Analysis.sources.deriv={0,0};

batch.Analysis.done=1;
batch.Analysis.overwrite='Yes';         % overwrite existing results if they exist (set to 'No' if you want to skip Analysis steps for subjects/ROIs already analyzed)    

conn_batch(batch);
