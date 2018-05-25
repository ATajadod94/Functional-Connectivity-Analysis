%Segment a mask/nii into pieces along the anterior-posterior (Y) axis
%Zhong-Xu Liu
%June 30th 2017

clear



%Define input 
Mask = '/Users/Ali/Desktop/Baycrest/Data/01/mri/HippRois/01_l_hipp_fs_native.nii';
Mask = '/Users/Ali/Desktop/Baycrest/Data/01/mri/HippRois/01_r_hipp_fs_native.nii';
%Mask = '/2volatile/grady_lab/bbellana/Masks/HarvardOxford_IntraCalcarineCtx_Bilat_thr10_3mm.nii.gz';

%Load nii
[data header]=rest_ReadNiftiImage(Mask) ;
datatemp=data;
temp1=find(data~=0);

%Load in 3-dimensions (x,y,z)
[a b c] = ind2sub(size(data), temp1);

%determine range
[aa bb cc]=unique(b);

%anterior posterior range
aa(1)
aa(end)
range = aa(end) - aa(1) + 1

%define a variable named stepVox/indx(i), which contains the position along the Y axis of each segment
nseg=2
stepVox = -[min(aa)-max(aa)]/nseg;
for i = 1:nseg
    if mod(stepVox,2)==0
    indx(i) = floor(stepVox);
    else
     indx(i) = ceil(stepVox); 
	end
end


%cut this segment out of the entire nii image
for i = 1:nseg
cut_y(i)=aa(1)+sum(indx(1:i));
	if i <2
  		vol_delete =   cut_y(i):aa(end);
	elseif i == nseg
    	vol_delete = cat(1,aa(1):cut_y(i-1));
	else
		vol_delete = cat(1,[aa(1):cut_y(i-1)-1 cut_y(i):aa(end)]) ;
    end          
%save output nii
[data header]=rest_ReadNiftiImage(Mask) ;
datatemp=data;
datatemp(:,vol_delete,:)=0; 
rest_WriteNiftiImage(datatemp,header,['HarvardOxford_Intracalcarine_Bilat_3mm_',num2str(i),'.nii']);
%NEED VISUAL INSPECTION. range MUST be divisible by the nseg, otherwise this script can get a bit wonky (e.g., miss volumes, rather than properly cutting up the entire mask)!

end
