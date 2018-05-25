function addContrastToPmodEmotion
%-----------------------------------------------------------------------
% Job configuration created by cfg_util (rev $Rev: 4252 $)
%-----------------------------------------------------------------------

% for i = 2:20
% spmDir = ['D:\myStudy\picpairfMRI\s',sprintf('%03d',i),'\encoding\analysis-emotionPmod-1\']
% 
% matlabbatch{1}.spm.stats.con.spmmat = {[spmDir,'SPM.mat']};
% matlabbatch{1}.spm.stats.con.consess{1}.tcon.name = 'fam1-scrmb';
% matlabbatch{1}.spm.stats.con.consess{1}.tcon.convec = [1 0 -1 0 0 0 0 0 0 0];
% matlabbatch{1}.spm.stats.con.consess{1}.tcon.sessrep = 'none';
% matlabbatch{1}.spm.stats.con.consess{2}.tcon.name = 'fam2-scrmb';
% matlabbatch{1}.spm.stats.con.consess{2}.tcon.convec = [0 0 0 1 0 -1 0 0 0 0];
% matlabbatch{1}.spm.stats.con.consess{2}.tcon.sessrep = 'none';
% matlabbatch{1}.spm.stats.con.consess{3}.tcon.name = 'fam12-scrmb12';
% matlabbatch{1}.spm.stats.con.consess{3}.tcon.convec = [1 0 -1 1 0 -1 0 0 0 0];
% matlabbatch{1}.spm.stats.con.consess{3}.tcon.sessrep = 'none';
% matlabbatch{1}.spm.stats.con.consess{4}.tcon.name = 'fam1-nfam1';
% matlabbatch{1}.spm.stats.con.consess{4}.tcon.convec = [1 0 0 0 0 0 -1 0 0 0];
% matlabbatch{1}.spm.stats.con.consess{4}.tcon.sessrep = 'none';
% 
% matlabbatch{1}.spm.stats.con.consess{5}.tcon.name = 'fam2-nfam2';
% matlabbatch{1}.spm.stats.con.consess{5}.tcon.convec = [0 0 0 1 0 0 0 0 -1 0];
% matlabbatch{1}.spm.stats.con.consess{5}.tcon.sessrep = 'none';
% 
% matlabbatch{1}.spm.stats.con.consess{6}.tcon.name = 'fam12-nfam12';
% matlabbatch{1}.spm.stats.con.consess{6}.tcon.convec = [1 0 0 1 0 0 -1 0 -1 0];
% matlabbatch{1}.spm.stats.con.consess{6}.tcon.sessrep = 'none';
% matlabbatch{1}.spm.stats.con.delete = 0;
% 
% spm('defaults', 'FMRI');
% spm_jobman('run',matlabbatch);
% end

for i = 1:20
spmDir = ['D:\myStudy\picpairfMRI\s',sprintf('%03d',i),'\encoding\analysis-emotionPmod-1\']

matlabbatch{1}.spm.stats.con.spmmat = {[spmDir,'SPM.mat']};

matlabbatch{1}.spm.stats.con.consess{1}.tcon.name = 'fam1-nfam1_scrmble';
matlabbatch{1}.spm.stats.con.consess{1}.tcon.convec = [1 0 -1 0 0 0 -1 1 0 0];
matlabbatch{1}.spm.stats.con.consess{1}.tcon.sessrep = 'none';

matlabbatch{1}.spm.stats.con.consess{2}.tcon.name = 'fam2-nfam2_scrmble';
matlabbatch{1}.spm.stats.con.consess{2}.tcon.convec = [0 0 0 1 0 -1 0 0 -1 1];
matlabbatch{1}.spm.stats.con.consess{2}.tcon.sessrep = 'none';

matlabbatch{1}.spm.stats.con.consess{3}.tcon.name = 'fam12-nfam12_scrmble';
matlabbatch{1}.spm.stats.con.consess{3}.tcon.convec = [1 0 -1 1 0 -1 -1 1 -1 1];
matlabbatch{1}.spm.stats.con.consess{3}.tcon.sessrep = 'none';
matlabbatch{1}.spm.stats.con.delete = 0;

spm('defaults', 'FMRI');
spm_jobman('run',matlabbatch);
end