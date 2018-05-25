function firstlevelDiffMemoryTypeAnalysis(subID)
% List of open inputs
% fMRI model specification: Directory - cfg_files
% fMRI model specification: Scans - cfg_files
% fMRI model specification: Multiple conditions - cfg_files
% fMRI model specification: Multiple regressors - cfg_files
spm('defaults', 'FMRI');
rootDir = 'D:\myStudy\picpairfMRI\';
FUNCDIR = [rootDir,'s',sprintf('%03d',subID),'\encoding'];
    outputDir = {[FUNCDIR,'\analysis-DiffMemType\']}; % fMRI model specification: Directory - cfg_files
    if ~exist([FUNCDIR,'\analysis-DiffMemType\'],'dir')
        mkdir([FUNCDIR,'\analysis-DiffMemType\']);
    end
    multiMatDir = [rootDir,'s',sprintf('%03d',subID),'\performanceData\'];
    funImage = GetImageList4D([FUNCDIR,'\taskRunsConcatenate'], WildcardFilename('*.img')); % fMRI model specification: Scans - cfg_files    
    multiCondData = {[multiMatDir,'DiffMmeTypeMultiCond.mat']}; % fMRI model specification: Multiple conditions - cfg_files
    regData = {[FUNCDIR,'\taskRunsConcatenate\motionParameter.txt']}; % fMRI model specification: Multiple regressors - cfg_files

matlabbatch{1}.spm.stats.fmri_spec.dir = outputDir;
matlabbatch{1}.spm.stats.fmri_spec.timing.units = 'secs';
matlabbatch{1}.spm.stats.fmri_spec.timing.RT = 2;
matlabbatch{1}.spm.stats.fmri_spec.timing.fmri_t = 16;
matlabbatch{1}.spm.stats.fmri_spec.timing.fmri_t0 = 1;
matlabbatch{1}.spm.stats.fmri_spec.sess.scans = funImage;
matlabbatch{1}.spm.stats.fmri_spec.sess.cond = struct('name', {}, 'onset', {}, 'duration', {}, 'tmod', {}, 'pmod', {});
matlabbatch{1}.spm.stats.fmri_spec.sess.multi = multiCondData;
matlabbatch{1}.spm.stats.fmri_spec.sess.regress = struct('name', {}, 'val', {});
matlabbatch{1}.spm.stats.fmri_spec.sess.multi_reg = regData;
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

matlabbatch{3}.spm.stats.con.consess{1}.tcon.name = 'famPairAsso1';
matlabbatch{3}.spm.stats.con.consess{1}.tcon.convec = [1 0 0 0 0];
matlabbatch{3}.spm.stats.con.consess{1}.tcon.sessrep = 'none';
matlabbatch{3}.spm.stats.con.consess{2}.tcon.name = 'famPairNoAsso1';
matlabbatch{3}.spm.stats.con.consess{2}.tcon.convec = [0 1 0 0 0];
matlabbatch{3}.spm.stats.con.consess{2}.tcon.sessrep = 'none';
matlabbatch{3}.spm.stats.con.consess{3}.tcon.name = 'famFaceOnly1';
matlabbatch{3}.spm.stats.con.consess{3}.tcon.convec = [0 0 1 0 0];
matlabbatch{3}.spm.stats.con.consess{3}.tcon.sessrep = 'none';
matlabbatch{3}.spm.stats.con.consess{4}.tcon.name = 'famHouseNoMem1';
matlabbatch{3}.spm.stats.con.consess{4}.tcon.convec = [0 0 0 1 0];
matlabbatch{3}.spm.stats.con.consess{4}.tcon.sessrep = 'none';

matlabbatch{3}.spm.stats.con.consess{5}.tcon.name = 'famScramble1';
matlabbatch{3}.spm.stats.con.consess{5}.tcon.convec = [zeros(1,4), 1];
matlabbatch{3}.spm.stats.con.consess{5}.tcon.sessrep = 'none';

matlabbatch{3}.spm.stats.con.consess{6}.tcon.name = 'famPairAsso2';
matlabbatch{3}.spm.stats.con.consess{6}.tcon.convec = [0 0 0 0 0 1 0 0 0 0];
matlabbatch{3}.spm.stats.con.consess{6}.tcon.sessrep = 'none';
matlabbatch{3}.spm.stats.con.consess{7}.tcon.name = 'famPairNoAsso2';
matlabbatch{3}.spm.stats.con.consess{7}.tcon.convec = [0 0 0 0 0 0 1 0 0 0];
matlabbatch{3}.spm.stats.con.consess{7}.tcon.sessrep = 'none';
matlabbatch{3}.spm.stats.con.consess{8}.tcon.name = 'famFaceOnly2';
matlabbatch{3}.spm.stats.con.consess{8}.tcon.convec = [0 0 0 0 0 0 0 1 0 0];
matlabbatch{3}.spm.stats.con.consess{8}.tcon.sessrep = 'none';
matlabbatch{3}.spm.stats.con.consess{9}.tcon.name = 'famHouseNoMem2';
matlabbatch{3}.spm.stats.con.consess{9}.tcon.convec = [0 0 0 0 0 0 0 0 1 0];
matlabbatch{3}.spm.stats.con.consess{9}.tcon.sessrep = 'none';

matlabbatch{3}.spm.stats.con.consess{10}.tcon.name = 'famScramble2';
matlabbatch{3}.spm.stats.con.consess{10}.tcon.convec = [0 0 0 0 0 0 0 0 0 1];
matlabbatch{3}.spm.stats.con.consess{10}.tcon.sessrep = 'none';


matlabbatch{3}.spm.stats.con.consess{11}.tcon.name = 'nfamPairAsso1';
matlabbatch{3}.spm.stats.con.consess{11}.tcon.convec = [0 0 0 0 0 0 0 0 0 0 1 0 0 0 0];
matlabbatch{3}.spm.stats.con.consess{11}.tcon.sessrep = 'none';
matlabbatch{3}.spm.stats.con.consess{12}.tcon.name = 'nfamPairNoAsso1';
matlabbatch{3}.spm.stats.con.consess{12}.tcon.convec = [0 0 0 0 0 0 0 0 0 0 0 1 0 0 0];
matlabbatch{3}.spm.stats.con.consess{12}.tcon.sessrep = 'none';
matlabbatch{3}.spm.stats.con.consess{13}.tcon.name = 'nfamFaceOnly1';
matlabbatch{3}.spm.stats.con.consess{13}.tcon.convec = [0 0 0 0 0 0 0 0 0 0 0 0 1 0 0];
matlabbatch{3}.spm.stats.con.consess{13}.tcon.sessrep = 'none';
matlabbatch{3}.spm.stats.con.consess{14}.tcon.name = 'nfamHouseNoMem1';
matlabbatch{3}.spm.stats.con.consess{14}.tcon.convec = [0 0 0 0 0 0 0 0 0 0 0 0 0 1 0];
matlabbatch{3}.spm.stats.con.consess{14}.tcon.sessrep = 'none';

matlabbatch{3}.spm.stats.con.consess{15}.tcon.name = 'nfamScramble1';
matlabbatch{3}.spm.stats.con.consess{15}.tcon.convec = [0 0 0 0 0 0 0 0 0 0 0 0 0 0 1];
matlabbatch{3}.spm.stats.con.consess{15}.tcon.sessrep = 'none';

matlabbatch{3}.spm.stats.con.consess{16}.tcon.name = 'nfamPairAsso2';
matlabbatch{3}.spm.stats.con.consess{16}.tcon.convec = [0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 0];
matlabbatch{3}.spm.stats.con.consess{16}.tcon.sessrep = 'none';
matlabbatch{3}.spm.stats.con.consess{17}.tcon.name = 'nfamPairNoAsso2';
matlabbatch{3}.spm.stats.con.consess{17}.tcon.convec = [0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0];
matlabbatch{3}.spm.stats.con.consess{17}.tcon.sessrep = 'none';
matlabbatch{3}.spm.stats.con.consess{18}.tcon.name = 'nfamFaceOnly2';
matlabbatch{3}.spm.stats.con.consess{18}.tcon.convec = [0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0];
matlabbatch{3}.spm.stats.con.consess{18}.tcon.sessrep = 'none';
matlabbatch{3}.spm.stats.con.consess{19}.tcon.name = 'nfamHouseNoMem2';
matlabbatch{3}.spm.stats.con.consess{19}.tcon.convec = [0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0];
matlabbatch{3}.spm.stats.con.consess{19}.tcon.sessrep = 'none';

matlabbatch{3}.spm.stats.con.consess{20}.tcon.name = 'nfamScramble2';
matlabbatch{3}.spm.stats.con.consess{20}.tcon.convec = [0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1];
matlabbatch{3}.spm.stats.con.consess{20}.tcon.sessrep = 'none';


%famous block combined contrast
matlabbatch{3}.spm.stats.con.consess{21}.tcon.name = 'famPairAsso12';
matlabbatch{3}.spm.stats.con.consess{21}.tcon.convec = [1 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0];
matlabbatch{3}.spm.stats.con.consess{21}.tcon.sessrep = 'none';

matlabbatch{3}.spm.stats.con.consess{22}.tcon.name = 'famPairNoAsso12';
matlabbatch{3}.spm.stats.con.consess{22}.tcon.convec = [0 1 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0];
matlabbatch{3}.spm.stats.con.consess{22}.tcon.sessrep = 'none';

matlabbatch{3}.spm.stats.con.consess{23}.tcon.name = 'famFaceOnly12';
matlabbatch{3}.spm.stats.con.consess{23}.tcon.convec = [0 0 1 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0];
matlabbatch{3}.spm.stats.con.consess{23}.tcon.sessrep = 'none';

matlabbatch{3}.spm.stats.con.consess{24}.tcon.name = 'famHouseNoMem12';
matlabbatch{3}.spm.stats.con.consess{24}.tcon.convec = [0 0 0 1 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0];
matlabbatch{3}.spm.stats.con.consess{24}.tcon.sessrep = 'none';

matlabbatch{3}.spm.stats.con.consess{25}.tcon.name = 'famScramble12';
matlabbatch{3}.spm.stats.con.consess{25}.tcon.convec = [0 0 0 0 1 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0];
matlabbatch{3}.spm.stats.con.consess{25}.tcon.sessrep = 'none';


%nonfamous block combined contrast
matlabbatch{3}.spm.stats.con.consess{26}.tcon.name = 'nfamPairAsso12';
matlabbatch{3}.spm.stats.con.consess{26}.tcon.convec = [0 0 0 0 0 0 0 0 0 0 1 0 0 0 0 1 0 0 0 0 ];
matlabbatch{3}.spm.stats.con.consess{26}.tcon.sessrep = 'none';

matlabbatch{3}.spm.stats.con.consess{27}.tcon.name = 'nfamPairNoAsso12';
matlabbatch{3}.spm.stats.con.consess{27}.tcon.convec = [0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 0 1 0 0 0 ];
matlabbatch{3}.spm.stats.con.consess{27}.tcon.sessrep = 'none';

matlabbatch{3}.spm.stats.con.consess{28}.tcon.name = 'nfamFaceOnly12';
matlabbatch{3}.spm.stats.con.consess{28}.tcon.convec = [0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 0 1 0 0 ];
matlabbatch{3}.spm.stats.con.consess{28}.tcon.sessrep = 'none';

matlabbatch{3}.spm.stats.con.consess{29}.tcon.name = 'nfamHouseNoMem12';
matlabbatch{3}.spm.stats.con.consess{29}.tcon.convec = [0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 0 1 0 ];
matlabbatch{3}.spm.stats.con.consess{29}.tcon.sessrep = 'none';

matlabbatch{3}.spm.stats.con.consess{30}.tcon.name = 'nfamScramble12';
matlabbatch{3}.spm.stats.con.consess{30}.tcon.convec = [0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 0 1 ];
matlabbatch{3}.spm.stats.con.consess{30}.tcon.sessrep = 'none';


%famous differential contrast
matlabbatch{3}.spm.stats.con.consess{31}.tcon.name = 'famPairAsso-noAsso1';
matlabbatch{3}.spm.stats.con.consess{31}.tcon.convec = [1 -1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0];
matlabbatch{3}.spm.stats.con.consess{31}.tcon.sessrep = 'none';

matlabbatch{3}.spm.stats.con.consess{32}.tcon.name = 'famPairAsso-noAsso2';
matlabbatch{3}.spm.stats.con.consess{32}.tcon.convec = [0 0 0 0 0 1 -1 0 0 0 0 0 0 0 0 0 0 0 0 0];
matlabbatch{3}.spm.stats.con.consess{32}.tcon.sessrep = 'none';


matlabbatch{3}.spm.stats.con.consess{33}.tcon.name = 'famPairAsso-noAsso12';
matlabbatch{3}.spm.stats.con.consess{33}.tcon.convec = [1 -1 0 0 0 1 -1 0 0 0 0 0 0 0 0 0 0 0 0 0];
matlabbatch{3}.spm.stats.con.consess{33}.tcon.sessrep = 'none';


matlabbatch{3}.spm.stats.con.consess{34}.tcon.name = 'famPairAsso-faceOnly1';
matlabbatch{3}.spm.stats.con.consess{34}.tcon.convec = [1 0 -1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0];
matlabbatch{3}.spm.stats.con.consess{34}.tcon.sessrep = 'none';

matlabbatch{3}.spm.stats.con.consess{35}.tcon.name = 'famPairAsso-faceOnly2';
matlabbatch{3}.spm.stats.con.consess{35}.tcon.convec = [0 0 0 0 0 1 0 -1 0 0 0 0 0 0 0 0 0 0 0 0];
matlabbatch{3}.spm.stats.con.consess{35}.tcon.sessrep = 'none';


matlabbatch{3}.spm.stats.con.consess{36}.tcon.name = 'famPairAsso-faceOnly12';
matlabbatch{3}.spm.stats.con.consess{36}.tcon.convec = [1 0 -1 0 0 1 0 -1 0 0 0 0 0 0 0 0 0 0 0 0];
matlabbatch{3}.spm.stats.con.consess{36}.tcon.sessrep = 'none';


matlabbatch{3}.spm.stats.con.consess{37}.tcon.name = 'famPairAsso-houseNoMem1';
matlabbatch{3}.spm.stats.con.consess{37}.tcon.convec = [1 0 0 -1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0];
matlabbatch{3}.spm.stats.con.consess{37}.tcon.sessrep = 'none';

matlabbatch{3}.spm.stats.con.consess{38}.tcon.name = 'famPairAsso-houseNoMem2';
matlabbatch{3}.spm.stats.con.consess{38}.tcon.convec = [0 0 0 0 0 1 0 0 -1 0 0 0 0 0 0 0 0 0 0 0];
matlabbatch{3}.spm.stats.con.consess{38}.tcon.sessrep = 'none';


matlabbatch{3}.spm.stats.con.consess{39}.tcon.name = 'famPairAsso-houseNoMem12';
matlabbatch{3}.spm.stats.con.consess{39}.tcon.convec = [1 0 0 -1 0 1 0 0 -1 0 0 0 0 0 0 0 0 0 0 0];
matlabbatch{3}.spm.stats.con.consess{39}.tcon.sessrep = 'none';


%nonfamous differential t contrast
matlabbatch{3}.spm.stats.con.consess{40}.tcon.name = 'nfamPairAsso-noAsso1';
matlabbatch{3}.spm.stats.con.consess{40}.tcon.convec = [0 0 0 0 0 0 0 0 0 0 1 -1 0 0 0 0 0 0 0 0 ];
matlabbatch{3}.spm.stats.con.consess{40}.tcon.sessrep = 'none';

matlabbatch{3}.spm.stats.con.consess{41}.tcon.name = 'nfamPairAsso-noAsso2';
matlabbatch{3}.spm.stats.con.consess{41}.tcon.convec = [0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -1 0 0 0 ];
matlabbatch{3}.spm.stats.con.consess{41}.tcon.sessrep = 'none';


matlabbatch{3}.spm.stats.con.consess{42}.tcon.name = 'nfamPairAsso-noAsso12';
matlabbatch{3}.spm.stats.con.consess{42}.tcon.convec = [0 0 0 0 0 0 0 0 0 0 1 -1 0 0 0 1 -1 0 0 0 ];
matlabbatch{3}.spm.stats.con.consess{42}.tcon.sessrep = 'none';


matlabbatch{3}.spm.stats.con.consess{43}.tcon.name = 'nfamPairAsso-faceOnly1';
matlabbatch{3}.spm.stats.con.consess{43}.tcon.convec = [0 0 0 0 0 0 0 0 0 0 1 0 -1 0 0 0 0 0 0 0];
matlabbatch{3}.spm.stats.con.consess{43}.tcon.sessrep = 'none';

matlabbatch{3}.spm.stats.con.consess{44}.tcon.name = 'nfamPairAsso-faceOnly2';
matlabbatch{3}.spm.stats.con.consess{44}.tcon.convec = [0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 -1 0 0];
matlabbatch{3}.spm.stats.con.consess{44}.tcon.sessrep = 'none';


matlabbatch{3}.spm.stats.con.consess{45}.tcon.name = 'nfamPairAsso-faceOnly12';
matlabbatch{3}.spm.stats.con.consess{45}.tcon.convec = [0 0 0 0 0 0 0 0 0 0 1 0 -1 0 0 1 0 -1 0 0];
matlabbatch{3}.spm.stats.con.consess{45}.tcon.sessrep = 'none';


matlabbatch{3}.spm.stats.con.consess{46}.tcon.name = 'nfamPairAsso-houseNoMem1';
matlabbatch{3}.spm.stats.con.consess{46}.tcon.convec = [0 0 0 0 0 0 0 0 0 0 1 0 0 -1 0 0 0 0 0 0];
matlabbatch{3}.spm.stats.con.consess{46}.tcon.sessrep = 'none';

matlabbatch{3}.spm.stats.con.consess{47}.tcon.name = 'nfamPairAsso-houseNoMem2';
matlabbatch{3}.spm.stats.con.consess{47}.tcon.convec = [0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 -1 0];
matlabbatch{3}.spm.stats.con.consess{47}.tcon.sessrep = 'none';


matlabbatch{3}.spm.stats.con.consess{48}.tcon.name = 'nfamPairAsso-houseNoMem12';
matlabbatch{3}.spm.stats.con.consess{48}.tcon.convec = [0 0 0 0 0 0 0 0 0 0 1 0 0 -1 0 1 0 0 -1 0];
matlabbatch{3}.spm.stats.con.consess{48}.tcon.sessrep = 'none';



matlabbatch{3}.spm.stats.con.delete = 1;
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
matlabbatch{4}.spm.stats.results.conspec.thresh = 0.005;
matlabbatch{4}.spm.stats.results.conspec.extent = 10;
matlabbatch{4}.spm.stats.results.conspec.mask = struct('contrasts', {}, 'thresh', {}, 'mtype', {});
matlabbatch{4}.spm.stats.results.units = 1;
matlabbatch{4}.spm.stats.results.print = false;

spm_jobman('run',matlabbatch);