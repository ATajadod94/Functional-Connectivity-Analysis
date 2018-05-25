MaskDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\masks';
inputMaskName = 'R_vmP.img';
inputMask = fullfile(MaskDir,inputMaskName);
outputMask = fullfile(MaskDir,[inputMaskName(1:(end-4)),'_BBxChanged.img']);
templateImage = fullfile(MaskDir,'L_mHC.img');
convertROIMasks(inputMask,outputMask,templateImage)
