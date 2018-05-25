for i = 1:20
spmDir = ['D:\myStudy\picpairfMRI\s',sprintf('%03d',i),'\encoding\analysis-DiffMemType\']

matlabbatch{1}.spm.stats.con.spmmat = {[spmDir,'SPM.mat']};

matlabbatch{1}.spm.stats.con.consess{1}.tcon.name = 'Associ-nonMem-Fam1';
matlabbatch{1}.spm.stats.con.consess{1}.tcon.convec = [.5, .5, 0, -1, 0];
matlabbatch{1}.spm.stats.con.consess{1}.tcon.sessrep = 'none';

matlabbatch{1}.spm.stats.con.consess{2}.tcon.name = 'Associ-nonMem-Fam2';
matlabbatch{1}.spm.stats.con.consess{2}.tcon.convec = [zeros(1,5),.5, .5, 0, -1, 0];
matlabbatch{1}.spm.stats.con.consess{2}.tcon.sessrep = 'none';

matlabbatch{1}.spm.stats.con.consess{3}.tcon.name = 'Associ-nonMem-Fam12';
matlabbatch{1}.spm.stats.con.consess{3}.tcon.convec = [.5, .5, 0, -1, 0,.5, .5, 0, -1, 0];
matlabbatch{1}.spm.stats.con.consess{3}.tcon.sessrep = 'none';

matlabbatch{1}.spm.stats.con.consess{4}.tcon.name = 'Associ-nonMem-NFam1';
matlabbatch{1}.spm.stats.con.consess{4}.tcon.convec = [zeros(1,10),.5, .5, 0, -1, 0];
matlabbatch{1}.spm.stats.con.consess{4}.tcon.sessrep = 'none';

matlabbatch{1}.spm.stats.con.consess{5}.tcon.name = 'Associ-nonMem-NFam2';
matlabbatch{1}.spm.stats.con.consess{5}.tcon.convec = [zeros(1,15),.5, .5, 0, -1, 0];
matlabbatch{1}.spm.stats.con.consess{5}.tcon.sessrep = 'none';

matlabbatch{1}.spm.stats.con.consess{6}.tcon.name = 'Associ-nonMem-NFam12';
matlabbatch{1}.spm.stats.con.consess{6}.tcon.convec = [zeros(1,10),.5, .5, 0, -1, 0,.5, .5, 0, -1, 0];
matlabbatch{1}.spm.stats.con.consess{6}.tcon.sessrep = 'none';


matlabbatch{1}.spm.stats.con.delete = 0;

spm('defaults', 'FMRI');
spm_jobman('run',matlabbatch);
end
