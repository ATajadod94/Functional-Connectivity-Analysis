#!/bin.tcsh

set subj = ( 01 02 03 04 05 06 07 08 09 10 11 12 13 14 15 16 17 18 19 20 )



cd /scratch/ryan_lab/zliu/faceHouse

foreach x (`seq 1 20`)
	echo $x
	echo $subj[$x]
	/home/bradley/bin/qexec.R recon-all -all -sd . -subjid ${subj[$x]} 
end

