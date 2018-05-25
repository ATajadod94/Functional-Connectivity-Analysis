function PPI_ROIPLS(seedName,contrastfam,contrastnfam,rois,dosingleROI,doAllROIs)
% rois = { 'L_PPA.img', 'R_PPA.img',...
%     'L_FFA.img', 'R_FFA.img', 'L_TPL.img', 'R_TPL.img',...
%     'L_vmP.img', 'R_vmP.img'};
dataDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelPPIAnalysis\';
saveDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\matlabFunctions\';
spmDirfam=[dataDir,seedName,'\',contrastfam,'\'];
spmDirnfam=[dataDir,seedName,'\',contrastnfam,'\'];
figDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\encodingResubmissionFigures\';

if dosingleROI==1
    yfam = getRawY(spmDirfam,rois);
    ynfam = getRawY(spmDirnfam,rois);
    
    
    % making input data for commend line pls
    
    datamat_list1{1} = cat(1, yfam,ynfam);
    
    
    %%%%% rotated PLS (no predefined contrast) %%%%%
    num_subj_lst = 20;
    num_cond = 2;
    option.method = 1; %rotated
    option.num_perm = 500;
    option.num_boot = 500;
    option.clim = 95;
    addpath C:\Users\Zhongxu\Documents\MATLAB\myMatLabTools\majorNeuroImagingTools\plscmd
    resultRotated = pls_analysis(datamat_list1, num_subj_lst, num_cond,option);
    save([saveDir,'PPI_PLS_AllROIs-',seedName,'-',contrastfam,'-',contrastnfam,'.mat'],'resultRotated ','datamat_list1');
end

if doAllROIs ==1
    datamat_list=[];
    rois = { 'L_PPA.img', 'R_PPA.img',...
        'L_FFA.img', 'R_FFA.img','L_HPC.img', 'R_HPC.img', 'L_TPL.img', 'R_TPL.img',...
        'L_vmP.img', 'R_vmP.img'};
    
    rois1 = { 'L_PPA.img', 'R_PPA.img',...
        'L_FFA.img', 'R_FFA.img','L_HPC.img', 'R_HPC.img', 'L_TMP.img', 'R_TMP.img',...
        'L_vmP.img', 'R_vmP.img'};
    for i = 1:length(rois)
        seedName = rois1{i}
        spmDirfam=[dataDir,seedName(1:5),'\',contrastfam,'\'];
        spmDirnfam=[dataDir,seedName(1:5),'\',contrastnfam,'\'];
        yfamall{i} = getRawY(spmDirfam,rois);
        ynfamall{i} = getRawY(spmDirnfam,rois);
    end
    
    datamat_list{1} = cat(1, cat(2,yfamall{:}),cat(2,ynfamall{:}));
    idex=find(eye(10)==1);
    datamat_list{1}(:,idex)=1;
    %%%%% rotated PLS (no predefined contrast) %%%%%
    num_subj_lst = 20;
    num_cond = 2;
    option.method = 2; %rotated
    option.num_perm = 1000;
    option.num_boot = 1000;
    option.clim = 95;
    option.meancentering_type = 0;
    option.stacked_designdata = [1,-1;1 1]';
    addpath C:\Users\Zhongxu\Documents\MATLAB\myMatLabTools\majorNeuroImagingTools\plscmd
    resultRotatedall = pls_analysis(datamat_list, num_subj_lst, num_cond,option);
    bootscore=reshape(resultRotatedall.boot_result.compare_u(:,1),[10,10]);
    s=figure;
caxis([-3 3]);
    subplot(1,2,1)
    imagesc(bootscore);
    set(gca,'XTick',[1:10]);
    set(gca,'YTick',[1:10]) ;
    %       ['PPA','FFA','HPC','aTPL','vmPFC','PPA','FFA','HPC','aTPL','vmPFC']);
    subplot(1,2,2)
    bootscore(abs(bootscore)<1.65)= 1;
    imagesc(bootscore);
    set(gca,'XTick',[1:10]) ;
    
    set(gca,'YTick',[1:10]) ;
 caxis([-3 3]);
    set(gcf,'Color','w');
    setfigsize(s,8,'Arial',8,'Arial',12,5);
    plot2svg([figDir,'\','PPI_PLS_AllROIs-',contrastfam,'-',contrastnfam,'.svg'],s);
    
    save([saveDir,'PPI_PLS_AllROIs-',contrastfam,'-',contrastnfam,'.mat'],'resultRotatedall','datamat_list');
    
end

%     end
% end
%

%%%%%%%%%%%%%%%%%%
%%%%%%% General Notes %%%%%%%
%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%Rotated PLS%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%*note*: result directory is listed as resultRotated. This is not standard, but simply a change we've made to this specific script.
%If the name of the results directory has not been changed, replacing 'resultRotated' with 'result' should rectify any problems.

%1. mean centered brainscores (condition): resultRotated --> boot_result --> orig_usc
%- columns: LVs
%- rows: condition
%- cell: average brainscore for a specific condition in a specific LV

%2. mean centered brainscores (subject x condition): resultRotated --> boot_result --> orig_usc
%- columns: LVs
%- rows: condition
%- cell: average brainscore for a specific condition in a specific LV


%3. confidence intervals: resultRotated --> boot_result --> ulusc/llusc
%- ulusc refers to the upper limit of the confidence interval
%- llusc refers to the lower limit of the confidence interval
%- column: LVs
%- row: condition
%- cell: confidence interval (distance either above or below usc value) for a specific condition in a specific LV
%- note: ulusc_adj and llusc_adj are the percentile adjusted versions

%4. proportion of variance explained: result --> s
%- resultRotated.s(1)^2/sum(resultRotated.s.^2) % number in parentheses reflects the LV of interest
%- resultRotated.s(1)^2/sum(resultRotated.s.^2) % LV 1
%- resultRotated.s(2)^2/sum(resultRotated.s.^2) % LV 2
%- resultRotated.s(3)^2/sum(resultRotated.s.^2) % LV 3

%5. significance of LV: resultRotated --> perm_result --> sprob
%- columns: should only be one column
%- row: LV (first cell = LV 1, and increases downwards)
%- cells: p-value of specific LV

%6. number of occurences it was replicated using random permutations: result --> perm_result --> sp
%- columns: should only be one column
%- row: LV (first cell = LV 1, and increases downwards)
%- cell: number of times this LV appeared when using random permutations of the data

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%Non-rotated PLS%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%1. brainscores: result --> boot_result --> orig_usc
%- columns: LVs
%- rows: condition
%- cell: average brainscore for a specific condition in a specific LV


%2. confidence intervals: result --> boot_result --> ulusc/llusc
%- ulusc refers to the upper limit of the confidence interval
%- llusc refers to the lower limit of the confidence interval
%- column: LVs
%- row: condition
%- cell: confidence interval (distance either above or below usc value) for a specific condition in a specific LV
%- note: ulusc_adj and llusc_adj are the percentile adjusted versions

%3. proportion of variance explained: result --> s
%- result.s(1)^2/sum(result.s.^2) % number in parentheses reflects the LV of interest
%- result.s(1)^2/sum(result.s.^2) % LV 1
%- result.s(2)^2/sum(result.s.^2) % LV 2
%- result.s(3)^2/sum(result.s.^2) % LV 3

%4. significance of LV: result --> perm_result --> sprob
%- columns: should only be one column
%- row: LV (first cell = LV 1, and increases downwards)
%- cells: p-value of specific LV
%- note: this probability likely does not work for the first LV (if it is one trying to measure the commonality -- e.g., 3 conditions: 1/3 1/3 1/3). It will, however, be fine for other contrasts. If the commonality is important, try to explain using number of occurences during permutations to emphasize it's reliability.

%5. number of occurences it was replicated using random permutations: result --> perm_result --> sp
%- columns: should only be one column
%- row: LV (first cell = LV 1, and increases downwards)
%- cell: number of times this LV appeared when using random permutations of the data
%- note: you typically want low values (e.g., 0), to indicate your difference was not obtained spuriously; however, if again you are interested in commonality, you should want high values. This would indicate that the commonality is reliable across multiple permutations (i.e., the commonality is so large, in terms of explained variance, no matter how you permutate the data, it is still apparent).


function y = getRawY(famDir,rois)
maskDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\masks\';
for i = 1:length(rois)
    marsbar('on');
    contr_model = mardo(fullfile(famDir, 'SPM.mat'));
    contr_model = cd_images(contr_model, 'D:\myStudy\picpairfMRI');
    save_spm(contr_model);
    roiFile = fullfile(maskDir,rois{i});
    o = maroi_image(struct('vol', spm_vol(roiFile)));
    R{i}=maroi(o);
    
    Y = get_marsy(R{i},contr_model,'mean');
    y(:,i)  = summary_data(Y);
end
