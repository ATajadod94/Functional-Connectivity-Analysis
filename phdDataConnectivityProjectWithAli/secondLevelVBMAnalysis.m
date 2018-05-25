function secondLevelVBMAnalysis(subID, isCovariate,memType,memCatg,fameType)
%-----------------------------------------------------------------------
% Job configuration created by cfg_util (rev $Rev: 4252 $)
%-----------------------------------------------------------------------

% % spm smooth
% clear matlabbatch;
% projDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\';
% subID=1:20;
% for i = subID
% subjDir = [projDir,'s',sprintf('%03d',i),'\'];
% subjVBMDir = [subjDir,'VBM\'];
% matlabbatch{1}.spm.spatial.smooth.data = {[subjVBMDir, 'm0wrp1vol_0001.nii']};
% matlabbatch{1}.spm.spatial.smooth.fwhm = [10 10 10];
% matlabbatch{1}.spm.spatial.smooth.dtype = 0;
% matlabbatch{1}.spm.spatial.smooth.im = 1;
% matlabbatch{1}.spm.spatial.smooth.prefix = 's';
% save('job.mat','matlabbatch');
% spm_jobman('run',matlabbatch);
% end


projDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\';
for i = subID
    subjDir = [projDir,'s',sprintf('%03d',i),'\'];
    subjVBMDir = [subjDir,'VBM\'];
    scans{i,1}=[subjVBMDir,'sm0wrp1vol_0001.nii'];
end
load([projDir,'secondLevelVBM\globVol.mat']);
[a b]=xlsread([projDir,'matlabFunctions\picpairSubjInfo.xlsx']);
age=a(:,2)-mean(a(:,2));
gender = a(:,3);
gender(gender==0) = -1;

%get memory performance
load([projDir,'matlabFunctions\performanceDataConcatenated.mat']);
if strcmp(fameType,'fam')
    if memType==1
        if strcmp(memCatg,'face')
            memData = faceMem.firstRecFam;
        elseif strcmp(memCatg,'house')
            memData = houseMem.firstRecFam;
        elseif strcmp(memCatg,'pair')
            memData = pairMem.intactFam;
        end
    else memType==0
        if strcmp(memCatg,'face')
            memData = faceMem.totalFam;
        elseif strcmp(memCatg,'house')
            memData = houseMem.totalFam;
        elseif strcmp(memCatg,'pair')
            memData = pairMem.avgFam;
        end
    end
elseif strcmp(fameType,'nonfam')
    if memType==1
        if strcmp(memCatg,'face')
            memData = faceMem.firstRecNFam;
        elseif strcmp(memCatg,'house')
            memData = houseMem.firstRecNFam;
        elseif strcmp(memCatg,'pair')
            memData = pairMem.intactNFam;
        end
    else memType==0
        if strcmp(memCatg,'face')
            memData = faceMem.totalNFam;
        elseif strcmp(memCatg,'house')
            memData = houseMem.totalNFam;
        elseif strcmp(memCatg,'pair')
            memData = pairMem.avgNFam;
        end
    end
elseif strcmp(fameType,'famnonfam')
    if memType==1
        if strcmp(memCatg,'face')
            memData = faceMem.firstRecFam+faceMem.firstRecNFam;
        elseif strcmp(memCatg,'house')
            memData = houseMem.firstRecFam +houseMem.firstRecNFam;
        elseif strcmp(memCatg,'pair')
            memData = pairMem.intactFam +pairMem.intactNFam;
        end
    else memType==0
        if strcmp(memCatg,'face')
            memData = faceMem.totalFam+faceMem.totalNFam;
        elseif strcmp(memCatg,'house')
            memData = houseMem.totalFam +houseMem.totalNFam;
        elseif strcmp(memCatg,'pair')
            memData = pairMem.avgFam +pairMem.avgNFam;
        end
    end
end
    

 memData = covariMemData(memData,isCovariate);


spm('defaults','fmri');
clear matlabbatch;
matlabbatch{1}.spm.stats.factorial_design.dir = {[projDir,'secondLevelVBMCtrRetrDelay\',...
    memCatg,'-',num2str(memType),'-',fameType,'\']};
if ~exist([projDir,'secondLevelVBMCtrRetrDelay\',memCatg,'-',num2str(memType),'-',fameType,'\'],'dir');
    mkdir([projDir,'secondLevelVBMCtrRetrDelay\',memCatg,'-',num2str(memType),'-',fameType,'\']);
end
matlabbatch{1}.spm.stats.factorial_design.des.mreg.scans = scans;
matlabbatch{1}.spm.stats.factorial_design.des.mreg.mcov.c = memData;
matlabbatch{1}.spm.stats.factorial_design.des.mreg.mcov.cname = 'Memory';
matlabbatch{1}.spm.stats.factorial_design.des.mreg.mcov.iCC = 1;
matlabbatch{1}.spm.stats.factorial_design.des.mreg.incint = 1;
% matlabbatch{1}.spm.stats.factorial_design.cov(1).c = globVol;
% matlabbatch{1}.spm.stats.factorial_design.cov(1).cname = 'globVol';
% matlabbatch{1}.spm.stats.factorial_design.cov(1).iCFI = 1;
% matlabbatch{1}.spm.stats.factorial_design.cov(1).iCC = 1;
matlabbatch{1}.spm.stats.factorial_design.cov(1).c = age;
matlabbatch{1}.spm.stats.factorial_design.cov(1).cname = 'age';
matlabbatch{1}.spm.stats.factorial_design.cov(1).iCFI = 1;
matlabbatch{1}.spm.stats.factorial_design.cov(1).iCC = 1;
matlabbatch{1}.spm.stats.factorial_design.cov(2).c = gender;
matlabbatch{1}.spm.stats.factorial_design.cov(2).cname = 'gender';
matlabbatch{1}.spm.stats.factorial_design.cov(2).iCFI = 1;
matlabbatch{1}.spm.stats.factorial_design.cov(2).iCC = 1;
% matlabbatch{1}.spm.stats.factorial_design.masking.tm.tm_none = 1;
matlabbatch{1}.spm.stats.factorial_design.masking.tm.tma.athresh = 0.2;
matlabbatch{1}.spm.stats.factorial_design.masking.im = 1;
% matlabbatch{1}.spm.stats.factorial_design.masking.em = {'C:\Users\Zhongxu\Documents\MATLAB\myMatLabTools\majorNeuroImagingTools\spm8\templates\T1.nii'};
matlabbatch{1}.spm.stats.factorial_design.masking.em = {''};

% matlabbatch{1}.spm.stats.factorial_design.globalc.g_omit = 1;
% matlabbatch{1}.spm.stats.factorial_design.globalm.gmsca.gmsca_no = 1;
% matlabbatch{1}.spm.stats.factorial_design.globalm.glonorm = 1;

matlabbatch{1}.spm.stats.factorial_design.globalc.g_user.global_uval = globVol;
matlabbatch{1}.spm.stats.factorial_design.globalm.gmsca.gmsca_no = 1;
matlabbatch{1}.spm.stats.factorial_design.globalm.glonorm = 2;

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
matlabbatch{3}.spm.stats.con.consess{1}.tcon.name = 'Mem-Brain+1';
matlabbatch{3}.spm.stats.con.consess{1}.tcon.convec = [0 0 0 1];
matlabbatch{3}.spm.stats.con.consess{1}.tcon.sessrep = 'none';
matlabbatch{3}.spm.stats.con.consess{2}.tcon.name = 'Mem-Brain-1';
matlabbatch{3}.spm.stats.con.consess{2}.tcon.convec = [0 0 0 -1];
matlabbatch{3}.spm.stats.con.consess{2}.tcon.sessrep = 'none';
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
matlabbatch{4}.spm.stats.results.conspec.threshdesc = 'FWE';
matlabbatch{4}.spm.stats.results.conspec.thresh = 0.05;
matlabbatch{4}.spm.stats.results.conspec.extent = 0;
matlabbatch{4}.spm.stats.results.conspec.mask = struct('contrasts', {}, 'thresh', {}, 'mtype', {});
matlabbatch{4}.spm.stats.results.units = 1;
matlabbatch{4}.spm.stats.results.print = true;
spm_jobman('run', matlabbatch);
cd([projDir,'matlabFunctions\']);


function memData = covariMemData(memData,isCovariate)
rootDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\';
[subjInfo a]=xlsread([rootDir,'matlabFunctions\picpairSubjInfo.xlsx']);
fameOrder = zeros(size(subjInfo,1),1);
fameOrder(1:2:end,1) = 1;
fameOrder(2:2:end,1) = -1;
deltaT = calculateTimeDelayBetweenEncodingAndRetrieval;
if isCovariate ==1
    [a b memData]=regress(memData,[ones(size(subjInfo,1),1),...
        fameOrder]);
elseif isCovariate ==2
    [a b memData]=regress(memData,[ones(size(subjInfo,1),1),...
        deltaT']);
elseif isCovariate ==3
    [a b memData]=regress(memData,[ones(size(subjInfo,1),1),...
        fameOrder deltaT']);
end
