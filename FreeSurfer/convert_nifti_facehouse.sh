#!/bin.tcsh

set subj = (Subject_01 Subject_02 Subject_03 Subject_04 Subject_05 Subject_06 Subject_07 Subject_08 Subject_09 Subject_10 Subject_11 Subject_12 Subject_13 Subject_14 Subject_15  Subject_16 Subject_17 Subject_18 Subject_19 Subject_20 )

set dir = /scratch/ryan_lab/zliu/faceHouse/Anatomy_Nifti

foreach x (`seq 1 20`)
	echo $x
	echo $subj[$x]
	cd $dir/${subj[$x]}	
	mri_convert 001.nii 001.mgz
end

cd $dir
