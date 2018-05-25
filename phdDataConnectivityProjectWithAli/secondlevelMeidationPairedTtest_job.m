function secondlevelMeidationPairedTtest_job

% %***************** using prior knowledge pca as mediator, subsequent
% %memory as predictor ***********************************************
% 
outdir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelMediationPairedTtest_priorknowledgeAsMedi\';
if ~exist(outdir,'dir')
    mkdir(outdir)
end
includedSubj=1:20;
matlabbatch{1}.spm.stats.factorial_design.dir = {outdir};
rootDir1 = 'D:\myStudy\picpairfMRI\';

subjDir=dir([rootDir1,'s0*.*']);
for n = 1:20
     dataFName{1,1}=[rootDir1,subjDir(includedSubj(n)).name,...
            '\encoding\analysis-performancePmod-0\con_',sprintf('%04d',1),'.img'];    
    dataFName{2,1}= [rootDir1,subjDir(includedSubj(n)).name,...
            '\encoding\analysis-performancepcaPmod-11\con_',sprintf('%04d',1),'.img'];
        % Factorial design specification: Scans - cfg_files

                                                                  
matlabbatch{1}.spm.stats.factorial_design.des.pt.pair(n).scans = dataFName;
end

%***************** using prior knowledge pca as predictor, subsequent
%memory as mediator ***********************************************
%  includedSubj=1:20;
%  rootDir1 = 'D:\myStudy\picpairfMRI\'; 
%  subjDir=dir([rootDir1,'s0*.*']);
% outdir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelMediationPairedTtest_memoryAsMediator\';
% if ~exist(outdir,'dir')
%     mkdir(outdir)
% end
% matlabbatch{1}.spm.stats.factorial_design.dir = {outdir};
% 
% for n = 1:20
%        dataFName{1,1}=[rootDir1,subjDir(includedSubj(n)).name,...
%             '\encoding\analysis-pcaPmod-11\con_',sprintf('%04d',1),'.img']; 
%     dataFName{2,1}= [rootDir1,subjDir(includedSubj(n)).name,...
%             '\encoding\analysis-performancepcaPmod-11\con_',sprintf('%04d',5),'.img'];
%         % Factorial design specification: Scans - cfg_files
%  
%                                                                   
% matlabbatch{1}.spm.stats.factorial_design.des.pt.pair(n).scans = dataFName;
% end


matlabbatch{1}.spm.stats.factorial_design.des.pt.gmsca = 0;
matlabbatch{1}.spm.stats.factorial_design.des.pt.ancova = 0;
matlabbatch{1}.spm.stats.factorial_design.cov = struct('c', {}, 'cname', {}, 'iCFI', {}, 'iCC', {});
matlabbatch{1}.spm.stats.factorial_design.masking.tm.tm_none = 1;
matlabbatch{1}.spm.stats.factorial_design.masking.im = 1;
matlabbatch{1}.spm.stats.factorial_design.masking.em = {''};
matlabbatch{1}.spm.stats.factorial_design.globalc.g_omit = 1;
matlabbatch{1}.spm.stats.factorial_design.globalm.gmsca.gmsca_no = 1;
matlabbatch{1}.spm.stats.factorial_design.globalm.glonorm = 1;
matlabbatch{2}.spm.stats.fmri_est.spmmat(1) = cfg_dep;
matlabbatch{2}.spm.stats.fmri_est.spmmat(1).tname = 'Select SPM.mat';
matlabbatch{2}.spm.stats.fmri_est.spmmat(1).tgt_spec{1}(1).name = 'filter';
matlabbatch{2}.spm.stats.fmri_est.spmmat(1).tgt_spec{1}(1).value = 'mat';
matlabbatch{2}.spm.stats.fmri_est.spmmat(1).tgt_spec{1}(2).name = 'strtype';
matlabbatch{2}.spm.stats.fmri_est.spmmat(1).tgt_spec{1}(2).value = 'e';
matlabbatch{2}.spm.stats.fmri_est.spmmat(1).sname = 'Factorial design specification: SPM.mat File';
matlabbatch{2}.spm.stats.fmri_est.spmmat(1).src_exbranch = substruct('.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1});
matlabbatch{2}.spm.stats.fmri_est.spmmat(1).src_output = substruct('.','spmmat');
matlabbatch{2}.spm.stats.fmri_est.method.Classical = 1;
matlabbatch{3}.spm.stats.con.spmmat(1) = cfg_dep;
matlabbatch{3}.spm.stats.con.spmmat(1).tname = 'Select SPM.mat';
matlabbatch{3}.spm.stats.con.spmmat(1).tgt_spec{1}(1).name = 'filter';
matlabbatch{3}.spm.stats.con.spmmat(1).tgt_spec{1}(1).value = 'mat';
matlabbatch{3}.spm.stats.con.spmmat(1).tgt_spec{1}(2).name = 'strtype';
matlabbatch{3}.spm.stats.con.spmmat(1).tgt_spec{1}(2).value = 'e';
matlabbatch{3}.spm.stats.con.spmmat(1).sname = 'Model estimation: SPM.mat File';
matlabbatch{3}.spm.stats.con.spmmat(1).src_exbranch = substruct('.','val', '{}',{2}, '.','val', '{}',{1}, '.','val', '{}',{1});
matlabbatch{3}.spm.stats.con.spmmat(1).src_output = substruct('.','spmmat');
matlabbatch{3}.spm.stats.con.consess{1}.tcon.name = '+1';
matlabbatch{3}.spm.stats.con.consess{1}.tcon.convec = [1 -1];
matlabbatch{3}.spm.stats.con.consess{1}.tcon.sessrep = 'none';
matlabbatch{3}.spm.stats.con.consess{2}.tcon.name = '-1';
matlabbatch{3}.spm.stats.con.consess{2}.tcon.convec = [-1 1];
matlabbatch{3}.spm.stats.con.consess{2}.tcon.sessrep = 'none';
matlabbatch{3}.spm.stats.con.delete = 0;
spm('defaults', 'FMRI');
spm_jobman('run',matlabbatch);