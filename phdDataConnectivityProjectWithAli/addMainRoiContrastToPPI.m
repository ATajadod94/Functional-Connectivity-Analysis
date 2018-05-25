function addMainRoiContrastToPPI(regionName,subID)
for i = subID    
input={['C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\',...
    's', sprintf('%03d',i),'\encoding\analysis\PPI_',regionName,'\SPM.mat']};
matlabbatch{1}.spm.stats.con.spmmat = input; 
matlabbatch{1}.spm.stats.con.consess{1}.tcon.name = regionName;
matlabbatch{1}.spm.stats.con.consess{1}.tcon.convec = [0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1];
matlabbatch{1}.spm.stats.con.consess{1}.tcon.sessrep = 'none';
matlabbatch{1}.spm.stats.con.delete = 0;
spm('defaults', 'FMRI');
spm_jobman('serial', matlabbatch);
end
