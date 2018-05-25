Voxdim = [2 2 2]; % desired voxel dimensions
BB = [-80 -114 -52; 75 73 82];

file1 = '/Volumes/Ryan3T1/myStudies/phdThesisData/Data/v1_griffis_labels/01/2_LH_V1.label.nii';
file2 = '/Volumes/Ryan3T1/myStudies/phdThesisData/Data/FreeSurfer_ROIs/01/Ali_ROIs/01_l_fusi_06.nii';
file3 = '/Volumes/Ryan3T1/myStudies/phdThesisData/Data/PreProcess/Subject_06/Kastner_label/Kastner_perc_VTPM_vol_roi12_rh.nii';

resize_img(file1, Voxdim, BB )
resize_img(file2, Voxdim, BB )

resize_img(file3, Voxdim, BB )
