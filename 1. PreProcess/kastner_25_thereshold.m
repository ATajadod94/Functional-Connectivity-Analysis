for subjects = 1
    subfolder = strcat('Subject_',sprintf('%02d',subjects));
    folder = strcat('/Volumes/Ryan3T1/myStudies/phdThesisData/Data/PreProcess/' ,subfolder , '/Kastner_label/Kastner_perc_VTPM_vol_roi25_rh.nii');
    outfolder = strcat('/Volumes/Ryan3T1/myStudies/phdThesisData/Data/PreProcess/' ,subfolder , '/Kastner_label');
    [data,header] = rest_ReadNiftiImage(folder);
    cd (outfolder)
sze = size(data);
data_50 = zeros(sze);
data_60 = zeros(sze);
data_70 =zeros(sze);
data_80 = zeros(sze);
data_90 = zeros(sze);

for i=1:sze(1)
    for j=1:sze(2)
        for k = 1:sze(3)
            if data(i,j,k) >= 34.5
                data_50(i,j,k) = 1;
            end
            
            if data(i,j,k) >= 41.4000
                data_60(i,j,k) = 1;
            end
            if data(i,j,k) >= 48.3000
                data_70(i,j,k) = 1;
            end
            if data(i,j,k) >= 55.2
                data_80(i,j,k) = 1;
            end
            if data(i,j,k) >= 62.1
                data_90(i,j,k) = 1;
            end
        end
    end
end
rest_WriteNiftiImage(data_50,header,'r_FEF_50'); 
rest_WriteNiftiImage(data_60,header,'r_FEF_60'); 
rest_WriteNiftiImage(data_70,header,'r_FEF_70'); 
rest_WriteNiftiImage(data_80,header,'r_FEF_80'); 
rest_WriteNiftiImage(data_90,header,'r_FEF_90'); 

    subfolder = strcat('Subject_',sprintf('%02d',subjects));
    folder = strcat('/Volumes/Ryan3T1/myStudies/phdThesisData/Data/PreProcess/' ,subfolder , '/Kastner_label/Kastner_perc_VTPM_vol_roi25_lh.nii');
    outfolder = strcat('/Volumes/Ryan3T1/myStudies/phdThesisData/Data/PreProcess/' ,subfolder , '/Kastner_label');
    [data,header] = rest_ReadNiftiImage(folder);
    cd (outfolder)
sze = size(data);
data_50 = zeros(sze);
data_60 = zeros(sze);
data_70 =zeros(sze);
data_80 = zeros(sze);
data_90 = zeros(sze);

for i=1:sze(1)
    for j=1:sze(2)
        for k = 1:sze(3)
            if data(i,j,k) >= 34.5
                data_50(i,j,k) = 1;
            end
            
            if data(i,j,k) >= 41.4000
                data_60(i,j,k) = 1;
            end
            if data(i,j,k) >= 48.3000
                data_70(i,j,k) = 1;
            end
            if data(i,j,k) >= 55.2
                data_80(i,j,k) = 1;
            end
            if data(i,j,k) >= 62.1
                data_90(i,j,k) = 1;
            end
        end
    end
end
rest_WriteNiftiImage(data_50,header,'l_FEF_50'); 
rest_WriteNiftiImage(data_60,header,'l_FEF_60'); 
rest_WriteNiftiImage(data_70,header,'l_FEF_70'); 
rest_WriteNiftiImage(data_80,header,'l_FEF_80'); 
rest_WriteNiftiImage(data_90,header,'l_FEF_90'); 

end