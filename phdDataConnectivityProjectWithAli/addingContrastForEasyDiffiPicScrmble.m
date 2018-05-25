function addingContrastForEasyDiffiPicScrmble(subID,dataName,isFamOnly,isBinarized)
if nargin <4
    isBinarized =[];
end
% List of open inputs
% fMRI model specification: Directory - cfg_files
% fMRI model specification: Scans - cfg_files
% fMRI model specification: Multiple conditions - cfg_files
% fMRI model specification: Multiple regressors - cfg_files
% Contrast Manager: Name - cfg_entry
% Contrast Manager: T contrast vector - cfg_entry
% Contrast Manager: Name - cfg_entry
% Contrast Manager: T contrast vector - cfg_entry
% Contrast Manager: Name - cfg_entry
% Contrast Manager: T contrast vector - cfg_entry
% Contrast Manager: Name - cfg_entry
% Contrast Manager: T contrast vector - cfg_entry
rootDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\';
codeDir= [rootDir,'matlabFunctions\'];
subDir = [rootDir, 's',sprintf('%03d',subID),'\'];
FUNCDIR = [rootDir,'s',sprintf('%03d',subID),'\encoding'];


matlabbatch{1}.spm.stats.con.spmmat = {[FUNCDIR,'\analysis-',dataName,'Pmod-',num2str(isFamOnly),num2str(isBinarized),'\SPM.mat']};
matlabbatch{1}.spm.stats.con.consess{1}.tcon.name = 'fam12_contrlScrmble';
matlabbatch{1}.spm.stats.con.consess{1}.tcon.convec = [0 1 0 -1 0 1 0 -1];
matlabbatch{1}.spm.stats.con.consess{1}.tcon.sessrep = 'none';

matlabbatch{1}.spm.stats.con.consess{2}.tcon.name = 'nfam12_contrlScrmble';
matlabbatch{1}.spm.stats.con.consess{2}.tcon.convec = [0 0 0 0 0 0 0 0 0 1 0 -1 0 1 0 -1];
matlabbatch{1}.spm.stats.con.consess{2}.tcon.sessrep = 'none';

matlabbatch{1}.spm.stats.con.consess{3}.tcon.name = 'famnfam12';
matlabbatch{1}.spm.stats.con.consess{3}.tcon.convec = [0 1 0 0 0 1 0 0 0 1 0 0 0 1 0 0];
matlabbatch{1}.spm.stats.con.consess{3}.tcon.sessrep = 'none';

matlabbatch{1}.spm.stats.con.consess{4}.tcon.name = 'famnfamscrmble_12';
matlabbatch{1}.spm.stats.con.consess{4}.tcon.convec = [0 0 0 1 0 0 0 1 0 0 0 1 0 0 0 1];
matlabbatch{1}.spm.stats.con.consess{4}.tcon.sessrep = 'none';

matlabbatch{1}.spm.stats.con.consess{5}.tcon.name = 'famnfam12_contrlscrmble';
matlabbatch{1}.spm.stats.con.consess{5}.tcon.convec = [0 1 0 -1 0 1 0 -1 0 1 0 -1 0 1 0 -1];
matlabbatch{1}.spm.stats.con.consess{5}.tcon.sessrep = 'none';
matlabbatch{1}.spm.stats.con.delete = 0;

spm('defaults', 'FMRI');
spm_jobman('run', matlabbatch);
