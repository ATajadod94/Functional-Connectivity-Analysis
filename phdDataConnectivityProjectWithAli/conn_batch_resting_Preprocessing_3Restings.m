function conn_batch_resting_Preprocessing_3Restings
% example batch process for PREPROCESSING. Edit the fields below
% This example performs the following preprocessing steps:
% removal of confounding effects based on White matter / CSF CompCor, 3
% dimensions each, with additional removal of one task condition (named "rest"),
% and estimated subject motion parameters (named "motion"), and band-pass
% filtering

%% BATCH INFORMATION (edit this section)

nsubj = 20;
rootfolder='E:\myStudy\picpairfMRI\restingConnectivityConn_individualROIs';
if ~exist(rootfolder,'dir')
    mkdir(rootfolder);
end
batch.filename=...                   % conn_* project file to be created/modified
    fullfile(rootfolder,'conn_restingConnectivity_3Restings.mat');


%% PREPROCESSING INFORMATION (edit this section to change the default values)
batch.Preprocessing.filter=[.008, .1];           % frequency filter (band-pass values, in Hz)
batch.Preprocessing.confounds.names=...          % Effects to be included as confounds (cell array of effect names, effect names can be first-level covariate names, condition names, or noise ROI names)
    {'White Matter','CSF','motion'};
batch.Preprocessing.confounds.dimensions=...     % dimensionality of each effect listed above (cell array of values, leave empty a particular value to set to the default value -maximum dimensions of the corresponding effect-)
    {5, 5, 6};
batch.Preprocessing.confounds.deriv=...          % derivatives order of each effect listed above (cell array of values, leave empty a particular value to set to the default value)
    {0, 0, 1};

batch.Preprocessing.done=1;
batch.Preprocessing.overwrite='Yes';             % overwrite existing results if they exist (set to 'No' if you want to skip preprocessing steps for subjects/ROIs already analyzed)    
batch.Preprocessing.detrending=0;
batch.Preprocessing.despiking=1; 
conn_batch(batch);

