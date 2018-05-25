%% BATCH INFORMATION (edit this section)
clear;
%addpath C:\Users\zliu\Documents\MATLAB\myfMRItools\conn17f\conn
%rootfolder='H:\myStudies\phdThesisData\Data\Conn_Resting_output';
rootfolder='/Volumes/Ryan3T1/myStudies/phdThesisData/Data/Conn_Residual_output';

%rootfolder='H:\myStudies\phdThesisData\Data\Conn_Resting_output';

if ~exist(rootfolder,'dir')
    mkdir(rootfolder);
end

batch.filename= fullfile(rootfolder,'Conn_Bash.mat');

nsessions = 4;
nconditions = 4;
nsubj = 20;


batch.Setup.isnew=1;                 % 0: modifies existing project; 1: creates new proejct
batch.Setup.RT=2;                    % TR (in seconds)
batch.Setup.nsubjects=nsubj;          % number of subjects
batch.Setup.analyses=[1,2];

% functional data files
for i = 1: nsubj
batch.Setup.functionals{i} =  Getting_labels('function' , i, 'res')';
end
for i = 1: nsubj
batch.Setup.structurals{i} = Getting_labels('structure',i,'Structural');
batch.Setup.masks.Grey{i} = Getting_labels('structure', i,'Grey');
batch.Setup.masks.White{i} = Getting_labels('structure', i,'White');
batch.Setup.masks.CSF{i} =  Getting_labels('structure', i,'CSF'); 
end

% for i = 1:nsubj  %% MTL / GRIFFIS / KASTNER / GLASSER %%%%%%%% pdypqqiuyperiuge-qiruewpuio HEEEEEY HEEEEEYHEEEEEYHEEEEEYHEEEEEYHEEEEEYHEEEEEY
%     for l=1:12
%         temp = Getting_labels('label', i,'kastner');
%         batch.Setup.rois.files{l}{i} = temp(l);
%     end;
% batch.Setup.rois.files{13}{i} = Getting_labels('label', i,'glasser');
%     for l=14:27
%         temp = Getting_labels('label', i,'griffis');
%         batch.Setup.rois.files{l}{i} = temp(l-13);
%     end;
%     for l=28:71
%         temp = Getting_labels('label', i,'MTL');
%         batch.Setup.rois.files{l}{i} = temp(l-27);
%     end;
% end


for i = 1:nsubj  %% MTL / GRIFFIS / KASTNER / GLASSER %%%%%%%% pdypqqiuyperiuge-qiruewpuio HEEEEEY HEEEEEYHEEEEEYHEEEEEYHEEEEEYHEEEEEYHEEEEEY
%     for l=1:12
%         temp = Getting_labels('label', i,'kastner');
%         batch.Setup.rois.files{l}{i} = temp(l);
%     end;
% batch.Setup.rois.files{13}{i} = Getting_labels('label', i,'glasser');
  temp = Getting_labels('label', i,'griffis');
    for l=1:14
        batch.Setup.rois.files{l}{i} = temp(l);
    end;
    for l=15:58
        temp = Getting_labels('label', i,'MTL');
        batch.Setup.rois.files{l}{i} = temp(l-14);
    end;
end

batch.Setup.conditions.names={'res_1','res_2','res_3','res_4'};
for ncond=1:nconditions,for nsub=1:nsubj,for nses=1:nsessions,  batch.Setup.conditions.onsets{ncond}{nsub}{nses}=[];batch.Setup.conditions.durations{ncond}{nsub}{nses}=[]; end;end;end
for ncond=1:nconditions,for nsub=1:nsubj,for nses=ncond,        batch.Setup.conditions.onsets{ncond}{nsub}{nses}=0; batch.Setup.conditions.durations{ncond}{nsub}{nses}=inf;end;end;end


%batch.Setup.covariates.names={'motion'};      
%for i = 1:nsubj
%batch.Setup.covariates.files{1}{i}=Getting_labels('motion',i, 'tasks')';    
%end

batch.Setup.done=1;  
batch.Setup.overwrite='Yes';



%% PREPROCESSING INFORMATION (edit this section to change the default values)
%% DENOISE / PREPROCESS
batch.Denoising.filter=[.008, .1];           % FOR TASKS DO [.008, INF], FOR RUN RES do  [.008, .1];
batch.Denoising.confounds.names=...          % Effects to be included as confounds (cell array of effect names, effect names can be first-level covariate names, condition names, or noise ROI names)
    {'White Matter','CSF'};
batch.Denoising.confounds.dimensions=...     % dimensionality of each effect listed above (cell array of values, leave empty a particular value to set to the default value -maximum dimensions of the corresponding effect-)
    {5, 5};
batch.Denoising.confounds.deriv=...          % derivatives order of each effect listed above (cell array of values, leave empty a particular value to set to the default value)
    {0, 0};

batch.Denoising.done=1;
batch.Denoising.overwrite='Yes';             % overwrite existing results if they exist (set to 'No' if you want to skip preprocessing steps for subjects/ROIs already analyzed)    


batch.Analysis.analysis_number=1;       % Sequential number identifying each set of independent first-level analyses
batch.Analysis.measure=1;               % connectivity measure used {1 = 'correlation (bivariate)', 2 = 'correlation (semipartial)', 3 = 'regression (bivariate)', 4 = 'regression (multivariate)';
batch.Analysis.weight=2;                % within-condition weight used {1 = 'none', 2 = 'hrf', 3 = 'hanning';


batch.Analysis.done=1;
batch.Analysis.overwrite='Yes';         % overwrite existing results if they exist (set to 'No' if you want to skip Analysis steps for subjects/ROIs already analyzed)    
conn_batch(batch);



