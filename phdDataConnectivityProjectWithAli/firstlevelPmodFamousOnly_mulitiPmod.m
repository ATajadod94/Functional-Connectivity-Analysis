function firstlevelPmodFamousOnly_mulitiPmod(subID,dataName,isFamOnly,isBinarized)
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
rootDir1 = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\';
rootDir = 'D:\myStudy\picpairfMRI\';
codeDir= [rootDir1,'matlabFunctions\'];
subDir = [rootDir, 's',sprintf('%03d',subID),'\'];
behavDataDir = [subDir,'performanceData\'];
nrun = 1; % enter the number of runs here
% jobfile = {'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\matlabFunctions\firstlevelPmodFamousOnly_job.m'};
% jobs = repmat(jobfile, 1, nrun);
inputs = cell(12, nrun);
for crun = 1:nrun
    FUNCDIR = [rootDir,'s',sprintf('%03d',subID(crun)),'\encoding'];
    inputs{1, crun} = {[FUNCDIR,'\analysis-',cat(2,dataName{:}),'Pmod-',num2str(sum(isFamOnly)),num2str(isBinarized),'\']}; % fMRI model specification: Directory - cfg_files
    if ~exist([FUNCDIR,'\analysis-',cat(2,dataName{:}),'Pmod-',num2str(sum(isFamOnly)),num2str(isBinarized),'\'],'dir')
        mkdir([FUNCDIR,'\analysis-',cat(2,dataName{:}),'Pmod-',num2str(sum(isFamOnly)),num2str(isBinarized),'\']);
    end
    
    inputs{2, crun} = GetImageList4D([FUNCDIR,'\taskRunsConcatenate'], WildcardFilename('*.img')); % fMRI model specification: Scans - cfg_files    
    inputs{3, crun} = {[behavDataDir,cat(2,dataName{:}),'multiCondPmod-',num2str(sum(isFamOnly)),'.mat']}; % fMRI model specification: Multiple conditions - cfg_files
    inputs{4, crun} = {[FUNCDIR,'\taskRunsConcatenate\motionParameter.txt']}; % fMRI model specification: Multiple regressors - cfg_files

end


matlabbatch{1}.spm.stats.fmri_spec.dir = inputs{1, crun};
matlabbatch{1}.spm.stats.fmri_spec.timing.units = 'secs';
matlabbatch{1}.spm.stats.fmri_spec.timing.RT = 2;
matlabbatch{1}.spm.stats.fmri_spec.timing.fmri_t = 16;
matlabbatch{1}.spm.stats.fmri_spec.timing.fmri_t0 = 1;
matlabbatch{1}.spm.stats.fmri_spec.sess.scans = inputs{2, crun};
matlabbatch{1}.spm.stats.fmri_spec.sess.cond = struct('name', {}, 'onset', {}, 'duration', {}, 'tmod', {}, 'pmod', {});
matlabbatch{1}.spm.stats.fmri_spec.sess.multi = inputs{3, crun};
matlabbatch{1}.spm.stats.fmri_spec.sess.regress = struct('name', {}, 'val', {});
matlabbatch{1}.spm.stats.fmri_spec.sess.multi_reg = inputs{4, crun};
matlabbatch{1}.spm.stats.fmri_spec.sess.hpf = 128;
matlabbatch{1}.spm.stats.fmri_spec.fact = struct('name', {}, 'levels', {});
matlabbatch{1}.spm.stats.fmri_spec.bases.hrf.derivs = [0 0];
matlabbatch{1}.spm.stats.fmri_spec.volt = 1;
matlabbatch{1}.spm.stats.fmri_spec.global = 'None';
matlabbatch{1}.spm.stats.fmri_spec.mask = {''};
matlabbatch{1}.spm.stats.fmri_spec.cvi = 'AR(1)';
matlabbatch{2}.spm.stats.fmri_est.spmmat(1) = cfg_dep;
matlabbatch{2}.spm.stats.fmri_est.spmmat(1).tname = 'Select SPM.mat';
matlabbatch{2}.spm.stats.fmri_est.spmmat(1).tgt_spec{1}(1).name = 'filter';
matlabbatch{2}.spm.stats.fmri_est.spmmat(1).tgt_spec{1}(1).value = 'mat';
matlabbatch{2}.spm.stats.fmri_est.spmmat(1).tgt_spec{1}(2).name = 'strtype';
matlabbatch{2}.spm.stats.fmri_est.spmmat(1).tgt_spec{1}(2).value = 'e';
matlabbatch{2}.spm.stats.fmri_est.spmmat(1).sname = 'fMRI model specification: SPM.mat File';
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

for i = 1:length(dataName)
%     inputs{5+(i-1)*8, crun} = [dataName{i},'-fam1']; % Contrast Manager: Name - cfg_entry
%     inputs{6+(i-1)*8, crun} = [zeros(1,i), 1]; % Contrast Manager: T contrast vector - cfg_entry
%     inputs{7+(i-1)*8, crun} = [dataName{i},'-fam2']; % Contrast Manager: Name - cfg_entry
%     inputs{8+(i-1)*8, crun} = [zeros(1,2*(i+1)), 1]; % Contrast Manager: T contrast vector - cfg_entry
%     inputs{9+(i-1)*8, crun} = [dataName{i},'-fam12']; % Contrast Manager: Name - cfg_entry
%     inputs{10+(i-1)*8, crun} = [zeros(1,i), 1, zeros(1,i+1), 1]; % Contrast Manager: T contrast vector - cfg_entry
%     inputs{11+(i-1)*8, crun} = [dataName{i},'-fam1-2']; % Contrast Manager: Name - cfg_entry
%     inputs{12+(i-1)*8, crun} = [zeros(1,i), 1, zeros(1,i+1), -1]; % Contrast Manager: T contrast vector - cfg_entry


matlabbatch{3}.spm.stats.con.consess{1+(i-1)*4}.tcon.name = [dataName{i},'-fam1'];
matlabbatch{3}.spm.stats.con.consess{1+(i-1)*4}.tcon.convec = [zeros(1,i), 1];
matlabbatch{3}.spm.stats.con.consess{1+(i-1)*4}.tcon.sessrep = 'none';
matlabbatch{3}.spm.stats.con.consess{2+(i-1)*4}.tcon.name = [dataName{i},'-fam2'];
matlabbatch{3}.spm.stats.con.consess{2+(i-1)*4}.tcon.convec = [zeros(1,i+length(dataName)+3-1), 1];
matlabbatch{3}.spm.stats.con.consess{2+(i-1)*4}.tcon.sessrep = 'none';
matlabbatch{3}.spm.stats.con.consess{3+(i-1)*4}.tcon.name = [dataName{i},'-fam12'];
matlabbatch{3}.spm.stats.con.consess{3+(i-1)*4}.tcon.convec = [zeros(1,i), 1, zeros(1,length(dataName)+1), 1];
matlabbatch{3}.spm.stats.con.consess{3+(i-1)*4}.tcon.sessrep = 'none';
matlabbatch{3}.spm.stats.con.consess{4+(i-1)*4}.tcon.name = [dataName{i},'-fam1-2'];
matlabbatch{3}.spm.stats.con.consess{4+(i-1)*4}.tcon.convec = [zeros(1,i), 1,zeros(1,length(dataName)+1), -1];
matlabbatch{3}.spm.stats.con.consess{4+(i-1)*4}.tcon.sessrep = 'none';
end

if length(dataName)==2
    i=2;
matlabbatch{3}.spm.stats.con.consess{5+(i-1)*4}.tcon.name = [dataName{1},'-',dataName{2},'-fam1'];
matlabbatch{3}.spm.stats.con.consess{5+(i-1)*4}.tcon.convec = [0, 1,-1];
matlabbatch{3}.spm.stats.con.consess{5+(i-1)*4}.tcon.sessrep = 'none'; 


matlabbatch{3}.spm.stats.con.consess{6+(i-1)*4}.tcon.name = [dataName{1},'-',dataName{2},'-fam2'];
matlabbatch{3}.spm.stats.con.consess{6+(i-1)*4}.tcon.convec = [0,0,0,0,0,1, -1];
matlabbatch{3}.spm.stats.con.consess{6+(i-1)*4}.tcon.sessrep = 'none';


matlabbatch{3}.spm.stats.con.consess{7+(i-1)*4}.tcon.name = [dataName{1},'-',dataName{2},'-fam12'];
matlabbatch{3}.spm.stats.con.consess{7+(i-1)*4}.tcon.convec = [0 1 -1 0 0 1 -1];
matlabbatch{3}.spm.stats.con.consess{7+(i-1)*4}.tcon.sessrep = 'none';

   matlabbatch{3}.spm.stats.con.consess{8+(i-1)*4}.tcon.name = [dataName{1},'+',dataName{2},'-fam1'];
matlabbatch{3}.spm.stats.con.consess{8+(i-1)*4}.tcon.convec = [0, 1,1];
matlabbatch{3}.spm.stats.con.consess{8+(i-1)*4}.tcon.sessrep = 'none'; 


matlabbatch{3}.spm.stats.con.consess{9+(i-1)*4}.tcon.name = [dataName{1},'+',dataName{2},'-fam2'];
matlabbatch{3}.spm.stats.con.consess{9+(i-1)*4}.tcon.convec = [0,0,0,0,0,1, 1];
matlabbatch{3}.spm.stats.con.consess{9+(i-1)*4}.tcon.sessrep = 'none';


matlabbatch{3}.spm.stats.con.consess{10+(i-1)*4}.tcon.name = [dataName{1},'+',dataName{2},'-fam12'];
matlabbatch{3}.spm.stats.con.consess{10+(i-1)*4}.tcon.convec = [0 1 1 0 0 1 1];
matlabbatch{3}.spm.stats.con.consess{10+(i-1)*4}.tcon.sessrep = 'none';

else
  i=length(dataName);  
matlabbatch{3}.spm.stats.con.consess{5+(i-1)*4}.tcon.name = ['all-fam1'];
matlabbatch{3}.spm.stats.con.consess{5+(i-1)*4}.tcon.convec = [0 ones(1,length(dataName))];
matlabbatch{3}.spm.stats.con.consess{5+(i-1)*4}.tcon.sessrep = 'none';   

matlabbatch{3}.spm.stats.con.consess{6+(i-1)*4}.tcon.name = ['all-fam2'];
matlabbatch{3}.spm.stats.con.consess{6+(i-1)*4}.tcon.convec = [zeros(1,length(dataName)+3), ones(1,length(dataName))];
matlabbatch{3}.spm.stats.con.consess{6+(i-1)*4}.tcon.sessrep = 'none'; 

matlabbatch{3}.spm.stats.con.consess{7+(i-1)*4}.tcon.name = ['all-fam12'];
matlabbatch{3}.spm.stats.con.consess{7+(i-1)*4}.tcon.convec = [0, ones(1,length(dataName)),0,0, ones(1,length(dataName))];
matlabbatch{3}.spm.stats.con.consess{7+(i-1)*4}.tcon.sessrep = 'none'; 

end


matlabbatch{3}.spm.stats.con.delete = 0;
matlabbatch{4}.spm.stats.results.spmmat(1) = cfg_dep;
matlabbatch{4}.spm.stats.results.spmmat(1).tname = 'Select SPM.mat';
matlabbatch{4}.spm.stats.results.spmmat(1).tgt_spec{1}(1).name = 'filter';
matlabbatch{4}.spm.stats.results.spmmat(1).tgt_spec{1}(1).value = 'mat';
matlabbatch{4}.spm.stats.results.spmmat(1).tgt_spec{1}(2).name = 'strtype';
matlabbatch{4}.spm.stats.results.spmmat(1).tgt_spec{1}(2).value = 'e';
matlabbatch{4}.spm.stats.results.spmmat(1).sname = 'Contrast Manager: SPM.mat File';
matlabbatch{4}.spm.stats.results.spmmat(1).src_exbranch = substruct('.','val', '{}',{3}, '.','val', '{}',{1}, '.','val', '{}',{1});
matlabbatch{4}.spm.stats.results.spmmat(1).src_output = substruct('.','spmmat');
matlabbatch{4}.spm.stats.results.conspec.titlestr = '';
matlabbatch{4}.spm.stats.results.conspec.contrasts = Inf;
matlabbatch{4}.spm.stats.results.conspec.threshdesc = 'none';
matlabbatch{4}.spm.stats.results.conspec.thresh = 0.05;
matlabbatch{4}.spm.stats.results.conspec.extent = 10;
matlabbatch{4}.spm.stats.results.conspec.mask = struct('contrasts', {}, 'thresh', {}, 'mtype', {});
matlabbatch{4}.spm.stats.results.units = 1;
matlabbatch{4}.spm.stats.results.print = true;

spm('defaults', 'FMRI');
spm_jobman('run',matlabbatch);
