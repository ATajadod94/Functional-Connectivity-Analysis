function vbmQualityCheckHomogeneity
spm('defaults','fmri');
clear matlabbatch;
for i = 1 : 20
    input{i,1} = ['C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\s',...
        sprintf('%03d',i),'\VBM\m0wrp1vol_0001.nii'];
end
matlabbatch{1}.spm.tools.vbm8.tools.check_cov.data = input;
matlabbatch{1}.spm.tools.vbm8.tools.check_cov.scale = 1;
matlabbatch{1}.spm.tools.vbm8.tools.check_cov.slice = 2;
matlabbatch{1}.spm.tools.vbm8.tools.check_cov.gap = 5;
matlabbatch{1}.spm.tools.vbm8.tools.check_cov.nuisance = struct('c', {});

spm_jobman('run', matlabbatch);