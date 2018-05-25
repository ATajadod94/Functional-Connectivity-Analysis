function clusterSize=claculateClusterSizeUseAlphaSim(inputDir, input_file, maskDir, maskName,outDir)
if nargin<5
outDir = inputDir;
end
outname = ['alphasim-KWLZ-',maskName];
mask_file = fullfile(maskDir,[maskName,'.img']);
[Statistical_data VoxelSize Header]=rest_readfile(fullfile(inputDir,input_file));
  headinfo=Header.descrip; 
            testFlag='T';
            Tstart=strfind(headinfo,'{T_[')+length('{T_[');
            Tend=strfind(headinfo,']}')-1;
            testDf = str2num(headinfo(Tstart:Tend));
            testDf2=0;
[Z_map P] = rest_TFRtoZ(Statistical_data,'DO NOT OUTPUT IMAGE',testFlag,testDf,testDf2,Header);
DOF=100;   
[dLh,resels,FWHM, nVoxels]=rest_Smoothest(Z_map, mask_file, DOF, VoxelSize);
rmm=4;
pthr = .005;
iter = 10000;
pthrCluster = .05;
clusterSize = rest_AlphaSimWithOutput_ZX_KW(mask_file,outDir,outname,rmm,FWHM,pthr,iter, pthrCluster);


