function conn_batch_encoding_Preprocessing_forSamilarityAnalysis
% example batch process for PREPROCESSING. Edit the fields below
% This example performs the following preprocessing steps:
% removal of confounding effects based on White matter / CSF CompCor, 3
% dimensions each, with additional removal of one task condition (named "rest"),
% and estimated subject motion parameters (named "motion"), and band-pass
% filtering

%% BATCH INFORMATION (edit this section)


rootfolder='C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\similarityAnalysis\encodingPreprocessed';

batch.filename=...                   % conn_* project file to be created/modified
    fullfile(rootfolder,'conn_eoncoding_only4Runs.mat');


%% PREPROCESSING INFORMATION (edit this section to change the default values)
batch.Preprocessing.filter=[.008, .1];           % frequency filter (band-pass values, in Hz)
batch.Preprocessing.detrending=1;
batch.Preprocessing.despiking=1;
batch.Preprocessing.confounds.names=...          % Effects to be included as confounds (cell array of effect names, effect names can be first-level covariate names, condition names, or noise ROI names)
    {'White Matter','CSF'};
batch.Preprocessing.confounds.dimensions=...     % dimensionality of each effect listed above (cell array of values, leave empty a particular value to set to the default value -maximum dimensions of the corresponding effect-)
    {5, 5};
batch.Preprocessing.confounds.deriv=...          % derivatives order of each effect listed above (cell array of values, leave empty a particular value to set to the default value)
    {0, 0};

batch.Preprocessing.done=1;
batch.Preprocessing.overwrite='yes';             % overwrite existing results if they exist (set to 'No' if you want to skip preprocessing steps for subjects/ROIs already analyzed)    

conn_batch(batch);

