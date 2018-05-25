function conn_batch_encoding_Results
% example batch process for ANALYSES step. Edit the fields below
% this example is a paired t-test on connectivity differences between two sources across all of the subjects during the rest condition)
nsubj = 20;
rootfolder='E:\myStudy\picpairfMRI\encodingConnectivityConn_usingResidualData';
batch.filename=...                   % conn_* project file to be created/modified
    fullfile(rootfolder,'conn_eoncodingUsingResidualData.mat');

batch.Results.analysis_number=1;                                % What set of first-level analyses is this second-level analyses based on? (Sequential number identifying each set of independent first-level analyses)
batch.Results.foldername=...                                    % foldername where second-level results will be stored (this folder will be located in the results/secondlevel/ folder within the project folder) 
    'V2_connectivitydifferences_att-vs.no-att.allsubjects';

batch.Results.between_subjects.effect_names={'all subjects'};   % second-level between-subject effect names: cell array of strings (one per effect)
batch.Results.between_subjects.effects= [nsubj,1)];             % second-level effects (subjects by effects matrix) 
    
batch.Results.between_subjects.contrast=1;                      % between-subjects contrast (vector of 1 by effects-defined-above values)

batch.Results.between_conditions.effect_names={'fam','nfam'};   % list of condition names: cell array of strings (one per condition), these should correspond to the conditions names defined in the experiment setup 
batch.Results.between_conditions.contrast=[1/2,1/2,-1/2,-1/2];               % between-condition contrast (vector of 1 by conditions-defined-above values)

batch.Results.between_sources.effect_names={'MPFC_1_1'};        % list of seed names: cell array of strings (one per source). these should correspond to the ROI file names -or label names for atlas ROIs- imported in the experiment setup. If in doubt display the "CONN_x.Analyses(ianalysis).sources" variable to see a list of available names for this experiment. note: the _1_1 part indicates the first derivative order/dimension extracted (you would only need to change this if multivariate extraction for a given ROI is performed)
batch.Results.between_sources.contrast=[1];                     % between-source contrast (vector of 1 by sources-defined-above values)

batch.Results.done=1;

conn_batch(batch);

