function analysislog = doFirstLevelFaceHouseTaskAnalysis_MNI(subjN)
% List of open inputs
% fMRI model specification: Onsets - cfg_entry
% fMRI model specification: Durations - cfg_entry
% fMRI model specification: Scans - cfg_files
% fMRI model specification: Scans - cfg_files
% clear variables
scriptdir =pwd;
subjectdir = fullfile(scriptdir,'../../Data/PreProcess');
conditions = fullfile(scriptdir,'../Conds');
allconds = dir(conditions);
multiconds = allconds(end-3:end);
contrastnames = {'facehouse','scrambled','face-scrambled','fam1','scramb1','fam2','scramb2','nonfam1','scramb3','nonfam2','scramb4'};
contrastvects = {[1],[0,1],[1,-1],[1],[0,1],[zeros(1,8),1],[zeros(1,8),0,1],...
    [zeros(1,8),zeros(1,8),1],[zeros(1,8),zeros(1,8),0,1],...
    [zeros(1,8),zeros(1,8),zeros(1,8),1],[zeros(1,8),zeros(1,8),zeros(1,8),0,1]};
for i = 1:4
    cond{i} = {fullfile(conditions,multiconds(i).name)};
end
runs = {'encoding_fam1','encoding_fam2','encoding_nonfam1','encoding_nonfam2'};
for subject = subjN
    fname = strcat('Subject_', sprintf('%02d',subject));
    thissubjectdir = fullfile(subjectdir,fname);
    outdir = fullfile(thissubjectdir,'firstlevelAnalysis');
    mkdir(outdir)
    allruns = dir(thissubjectdir);
    numsession = 1;
    for j = 1:length(allruns)
        if ismember(allruns(j).name,runs)
            session(numsession) = allruns(j);
            numsession= numsession+1;
        end
    end
    files =  {};
    numsession = numsession-1;
    for i=1:numsession
        thisdir = fullfile(thissubjectdir,session(i).name);
        allfiles = dir(thisdir);
      
        sessfiles = {};

        for j = 1:length(allfiles)
            if strcmp(allfiles(j).name(1),'s') && strcmp(allfiles(j).name(end-3:end),'.img')
                sessfiles{1,end+1} = fullfile(thisdir,allfiles(j).name);
            end
            tempa = dir(fullfile(thisdir,'r*.txt'));
                reg = fullfile(thisdir,tempa.name);
                         
        end
        files{i} = sessfiles;
        multi{i} = {reg};
    end
      

matlabbatch{1}.spm.stats.fmri_spec.dir = {outdir};
matlabbatch{1}.spm.stats.fmri_spec.timing.units = 'secs';
matlabbatch{1}.spm.stats.fmri_spec.timing.RT = 2;
matlabbatch{1}.spm.stats.fmri_spec.timing.fmri_t = 16;
matlabbatch{1}.spm.stats.fmri_spec.timing.fmri_t0 = 1;
for i=1:numsession
matlabbatch{1}.spm.stats.fmri_spec.sess(i).scans = files{i};
matlabbatch{1}.spm.stats.fmri_spec.sess(i).multi = cond{i};
matlabbatch{1}.spm.stats.fmri_spec.sess(i).multi_reg = multi{i};
matlabbatch{1}.spm.stats.fmri_spec.sess(i).hpf = 128;
end

matlabbatch{1}.spm.stats.fmri_spec.bases.hrf.derivs = [0 0];
matlabbatch{1}.spm.stats.fmri_spec.volt = 1;
matlabbatch{1}.spm.stats.fmri_spec.global = 'None';
matlabbatch{1}.spm.stats.fmri_spec.mask = {''};
matlabbatch{1}.spm.stats.fmri_spec.cvi = 'AR(1)';

%% BATCH 2 - MODEL ESTIMATION 
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

%% BATCH 3 - CONTRAST MANAGER 
matlabbatch{3}.spm.stats.con.spmmat(1) = cfg_dep;
matlabbatch{3}.spm.stats.con.spmmat(1).tname = 'Select SPM.mat';
matlabbatch{3}.spm.stats.con.spmmat(1).tgt_spec{1}(1).name = 'filter';
matlabbatch{3}.spm.stats.con.spmmat(1).tgt_spec{1}(1).value = 'mat';
matlabbatch{3}.spm.stats.con.spmmat(1).tgt_spec{1}(2).name = 'strtype';
matlabbatch{3}.spm.stats.con.spmmat(1).tgt_spec{1}(2).value = 'e';
matlabbatch{3}.spm.stats.con.spmmat(1).sname = 'Model estimation: SPM.mat File';
matlabbatch{3}.spm.stats.con.spmmat(1).src_exbranch = substruct('.','val', '{}',{2}, '.','val', '{}',{1}, '.','val', '{}',{1});
matlabbatch{3}.spm.stats.con.spmmat(1).src_output = substruct('.','spmmat');
for i=1:length(contrastnames)
    matlabbatch{3}.spm.stats.con.consess{i}.tcon.name = contrastnames{i};
    matlabbatch{3}.spm.stats.con.consess{i}.tcon.convec = contrastvects{i};
    if i<=3 
        matlabbatch{3}.spm.stats.con.consess{i}.tcon.sessrep = 'repl';
    else
        matlabbatch{3}.spm.stats.con.consess{i}.tcon.sessrep = 'none';

    end
end
matlabbatch{3}.spm.stats.con.delete = 0;

      spm('defaults', 'FMRI');
        spm_jobman('serial', matlabbatch);
end

analysislog{subject}.cond = cond;
analysislog{subject}.multi = multi;
analysislog{subject}.files = files;
analysislog{subject}.outdir = outdir;