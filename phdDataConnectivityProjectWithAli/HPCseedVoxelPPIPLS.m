function resultRotated = HPCseedVoxelPPIPLS(seedName,contrastfam,contrastnfam,subjs)
saveDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\matlabFunctions\';

maskimg = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelPPIAnalysis\L_HPC\fam1\mask.img';
[maskdata maskheader]=rest_ReadNiftiImage(maskimg);
for subjID=subjs
dataDir =['D:\myStudy\picpairfMRI\s', sprintf('%03d',subjID),...
    '\encoding\analysis\PPI_',seedName,'\'];
contrastNameFam = ['con_PPI_',contrastfam,'_s',sprintf('%03d',subjID),'.img'];
contrastNameNFam = ['con_PPI_',contrastnfam,'_s',sprintf('%03d',subjID),'.img'];
[Datafam, Head] = rest_ReadNiftiImage([dataDir,contrastNameFam]);
[Datanfam, Head] = rest_ReadNiftiImage([dataDir,contrastNameNFam]);
fam(subjID,:)=Datafam(maskdata==1)';
nfam(subjID,:)=Datanfam(maskdata==1)';
end
datamat_list{1} = cat(1, fam,nfam);

% specify other parameter for pls analysis
addpath C:\Users\Zhongxu\Documents\MATLAB\myMatLabTools\majorNeuroImagingTools\plscmd

%%%%% rotated PLS (no predefined contrast) %%%%%
num_subj_lst = 20;
num_cond = 2;
option.method = 1; %rotated
option.num_perm = 500;
option.num_boot = 500;
option.clim = 95;
    option.meancentering_type = 0;

resultRotated = pls_analysis(datamat_list, num_subj_lst, num_cond,option);


figDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\encodingResubmissionFigures\';
maskdata=double(maskdata);
 maskdata(find(maskdata==1))= resultRotated.boot_result.compare_u(:,1) ; % replace the original data with the PLS brain contrast data
rest_WriteNiftiImage(maskdata,maskheader,[figDir,'PPI_PLS_',seedName,'_',contrastfam,'_',contrastnfam,'.img']);
save([saveDir,'PPI_PLS_',seedName,'_',contrastfam,'_',contrastnfam,'.mat'],'resultRotated');

