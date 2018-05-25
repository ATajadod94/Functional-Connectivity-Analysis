function addingContrastToSubsequentMemoryAnalysisMore(subID)
%fam1+fam2 nfam1+nfam2 fam1-nfam1 fam2-nfam2
% List of open inputs
% Contrast Manager: Select SPM.mat - cfg_files
% Contrast Manager: Name - cfg_entry
% Contrast Manager: T contrast vector - cfg_entry
% Contrast Manager: Name - cfg_entry
% Contrast Manager: T contrast vector - cfg_entry
% Contrast Manager: Name - cfg_entry
% Contrast Manager: T contrast vector - cfg_entry
% Contrast Manager: Name - cfg_entry
% Contrast Manager: T contrast vector - cfg_entry
rootDir = 'D:\myStudy\picpairfMRI\';
nrun = length(subID); % enter the number of runs here


for crun = 1:nrun
    inputSPMDIR = {[rootDir,'s',sprintf('%03d',subID(crun)),...
        '\encoding\analysis-subsequentMemory\SPM.mat']}; % Contrast Manager: Select SPM.mat - cfg_files
    
matlabbatch{1}.spm.stats.con.spmmat = inputSPMDIR;
matlabbatch{1}.spm.stats.con.consess{1}.tcon.name = 'nonremFam';
matlabbatch{1}.spm.stats.con.consess{1}.tcon.convec = [0 0 1 0 -1 0 0 0 1 0 -1 0];
matlabbatch{1}.spm.stats.con.consess{1}.tcon.sessrep = 'none';

matlabbatch{1}.spm.stats.con.consess{2}.tcon.name = 'nonremNonFam';
matlabbatch{1}.spm.stats.con.consess{2}.tcon.convec = [0 0 0 0 0 0 0 0 0 0 0 0  0 0 1 0 -1 0 0 0 1 0 -1 0];
matlabbatch{1}.spm.stats.con.consess{2}.tcon.sessrep = 'none';

matlabbatch{1}.spm.stats.con.consess{3}.tcon.name = 'nonremFam1';
matlabbatch{1}.spm.stats.con.consess{3}.tcon.convec = [0 0 1 0 -1];
matlabbatch{1}.spm.stats.con.consess{3}.tcon.sessrep = 'none';

matlabbatch{1}.spm.stats.con.consess{4}.tcon.name = 'nonremNonFam1';
matlabbatch{1}.spm.stats.con.consess{4}.tcon.convec = [0 0 0 0 0 0 0 0 0 0 0 0  0 0 1 0 -1];
matlabbatch{1}.spm.stats.con.consess{4}.tcon.sessrep = 'none';

matlabbatch{1}.spm.stats.con.consess{5}.tcon.name = 'nonremFam2';
matlabbatch{1}.spm.stats.con.consess{5}.tcon.convec = [0 0 0 0 0 0 0 0 1 0 -1 0];
matlabbatch{1}.spm.stats.con.consess{5}.tcon.sessrep = 'none';

matlabbatch{1}.spm.stats.con.consess{6}.tcon.name = 'nonremNonFam2';
matlabbatch{1}.spm.stats.con.consess{6}.tcon.convec = [0 0 0 0 0 0 0 0 0 0 0 0  0 0 0 0 0 0 0 0 1 0 -1 0];
matlabbatch{1}.spm.stats.con.consess{6}.tcon.sessrep = 'none';

matlabbatch{1}.spm.stats.con.consess{7}.tcon.name = 'remFam1';
matlabbatch{1}.spm.stats.con.consess{7}.tcon.convec = [1 0 0 0 -1];
matlabbatch{1}.spm.stats.con.consess{7}.tcon.sessrep = 'none';

matlabbatch{1}.spm.stats.con.consess{8}.tcon.name = 'remNonFam1';
matlabbatch{1}.spm.stats.con.consess{8}.tcon.convec = [0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 -1];
matlabbatch{1}.spm.stats.con.consess{8}.tcon.sessrep = 'none';

matlabbatch{1}.spm.stats.con.consess{9}.tcon.name = 'remFam2';
matlabbatch{1}.spm.stats.con.consess{9}.tcon.convec = [0 0 0 0 0 0 1 0 0 0 -1 0];
matlabbatch{1}.spm.stats.con.consess{9}.tcon.sessrep = 'none';

matlabbatch{1}.spm.stats.con.consess{10}.tcon.name = 'remNonFam2';
matlabbatch{1}.spm.stats.con.consess{10}.tcon.convec = [0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 -1 0];
matlabbatch{1}.spm.stats.con.consess{10}.tcon.sessrep = 'none';

matlabbatch{1}.spm.stats.con.consess{11}.tcon.name = 'nonremFamRep';
matlabbatch{1}.spm.stats.con.consess{11}.tcon.convec = [0 0 1 0 -1 0 0 0 -1 0 1 0];
matlabbatch{1}.spm.stats.con.consess{11}.tcon.sessrep = 'none';

matlabbatch{1}.spm.stats.con.consess{12}.tcon.name = 'nonremNonFamRep';
matlabbatch{1}.spm.stats.con.consess{12}.tcon.convec = [0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 -1 0 0 0 -1 0 1 0];
matlabbatch{1}.spm.stats.con.consess{12}.tcon.sessrep = 'none';

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