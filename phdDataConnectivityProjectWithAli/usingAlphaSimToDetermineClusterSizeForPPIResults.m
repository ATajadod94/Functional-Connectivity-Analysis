function usingAlphaSimToDetermineClusterSizeForPPIResults 
%L_hpc seed
inputDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelPPIAnalysis\L_HPC\fam-nonfam';
input_file = 'spmT_0001.img';
maskDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\masks';
maskName = 'L_vmP_BBxChanged';
clusterSize=claculateClusterSizeUseAlphaSim(inputDir, input_file, maskDir, maskName);

maskName = 'R_vmP_BBxChanged';
clusterSize=claculateClusterSizeUseAlphaSim(inputDir, input_file, maskDir, maskName);


maskName = 'L_TPL_BBxChanged';
clusterSizeLTPL=claculateClusterSizeUseAlphaSim(inputDir, input_file, maskDir, maskName);

maskName = 'R_TPL_BBxChanged';
clusterSizeRTPL=claculateClusterSizeUseAlphaSim(inputDir, input_file, maskDir, maskName);


%R_hpc seed
inputDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelPPIAnalysis\R_HPC\fam-nonfam';
input_file = 'spmT_0001.img';
maskDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\masks';
maskName = 'L_vmP_BBxChanged';
clusterSize=claculateClusterSizeUseAlphaSim(inputDir, input_file, maskDir, maskName);
maskName = 'R_vmP_BBxChanged';
clusterSize=claculateClusterSizeUseAlphaSim(inputDir, input_file, maskDir, maskName);
maskName = 'L_TPL_BBxChanged';
clusterSizeLTPL=claculateClusterSizeUseAlphaSim(inputDir, input_file, maskDir, maskName);
maskName = 'R_TPL_BBxChanged';
clusterSizeRTPL=claculateClusterSizeUseAlphaSim(inputDir, input_file, maskDir, maskName);

%L_PPA seed
inputDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelPPIAnalysis\L_PPA\fam-nonfam';
input_file = 'spmT_0001.img';
maskDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\masks';
maskName = 'L_vmP_BBxChanged';
clusterSize=claculateClusterSizeUseAlphaSim(inputDir, input_file, maskDir, maskName);
maskName = 'R_vmP_BBxChanged';
clusterSize=claculateClusterSizeUseAlphaSim(inputDir, input_file, maskDir, maskName);

%****
maskName = 'L_TPL_BBxChanged';
clusterSizeLTPL=claculateClusterSizeUseAlphaSim(inputDir, input_file, maskDir, maskName);
maskName = 'R_TPL_BBxChanged';
clusterSizeRTPL=claculateClusterSizeUseAlphaSim(inputDir, input_file, maskDir, maskName);

%R_PPA seed
inputDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelPPIAnalysis\R_PPA\fam-nonfam';
input_file = 'spmT_0001.img';
maskDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\masks';
maskName = 'L_vmP_BBxChanged';
clusterSize=claculateClusterSizeUseAlphaSim(inputDir, input_file, maskDir, maskName);
maskName = 'R_vmP_BBxChanged';
clusterSize=claculateClusterSizeUseAlphaSim(inputDir, input_file, maskDir, maskName);
maskName = 'L_TPL_BBxChanged';
clusterSizeLTPL=claculateClusterSizeUseAlphaSim(inputDir, input_file, maskDir, maskName);
maskName = 'R_TPL_BBxChanged';
clusterSizeRTPL=claculateClusterSizeUseAlphaSim(inputDir, input_file, maskDir, maskName);