function usingAlphaSimToDetermineClusterSizeForfacehoseVsScramble 
%L_hpc seed
inputDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelAnalysis\picEffect_Pic-Scramble';
input_file = 'spmT_0001.img';
maskDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\masks';

maskName = 'L_vmP_BBxChanged';
clusterSizeLvmP=claculateClusterSizeUseAlphaSim(inputDir, input_file, maskDir, maskName);

maskName = 'R_vmP_BBxChanged';
clusterSizeLvmP=claculateClusterSizeUseAlphaSim(inputDir, input_file, maskDir, maskName);

maskName = 'L_TPL_BBxChanged';
clusterSizeLTPL=claculateClusterSizeUseAlphaSim(inputDir, input_file, maskDir, maskName);

maskName = 'R_TPL_BBxChanged';
clusterSizeRTPL=claculateClusterSizeUseAlphaSim(inputDir, input_file, maskDir, maskName);

