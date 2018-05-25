function addingContrastToEncodingEffectPicScramble(subID)

% Contrast Manager: T contrast vector - cfg_entry
rootDir = 'D:\myStudy\picpairfMRI\';
nrun = length(subID); % enter the number of runs here


for crun = 1:nrun
    inputSPMDIR = {[rootDir,'s',sprintf('%03d',subID(crun)),...
        '\encoding\analysis\SPM.mat']}; % Contrast Manager: Select SPM.mat - cfg_files
    
matlabbatch{1}.spm.stats.con.spmmat = inputSPMDIR;
matlabbatch{1}.spm.stats.con.consess{1}.tcon.name = 'picEffect1_Pic1-Scramble1';
matlabbatch{1}.spm.stats.con.consess{1}.tcon.convec = [1 0 -1 0 0 0 0 0 1 0 -1 0 0 0 0 0];
matlabbatch{1}.spm.stats.con.consess{1}.tcon.sessrep = 'none';

matlabbatch{1}.spm.stats.con.consess{2}.tcon.name = 'picEffect2_Pic2-Scramble2';
matlabbatch{1}.spm.stats.con.consess{2}.tcon.convec = [0 0 0 0 1 0 -1 0 0 0 0 0 1 0 -1 0];
matlabbatch{1}.spm.stats.con.consess{2}.tcon.sessrep = 'none';



matlabbatch{1}.spm.stats.con.delete = 0;

matlabbatch{2}.spm.stats.results.spmmat(1) = cfg_dep;
matlabbatch{2}.spm.stats.results.spmmat(1).tname = 'Select SPM.mat';
matlabbatch{2}.spm.stats.results.spmmat(1).tgt_spec{1}(1).name = 'filter';
matlabbatch{2}.spm.stats.results.spmmat(1).tgt_spec{1}(1).value = 'mat';
matlabbatch{2}.spm.stats.results.spmmat(1).tgt_spec{1}(2).name = 'strtype';
matlabbatch{2}.spm.stats.results.spmmat(1).tgt_spec{1}(2).value = 'e';
matlabbatch{2}.spm.stats.results.spmmat(1).sname = 'Contrast Manager: SPM.mat File';
matlabbatch{2}.spm.stats.results.spmmat(1).src_exbranch = substruct('.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1});
matlabbatch{2}.spm.stats.results.spmmat(1).src_output = substruct('.','spmmat');
matlabbatch{2}.spm.stats.results.conspec.titlestr = '';
matlabbatch{2}.spm.stats.results.conspec.contrasts = Inf;
matlabbatch{2}.spm.stats.results.conspec.threshdesc = 'FWE';
matlabbatch{2}.spm.stats.results.conspec.thresh = 0.05;
matlabbatch{2}.spm.stats.results.conspec.extent = 0;
matlabbatch{2}.spm.stats.results.conspec.mask = struct('contrasts', {}, 'thresh', {}, 'mtype', {});
matlabbatch{2}.spm.stats.results.units = 1;
matlabbatch{2}.spm.stats.results.print = true;
spm('defaults', 'FMRI');
spm_jobman('run', matlabbatch);

end