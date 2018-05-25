% 1 Make nii files from labels
% 2 Transform the nii to the the subjects brain area 
% 3 make into marsbar ROI
% 4 extrac beta values and place into data strcture
% 5 analyise the data strcture

% 1 Make nii files from labels
clear all 
clc
% path to subject data
sub_path= '/scratch/user/joegriff/subjects';
cd(sub_path);
subject = dir('fsaverage*');
label_folder = 'label';
for j= 1
    
    subject_name = subject(j).name;
    label_dir = (fullfile(sub_path,subject_name,label_folder));
    cd(label_dir);
    roi = dir('*h.V1.label');
    for k = 1: length(roi)
    roi_file = roi(k).name;  
    
    eval(['! mri_label2vol  --label ' '2_LH_V1.label'  ...
            ' --temp /home/joegriff/spm8/templates/EPI.nii --reg /scratch/user/joegriff/subjects/fsaverage/mri/transforms/reg.mni152.2mm.dat --bold --fillthresh .3  --o ' '2_LH_V1.label' '.nii' ]);
            
    end
    
    
end

%%
clear all 
spm('defaults', 'fmri')
global defaults
addpath(genpath('/home/joegriff/Toolbox')); % path to function
addpath(genpath('/rstore/share/visscherlab/home/abdurahman/Desktop/marsbar-0.42'))% marsbar
marsbar('on')
sub_path= '/scratch/user/joegriff/subjects';
cd(sub_path)
subject = dir('Power*');
Voxdim = [2 2 2]; % desired voxel dimensions
BB = [-80 -114 -52; 75 73 82];
for j=  1:length(subjects)
    
    label_dir = fullfile(sub_path, subject(j).name, 'label');
    cd(label_dir)
    % get the trasformation matrix for each subject
    roi = dir('*.nii')
    for k = 1: length(roi)
        imnames = roi(k).name; 
        resize_img(imnames, Voxdim, BB)
        % pick up each ROI 
        roi_file = strcat('r', roi(k).name);
        % turn into marsbar file
        mars_img2rois([roi_file ], pwd, [roi_file], 'i');
        
    end
    
    
end

%%
clc
clear all
sub_path= '/scratch/user/joegriff/subjects';
cd(sub_path)
subject = dir('Power*');
label_folder = 'label';
addpath('/home/joegriff/Toolbox/matlab_nifti');
for i = 1:length(subject)
    cd(fullfile(sub_path,subject(i).name, label_folder));
    my_rois = dir('r*LH_V1.label.nii');
    for j = 1:length(my_rois)
        v1_roi = load_nii(my_rois(j).name);
        v1_roi.img = v1_roi.img.*j;
        if j == 1
            combined_roi = v1_roi.img;
        else
            combined_roi = combined_roi + v1_roi.img;
        end
    end
    v1_roi.img = combined_roi;
    save_nii(v1_roi, 'v1_combined');
end
