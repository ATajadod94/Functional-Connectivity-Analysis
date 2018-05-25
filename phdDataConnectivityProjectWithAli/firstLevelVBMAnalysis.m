function firstLevelVBMAnalysis(subID)
projDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\';
for i = subID
subjDir = [projDir,'s',sprintf('%03d',i),'\'];
subjVBMDir = [subjDir,'VBM\'];
if ~exist(subjVBMDir,'dir')
    mkdir(subjVBMDir);
end

%copy anatomy T1 image to vbm dir
copyfile([subjDir,'scanImgData\run_0003\vol_0001.*'],subjVBMDir);

% VBM8: Estimate & Write: Volumes - cfg_files
jobs = {'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\matlabFunctions\vmbEstimate&write_job.m'};
inputs{1} = {[subjVBMDir, 'vol_0001.img']}; % VBM8: Estimate & Write: Volumes - cfg_files spm('defaults', 'FMRI');
spm_jobman('serial', jobs, '', inputs{:});

% spm smooth 
matlabbatch{1}.spm.spatial.smooth.data = {[subjVBMDir, 'm0wrp1vol_0001.nii']};
matlabbatch{1}.spm.spatial.smooth.fwhm = [10 10 10];
matlabbatch{1}.spm.spatial.smooth.dtype = 0;
matlabbatch{1}.spm.spatial.smooth.im = 0;
matlabbatch{1}.spm.spatial.smooth.prefix = 's';
save('job.mat','matlabbatch');
spm_jobman('run',matlabbatch);

globVol(i) = spm_get_volumes([subjVBMDir,'m0wrp1vol_0001.nii']) + ...
             spm_get_volumes([subjVBMDir,'m0wrp2vol_0001.nii']) + ...
             spm_get_volumes([subjVBMDir,'m0wrp3vol_0001.nii']);
if ~exist([projDir,'secondLevelVBM\'],'dir')
    mkdir([projDir,'secondLevelVBM\']);
end
save([projDir,'secondLevelVBM\globVol.mat'],'globVol');
end