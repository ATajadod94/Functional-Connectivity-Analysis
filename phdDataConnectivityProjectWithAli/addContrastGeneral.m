matlabbatch{1}.spm.stats.con.spmmat = '<UNDEFINED>';
matlabbatch{1}.spm.stats.con.consess{1}.tcon.name = '<UNDEFINED>';
matlabbatch{1}.spm.stats.con.consess{1}.tcon.convec = '<UNDEFINED>';
matlabbatch{1}.spm.stats.con.consess{1}.tcon.sessrep = 'none';
matlabbatch{1}.spm.stats.con.delete = 0;

spm('defaults', 'FMRI');
spm_jobman('run',matlabbatch);
