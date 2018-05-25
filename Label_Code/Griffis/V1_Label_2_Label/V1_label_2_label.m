%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% V1_label_2_label.m
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Code to distribute V1 labels from fsaverage brain to individual participants
%  Written by Wesley Burge Febuary 16, 2016 
%  Used in and available form:
%  Burge et al. (2016) Cortical thickness in human V1 associated with central vision loss
%  Also used in:
%  Griffis JC et al. (2015) Retinotopic patterns of backgroundconnectivity between V1 andfronto-parietal cortex are modulatedby task demands 

%% Purpose
%  This code uses built in freesurfer functions to distribute labels from
%  fsaverage space to individual subject space. The code then is able to use
%  another freesurfer function to create text files with stats on those
%  labels. 

%% Set up steps
%  Be sure to copy and paste the actual freesurfer fsaverage folder into
%  your subject directory (the one it creates in the subject directoy is actually a link to the fs
%  install location). Take the label files and move them into the
%  fsaverage/labels folder. There are a few locations to make changes in the
%  code for this to run. I have indicated where to make these changes.


%% set the enviroment variable to your subjects directory

setenv('SUBJECTS_DIR', '/path/to/your/subjects'); % be sure to edit this to your path


%% cd to subject directory and generate a list of subject names

subs = dir('*SUBBaseName*'); % change this to a base name that will pull all participants

%% Label names
%  These should be located in your subject directory/fsaverage/label folder.
%  Be sure you copy and pasted the fsaverage folder to your subject
%  directory and it is not just the symbolic link

labelslh = {'1_LH_V1.label' '3_LH_V1.label' '5_LH_V1.label' '7_LH_V1.label'...
'2_LH_V1.label' '4_LH_V1.label' '6_LH_V1.label' '8_LH_V1.label' '9_LH_V1.label' }; % all left hemi labels

labelsrh = {'1_RH_V1.label' '3_RH_V1.label' '5_RH_V1.label' '7_RH_V1.label'...
'2_RH_V1.label' '4_RH_V1.label' '6_RH_V1.label' '8_RH_V1.label' '9_RH_V1.label' }; % all right hemi labels

%% Here are extra labels commented out if you wish to use them as well.
%  These labels span the peak of the gyrus (P) the wall of the sulcus (W)
%  and the depth of the sulcus (S)

% labelslh = {'1_W_LH_V1.label' '3_W_LH_V1.label' '5_W_LH_V1.label' '7_W_LH_V1.label'...
% '2_W_LH_V1.label' '4_W_LH_V1.label' '6_W_LH_V1.label' '8_W_LH_V1.label' '9_W_LH_V1.label' ...
% '1_S_LH_V1.label' '3_S_LH_V1.label' '5_S_LH_V1.label' '7_S_LH_V1.label'...
% '2_S_LH_V1.label' '4_S_LH_V1.label' '6_S_LH_V1.label' '8_S_LH_V1.label' '9_S_LH_V1.label'...
% '1_P_LH_V1.label' '3_P_LH_V1.label' '5_P_LH_V1.label' '7_P_LH_V1.label'...
% '2_P_LH_V1.label' '4_P_LH_V1.label' '6_P_LH_V1.label' '8_P_LH_V1.label' '9_P_LH_V1.label' };
% 
% labelsrh = {'1_W_RH_V1.label' '3_W_RH_V1.label' '5_W_RH_V1.label' '7_W_RH_V1.label'...
% '2_W_RH_V1.label' '4_W_RH_V1.label' '6_W_RH_V1.label' '8_W_RH_V1.label' '9_W_RH_V1.label' ...
% '1_S_RH_V1.label' '3_S_RH_V1.label' '5_S_RH_V1.label' '7_S_RH_V1.label'...
% '2_S_RH_V1.label' '4_S_RH_V1.label' '6_S_RH_V1.label' '8_S_RH_V1.label' '9_S_RH_V1.label'...
% '1_P_RH_V1.label' '3_P_RH_V1.label' '5_P_RH_V1.label' '7_P_RH_V1.label'...
% '2_P_RH_V1.label' '4_P_RH_V1.label' '6_P_RH_V1.label' '8_P_RH_V1.label' '9_P_RH_V1.label' };


%% Use label2label function to distribute labels from fsaverage to participants 
%  more info here:
%  https://surfer.nmr.mgh.harvard.edu/fswiki/mri_label2label

%  LH labels from fsaverage to participants

for labelnum=1:length(labelslh) % for all labels
    for subnum=1:length(Subs) % for all participants
        
        eval(['! mri_label2label --srcsubject fsaverage --srclabel fsaverage/label/' labelslh{labelnum}...
            ' --trgsubject ' Subs(subnum).name ' --trglabel ' Subs(subnum).name '/label/' labelslh{labelnum} ...
            ' --regmethod surface --hemi lh'])
      
    end
end

%  RH labels from fsaverage spread to participants

for labelnum=1:length(labelsrh) % for all labels
    for subnum=1:length(Subs) % for all participants
        
        eval(['! mri_label2label --srcsubject fsaverage --srclabel fsaverage/label/' labelsrh{labelnum}...
            ' --trgsubject ' Subs(subnum).name ' --trglabel ' Subs(subnum).name '/label/' labelsrh{labelnum} ...
            ' --regmethod surface --hemi rh'])
      
    end
end


%% Create output folder to store labels

statsoutfolder = 'StatsOutFolder'; % change this to your name of choice
mkdir(statsoutfolder);

%% Create stats files from the new labels
%  more info here:
%  https://surfer.nmr.mgh.harvard.edu/fswiki/mris_anatomical_stats

%  LH stats files created from each label

for labelnum=1:length(labelslh) % for all labels
    for subnum=1:length(Subs) % for all participants
        
        eval(['! mris_anatomical_stats -l ' labelslh{labelnum} ' -f ' statsoutfolder '/' Subs(subnum).name '.' labelslh{labelnum} '.out ' Subs(subnum).name ' lh'])
      
    end
end

%  RH stats files created from each label 

for labelnum=1:length(labelsrh) % for all labels
    for subnum=1:length(Subs)% for all participants
      
        eval(['! mris_anatomical_stats -l ' labelsrh{labelnum} ' -f ' statsoutfolder '/' Subs(subnum).name '.' labelsrh{labelnum} '.out ' Subs(subnum).name ' rh'])
      
    end
end

%% After this you just need to read and parse the stats files you created.
% For questions, please email me at: wesleyburge@gmail.com


