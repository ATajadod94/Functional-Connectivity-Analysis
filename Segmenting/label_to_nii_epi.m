% 1 Make nii files from labels
% 2 Transform the nii to the the s!ubjects brain area 
% 3 make into marsbar ROI
% 4 extrac beta values and place into data strcture
% 5 analyise the data strcture

% 1 Make nii files from labels
clear all 
clc
% path to subject data
sub_path= '/Users/Ali/Desktop/Baycrest/Data';
cd(sub_path);
subject = dir('*0*');
label_folder = 'label/FSecc';
for j= 1
    eval(['!tkregister2 --mov /Users/Ali/Desktop/Baycrest/Data/01/mri/rawavg.mgz --noedit --s 01 --regheader --reg /Users/Ali/Desktop/Baycrest/Data/01/mri/register.dat'])

    subject_name = subject(j).name;
    label_dir = (fullfile(sub_path,subject_name,label_folder));
    cd(label_dir);
    roi = dir();
    roi = roi(3:end);
    for k = 1: length(roi)
        roi_file = roi(k).name;  


        eval(['! mri_label2vol  --label ' roi_file  ...
                ' --temp /Users/Ali/Desktop/Baycrest/Data/01/mri/rawavg.mgz --reg /Users/Ali/Desktop/Baycrest/Data/01/mri/register.dat --fillthresh .3  --o ' roi_file '.nii' ]);
            
    end
    
    
end

%%
clear all 
spm('defaults', 'fmri')
global defaults
marsbar('on')
sub_path= '/Users/Ali/Desktop/Baycrest/Data';
cd(sub_path)
subject = dir('*0*');
Voxdim = [2 2 2]; % desired voxel dimensions
for j=  1:length(subject)
    
    label_dir = fullfile(sub_path, subject(j).name, 'label');
    cd(label_dir)
    % get the trasformation matrix for each subject
    roi = dir('*.nii')
    for k = 1: length(roi)
        imnames = roi(k).name; 
        resize_img(imnames, Voxdim,[nan nan nan; nan nan nan])
        % pick up each ROI 
        roi_file = strcat('r', roi(k).name);
        % turn into marsbar file
        mars_img2rois([roi_file ], pwd, [roi_file], 'i');
        
    end
    
    
end

%%
clc
clear all
sub_path= '/Users/Ali/Desktop/Baycrest/Data';
cd(sub_path)
subject = dir('*01*');
label_folder = 'label';
for i = 1:length(subject)
    cd(fullfile(sub_path,subject(i).name, label_folder));
    my_rois = dir('*H_V1.label');

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
