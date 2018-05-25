addpath('C:\Users\Zhongxu\Documents\MATLAB\myMatLabTools\Corr_toolbox_v2');
addpath('C:\Users\Zhongxu\Documents\MATLAB\myMatLabTools\Corr_toolbox_v2\LIBRA');
% plot lffa vs rHPC correlation in postfam nonfam rest
outpath = 'C:\Users\Zhongxu\Dropbox\picpair\PicparBehavioralmanuscript\postEncodingfMRIPub\figures\';
load(['C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\matlabFunctions\',...
    'performanceDataConcatenated.mat']);
rootDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\';
[subjInfo a]=xlsread([rootDir,'matlabFunctions\picpairSubjInfo.xlsx']);
age = subjInfo(:,2);
gender  = subjInfo(:,3);               
%postfam-nonfam l hpc see-to-voxel brain net figure
 inputDir = 'D:\myStudy\picpairfMRI\postEncodingRest\conn_restingConnectivity\results\secondlevel\ANALYSIS_01.SUBJECT_EFFECTS_subjAll.CONDITIONS_postFam(1.0).postNonFam(-1.0)\R_aHC_1_1\';
dataTImage = [inputDir, 'spmT_0001.img'];
% p=.005 threshold
savefigName = 'postfam-nonfam-AnteriorHPC-r-005';
savefigNote = [dataTImage,'___',savefigName];
outpath = 'C:\Users\Zhongxu\Dropbox\picpair\PicparBehavioralmanuscript\postEncodingfMRIPub\figures\';

outDir = outpath;
makeBrainNetSurfacePlot(dataTImage,savefigName,savefigNote,outDir,...
                     2.861, 5,'MediumView', 10); %'MediumView'  
                 
                 
 inputDir = 'D:\myStudy\picpairfMRI\postEncodingRest\conn_restingConnectivity\results\secondlevel\ANALYSIS_01.SUBJECT_EFFECTS_subjAll.CONDITIONS_postFam(1.0).postNonFam(-1.0)\R_mHC_1_1\';
dataTImage = [inputDir, 'spmT_0001.img'];
% p=.005 threshold
savefigName = 'postfam-nonfam-MiddleHPC-r-005';
savefigNote = [dataTImage,'___',savefigName];
outpath = 'C:\Users\Zhongxu\Dropbox\picpair\PicparBehavioralmanuscript\postEncodingfMRIPub\figures\';

outDir = outpath;
makeBrainNetSurfacePlot(dataTImage,savefigName,savefigNote,outDir,...
                     2.861, 5,'MediumView', 10); %'MediumView'                  
                 
                 
                 
 inputDir = 'D:\myStudy\picpairfMRI\postEncodingRest\conn_restingConnectivity\results\secondlevel\ANALYSIS_01.SUBJECT_EFFECTS_subjAll.CONDITIONS_postFam(1.0).postNonFam(-1.0)\R_pHC_1_1\';
dataTImage = [inputDir, 'spmT_0001.img'];
% p=.005 threshold
savefigName = 'postfam-nonfam-PosteriorHPC-r-005';
savefigNote = [dataTImage,'___',savefigName];
outpath = 'C:\Users\Zhongxu\Dropbox\picpair\PicparBehavioralmanuscript\postEncodingfMRIPub\figures\';

outDir = outpath;
makeBrainNetSurfacePlot(dataTImage,savefigName,savefigNote,outDir,...
                     2.861, 5,'MediumView', 10); %'MediumView'                  
                 
                 
                                  
        
                 
                 
%postfam lr hpc see-to-voxel predict fampairmem brain net figure
 inputDir = 'D:\myStudy\picpairfMRI\postEncodingRest\conn_restingConnectivity\results\secondlevel\ANALYSIS_01.SUBJECT_EFFECTS_subjAll(0.0).famIntactPairMemNoOutliers(1.0).CONDITIONS_postFam\R_aHC_1_1\';
dataTImage = [inputDir, 'spmT_0001.img'];
% p=.005 threshold
savefigName = 'rAnteriorHPC-postfam-predict-fampairmem005';
savefigNote = [dataTImage,'___',savefigName];
outpath = 'C:\Users\Zhongxu\Dropbox\picpair\PicparBehavioralmanuscript\postEncodingfMRIPub\figures\';

outDir = outpath;
makeBrainNetSurfacePlot(dataTImage,savefigName,savefigNote,outDir,...
                     2.878, 4,'MediumView', 10); %'MediumView'
                 
                 
                 
%postfam lr hpc see-to-voxel predict fampairmem brain net figure
 inputDir = 'D:\myStudy\picpairfMRI\postEncodingRest\conn_restingConnectivity\results\secondlevel\ANALYSIS_01.SUBJECT_EFFECTS_subjAll(0.0).famIntactPairMemNoOutliers(1.0).CONDITIONS_postFam\R_mHC_1_1\';
dataTImage = [inputDir, 'spmT_0001.img'];
% p=.005 threshold
savefigName = 'rMiddleHPC-postfam-predict-fampairmem005';
savefigNote = [dataTImage,'___',savefigName];
outpath = 'C:\Users\Zhongxu\Dropbox\picpair\PicparBehavioralmanuscript\postEncodingfMRIPub\figures\';

outDir = outpath;
makeBrainNetSurfacePlot(dataTImage,savefigName,savefigNote,outDir,...
                     2.878, 4,'MediumView', 10); %'MediumView'
                                  
                 
                 
%postfam lr hpc see-to-voxel predict fampairmem brain net figure
 inputDir = 'D:\myStudy\picpairfMRI\postEncodingRest\conn_restingConnectivity\results\secondlevel\ANALYSIS_01.SUBJECT_EFFECTS_subjAll(0.0).famIntactPairMemNoOutliers(1.0).CONDITIONS_postFam\R_pHC_1_1\';
dataTImage = [inputDir, 'spmT_0001.img'];
% p=.005 threshold
savefigName = 'rPosteriorHPC-postfam-predict-fampairmem005';
savefigNote = [dataTImage,'___',savefigName];
outpath = 'C:\Users\Zhongxu\Dropbox\picpair\PicparBehavioralmanuscript\postEncodingfMRIPub\figures\';

outDir = outpath;
makeBrainNetSurfacePlot(dataTImage,savefigName,savefigNote,outDir,...
                     2.878, 4,'MediumView', 10); %'MediumView'
                                 
                 
                 
                 
               
    
                 
%postfanonfam r hpc see-to-voxel predict fampairmem brain net figure
 inputDir = 'D:\myStudy\picpairfMRI\postEncodingRest\conn_restingConnectivity\results\secondlevel\ANALYSIS_01.SUBJECT_EFFECTS_subjAll(0.0).NfamIntactPairMemNoOutlier(1.0).CONDITIONS_postNonFam\R_aHC_1_1\';
dataTImage = [inputDir, 'spmT_0001.img'];
% p=.005 threshold
savefigName = 'rAnteriorHPC-postNfam-predict-Nfampairmem005';
savefigNote = [dataTImage,'___',savefigName];
outpath = 'C:\Users\Zhongxu\Dropbox\picpair\PicparBehavioralmanuscript\postEncodingfMRIPub\figures\';

outDir = outpath;
makeBrainNetSurfacePlot(dataTImage,savefigName,savefigNote,outDir,...
                     2.878, 4,'MediumView', 10); %'MediumView'                 
                 
                 
%postfanonfam r hpc see-to-voxel predict fampairmem brain net figure
 inputDir = 'D:\myStudy\picpairfMRI\postEncodingRest\conn_restingConnectivity\results\secondlevel\ANALYSIS_01.SUBJECT_EFFECTS_subjAll(0.0).NfamIntactPairMemNoOutlier(1.0).CONDITIONS_postNonFam\R_mHC_1_1\';
dataTImage = [inputDir, 'spmT_0001.img'];
% p=.005 threshold
savefigName = 'rMiddleHPC-postNfam-predict-Nfampairmem005';
savefigNote = [dataTImage,'___',savefigName];
outpath = 'C:\Users\Zhongxu\Dropbox\picpair\PicparBehavioralmanuscript\postEncodingfMRIPub\figures\';

outDir = outpath;
makeBrainNetSurfacePlot(dataTImage,savefigName,savefigNote,outDir,...
                     2.878, 4,'MediumView', 10); %'MediumView'    
                 
%postfanonfam r hpc see-to-voxel predict fampairmem brain net figure
 inputDir = 'D:\myStudy\picpairfMRI\postEncodingRest\conn_restingConnectivity\results\secondlevel\ANALYSIS_01.SUBJECT_EFFECTS_subjAll(0.0).NfamIntactPairMemNoOutlier(1.0).CONDITIONS_postNonFam\R_pHC_1_1\';
dataTImage = [inputDir, 'spmT_0001.img'];
% p=.005 threshold
savefigName = 'rPosteriorHPC-postNfam-predict-Nfampairmem005';
savefigNote = [dataTImage,'___',savefigName];
outpath = 'C:\Users\Zhongxu\Dropbox\picpair\PicparBehavioralmanuscript\postEncodingfMRIPub\figures\';

outDir = outpath;
makeBrainNetSurfacePlot(dataTImage,savefigName,savefigNote,outDir,...
                     2.878, 4,'MediumView', 10); %'MediumView'                 
                              
                 