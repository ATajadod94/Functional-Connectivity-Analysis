%-----------------------------------------------------------------------
% Job configuration created by cfg_util (rev $Rev: 4252 $)
%-----------------------------------------------------------------------
matlabbatch{1}.spm.util.imcalc.input = {
                                        'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelPmodAnalysis\pca-continuous\fam12\PKM-PCA05+.img,1'
                                        'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelAnalysis\famEffect_Fam-NonFam\fameEff05.img,1'
                                        'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelPmodAnalysis\performance-UsedinCereCor\Fam12\subseqMemEff05.img,1'
                                        };
matlabbatch{1}.spm.util.imcalc.output = 'FamePKMSubseqMem05.img';
matlabbatch{1}.spm.util.imcalc.outdir = {''};
matlabbatch{1}.spm.util.imcalc.expression = 'i1+i2+i3';
matlabbatch{1}.spm.util.imcalc.options.dmtx = 0;
matlabbatch{1}.spm.util.imcalc.options.mask = 0;
matlabbatch{1}.spm.util.imcalc.options.interp = 1;
matlabbatch{1}.spm.util.imcalc.options.dtype = 4;
spm('defaults', 'FMRI');
spm_jobman('run',matlabbatch);