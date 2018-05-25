function SecondLevelROIMarsbarAnalysisUsing600ROIs(rootDir)

marsbar('on')

% You might want to define the path to the example data here, as in
% subjroot = '/my/path/somewhere';
maskDir = 'C:\Users\Zhongxu\Downloads\zalesky-uniform_parcellate (1)\uniform_parcellate';
addpath C:\Users\Zhongxu\Documents\MATLAB\myMatLabTools\majorNeuroImagingTools\REST_V1.8_130303
[allrois,head]=rest_ReadNiftiImage([maskDir,'\parcellated_aalCompleteUni.nii']);
% Directory to store (and load) ROIs
temp = zeros(size(allrois));
for iroi = 1:max(max(max(allrois)))
    disp(iroi)

    
    tempa = temp;
    tempa(allrois==iroi)=1;
    head.name = ['C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\matlabFunctions\roi-',num2str(iroi),'.nii'];
    rest_WriteNiftiImage(tempa,head,['C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\matlabFunctions\roi675.nii']);
    
    
    
    % MarsBaR version check
    v = str2num(marsbar('ver'));
    if v < 0.35
        error('Batch script only works for MarsBaR >= 0.35');
    end
    
    % SPM version check. We need this to guess which model directory to use and
    % to get the SPM configured design name.
    spm_ver = spm('ver');
    % sdirname = [spm_ver '_ana'];
    if strcmp(spm_ver, 'SPM99')
        conf_design_name = 'SPMcfg.mat';
    else
        spm_defaults;
        conf_design_name = 'SPM.mat';
    end
    
    % Set up the SPM defaults, just in case
    spm('defaults', 'fmri');
    
    % contrastDirs = dir(rootDir);
    % contrastDirs = contrastDirs(3:end);
    
    contrastDirs = rootDir;
    
    %     contrastDir = fullfile(rootDir, contrastDirs(j).name);
    contrastDir = contrastDirs;
    
    
    % Get SPM model for session 2
%     if exist([contrastDir,'\marsbarROIAnalysis.mat'],'file')
%         continue;
%     end
    contr_model = mardo(fullfile(contrastDir, 'SPM.mat'));
    contr_model = cd_images(contr_model, 'D:\myStudy\picpairfMRI');
    save_spm(contr_model);
    if ~is_spm_estimated(contr_model)
        error(['The spm model has not been estimated. ' ...
            'You may need to run the run_preprocess script']);
    end
    
    
    o = maroi_image(struct('vol', spm_vol(['C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\matlabFunctions\roi675.nii'])));
    R=maroi(o);
    
    %save roi files to check
    %         if j ==1
    %             saveroi(o, fullfile(contrastDir,[rois{i}(1:5),'-roi.mat']));
    %         end
    
    
    
    
    Y = get_marsy(R,contr_model,'mean');
    % y  = summary_data(Y); %to get raw value zhongxu, also can use rex
    xCon = get_contrasts(contr_model);
    E = estimate(contr_model, Y);
    E = set_contrasts(E, xCon);
    % get design betas
    b = betas(E);
    % get stats and stuff for all contrasts into statistics structure
    marsS{iroi} = compute_contrasts(E, 1:length(xCon));
    
end
save([fullfile(contrastDir,'marsbarROIAnalysis675ROIs.mat')], 'marsS');

for i = 1:size(marsS,2)
   pval(i) = marsS{i}.P(1);
   tval(i) = marsS{i}.stat(1);
end
iroiL=zeros(675,1);
iroiR=zeros(675,1);
for iroi = 1:max(max(max(allrois)))
  abc=find(allrois==iroi);
[aa bb cc]=ind2sub(size(allrois),abc);
mnicor = head.mat*([aa bb cc ones(length(aa),1)])';

if mnicor(1,1)>=0
    iroiR(iroi)=iroi;
end

  if mnicor(1,1)<=0
    iroiL(iroi)=iroi;
  end
end
  
% [h crit_p]=fdr_bky(pval ,.05,'yes');
pfdr = mafdr(pval,'BHFDR','TRUE');
tval(pfdr>.05) = 0;

   tempa = temp;
for iroi = 1:max(max(max(allrois)))
    disp(iroi)

    
 
    tempa(allrois==iroi)=tval(iroi);
end
    rest_WriteNiftiImage(tempa,head,[rootDir,'\resultFDR10.nii']);
    
    
    pfdr = mafdr(pval(iroiL~=0),'BHFDR','TRUE');
    find(pfdr<.10)
    
   pfdr = mafdr(pval(iroiR~=0),'BHFDR','TRUE');
    id2=find(pfdr>.05)
    tval(iroiR==0)=0;
    tval(iroiR==0)=0;
    id=find(iroiR~=0);
    tval(id(id2))=0;
    for iroi = 1:max(max(max(allrois)))
    disp(iroi)

    
 
    tempa(allrois==iroi)=tval(iroi);
end
        rest_WriteNiftiImage(tempa,head,[rootDir,'\resultFDR05Rhemi.nii']);

% for roi_no = 1:length(roi_array)
%   roi = roi_array{roi_no};
%   for ss = 1:length(sesses)
%     % Run SPM model configuration, just to show we don't need to do SPM
%     % estimation before using MarsBaR
%     % We only need to do this for the first ROI, because we reuse the
%     % design for each ROI
%     if roi_no == 1
%       model_file{ss} = configure_er_model(subjroot, sesses{ss}, mars_sdir);
%     end
%     D = mardo(model_file{ss});
%     % Extract data
%     Y = get_marsy(roi, D, 'mean');
%     % MarsBaR estimation
%     E = estimate(D, Y);
%     % Add contrast, return model, and contrast index
%     [E Ic] = add_contrasts(E, 'stim_hrf', 'T', [1 0 0]);
%     % Get, store statistics
%     stat_struct(ss) = compute_contrasts(E, Ic);
%     % And fitted time courses
%     [this_tc dt] = event_fitted(E, event_spec, event_duration);
%     % Make fitted time course into ~% signal change
%     tc(:, ss) = this_tc / block_means(E) * 100;
%   end
%   % Show calculated t statistics and contrast values
%   % NB this next line only works when we have only one stat/contrast
%   % value per analysis
%   vals = [ [1 3]; [stat_struct(:).con]; [stat_struct(:).stat]; ];
%   fprintf('Statistics for %s\n', label(roi));
%   fprintf('Session %d; contrast value %5.4f; t stat %5.4f\n', vals);
%   % Show fitted event time courses
%   figure
%   secs = [0:length(tc) - 1] * dt;
%   plot(secs, tc)
%   title(['Time courses for ' label(roi)], 'Interpreter', 'none');
%   xlabel('Seconds')
%   ylabel('% signal change');
%   legend(sesses)
% end


% % Get activation cluster by loading T image
% con_name = 'stim_hrf';
% t_con = get_contrast_by_name(sess2_model, con_name);
% if isempty(t_con)
%   error(['Cannot find the contrast ' con_name ...
% 	' in the design; has it been estimated?']);
% end
% % SPM2 stores contrasts as vols, SPM99 as filenames
% if isstruct(t_con.Vspm)
%   t_con_fname = t_con.Vspm.fname;
% else
%   t_con_fname = t_con.Vspm;
% end
% % SPM5 designs can have full paths in their Vspm.fnames
% t_pth = fileparts(t_con_fname);
% if isempty(t_pth)
%     t_con_fname = fullfile(sess2_model_dir, t_con_fname);
% end
% if ~exist(t_con_fname)
%   error(['Cannot find t image ' t_con_fname ...
% 	 '; has it been estimated?']);
% end
%
% % Get t threshold of uncorrected p < 0.05
% p_thresh = 0.05;
% erdf = error_df(sess2_model);
% t_thresh = spm_invTcdf(1-p_thresh, erdf);
%
% % get all voxels from t image above threshold
% V = spm_vol(fullfile('C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\masks','allmasks.hdr'));
% img = spm_read_vols(V);
% tmp = find(img(:) > .0001);
% img = img(tmp);
% XYZ = mars_utils('e2xyz', tmp, V.dim(1:3));
%
% % make into clusters, find max cluster
% cluster_nos = spm_clusters(XYZ);
% [mx max_index] = max(cluster_nos);
% max_cluster = cluster_nos(max_index);
% cluster_XYZ = XYZ(:, cluster_nos >0) %= max_cluster);
%
% % Make ROI from max cluster
% act_roi = maroi_pointlist(struct('XYZ', cluster_XYZ, ...
% 				 'mat', V.mat), 'vox');
%
% % Make box ROI to do trimming
% box_limits = [-20 20; -66 -106; -20 7]';
% box_centre = mean(box_limits);
% box_widths = abs(diff(box_limits));
% box_roi = maroi_box(struct('centre', box_centre, ...
% 			   'widths', box_widths));
%
% % Combine for trimmed ROI
% trim_stim = box_roi & act_roi;
%
% % Give it a name
% trim_stim = label(trim_stim, 'batch_trim_stim');
%
% % save ROI to MarsBaR ROI file, in current directory, just to show how
% saveroi(act_roi, fullfile('batch_trim_stim_roi.mat'));
%
% % Save as image
% save_as_image(act_roi, fullfile('batch_trim_stim.img'));
%
% % We will do estimation for the trimmed functional ROI, and for two
% % anatomical ROIs
% bg_L_name = fullfile(roi_dir, 'MNI_Putamen_L_roi.mat');
% bg_R_name = fullfile(roi_dir, 'MNI_Putamen_R_roi.mat');
% roi_array{1} = trim_stim;
% roi_array{2} = maroi(bg_L_name);
% roi_array{3} = maroi(bg_R_name);
%
% % MarsBaR estimation for sessions 1 and 3 follows
% pwd_orig = pwd;
% sesses = {'sess1', 'sess3'};
%
% % event specification for getting fitted event time-courses
% % A bit silly here, as we only have one session per model and one event type
% event_session_no = 1;
% event_type_no = 1;
% event_spec = [event_session_no; event_type_no];
% event_duration = 0; % default SPM event duration
%
% clear model_file
% for roi_no = 1:length(roi_array)
%   roi = roi_array{roi_no};
%   for ss = 1:length(sesses)
%     % Run SPM model configuration, just to show we don't need to do SPM
%     % estimation before using MarsBaR
%     % We only need to do this for the first ROI, because we reuse the
%     % design for each ROI
%     if roi_no == 1
%       model_file{ss} = configure_er_model(subjroot, sesses{ss}, mars_sdir);
%     end
%     D = mardo(model_file{ss});
%     % Extract data
%     Y = get_marsy(roi, D, 'mean');
%     % MarsBaR estimation
%     E = estimate(D, Y);
%     % Add contrast, return model, and contrast index
%     [E Ic] = add_contrasts(E, 'stim_hrf', 'T', [1 0 0]);
%     % Get, store statistics
%     stat_struct(ss) = compute_contrasts(E, Ic);
%     % And fitted time courses
%     [this_tc dt] = event_fitted(E, event_spec, event_duration);
%     % Make fitted time course into ~% signal change
%     tc(:, ss) = this_tc / block_means(E) * 100;
%   end
%   % Show calculated t statistics and contrast values
%   % NB this next line only works when we have only one stat/contrast
%   % value per analysis
%   vals = [ [1 3]; [stat_struct(:).con]; [stat_struct(:).stat]; ];
%   fprintf('Statistics for %s\n', label(roi));
%   fprintf('Session %d; contrast value %5.4f; t stat %5.4f\n', vals);
%   % Show fitted event time courses
%   figure
%   secs = [0:length(tc) - 1] * dt;
%   plot(secs, tc)
%   title(['Time courses for ' label(roi)], 'Interpreter', 'none');
%   xlabel('Seconds')
%   ylabel('% signal change');
%   legend(sesses)
% end
