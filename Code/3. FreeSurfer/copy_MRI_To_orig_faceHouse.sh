#!/bin.tcsh

set subj = ( Subject_01 Subject_02 Subject_03 Subject_04 Subject_05 Subject_06 Subject_07 Subject_08 Subject_09 Subject_10 Subject_11 Subject_12 Subject_13 Subject_14 Subject_15 Subject_16 Subject_17 Subject_18 Subject_19 Subject_20 )
set subjend = ( 01 02 03 04 05 06 07 08 09 10 11 12 13 14 15 16 17 18 19 20)


set orig_dir = /scratch/ryan_lab/zliu/faceHouse/Anatomy_Nifti
set end_dir = /scratch/ryan_lab/zliu/faceHouse

foreach x (`seq 1 20`)
	echo $x
	echo $subj[$x]
	scp -r $orig_dir/${subj[$x]}/001.mgz $end_dir/${subjend[$x]}/mri/orig
end
