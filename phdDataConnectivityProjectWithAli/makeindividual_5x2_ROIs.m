function makeindividual_5x2_ROIs
% using encoding picpair - scramble to make encoding rois for vmpfc,hpc tpl

maskDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\masks\';


[lvmp, MHead] = rest_ReadNiftiImage([maskDir,'L_vmP.img']);
[rvmp, MHead] = rest_ReadNiftiImage([maskDir,'R_vmP.img']);
[ltpl, MHead] = rest_ReadNiftiImage([maskDir,'L_TPL.img']);
[rtpl, MHead] = rest_ReadNiftiImage([maskDir,'R_TPL.img']);
[lhpc, MHead] = rest_ReadNiftiImage([maskDir,'L_HPC.img']);
[rhpc, MHead] = rest_ReadNiftiImage([maskDir,'R_HPC.img']);
lvmp = logical(lvmp);
rvmp = logical(rvmp);
ltpl = logical(ltpl);
rtpl = logical(rtpl);
lhpc = logical(lhpc);
rhpc = logical(rhpc);


lvmp = find(lvmp==1);
rvmp = find(rvmp==1);
ltpl = find(ltpl==1);
rtpl = find(rtpl==1);
lhpc = find(lhpc==1);
rhpc = find(rhpc==1);

for subj = 1:20
    rootDir = ['D:\myStudy\picpairfMRI\s',sprintf('%03d', subj),'\'];
    xSPM.swd       = [rootDir,'encoding\analysis\'];
    xSPM.Ic    = 1; xSPM.n = 1; xSPM.u  = 0.05; xSPM.Im  =[];xSPM.thresDesc = 'none'; xSPM.title = '';
    xSPM.k     = 0; xSPM.units     = {'mm' 'mm' 'mm'};
    [SPM xSPM] = spm_getSPM(xSPM);
    % [hReg, xSPM, SPM] = spm_results_ui('setup', xSPM);
    spm_write_filtered(xSPM.Z, xSPM.XYZ, xSPM.DIM, xSPM.M,'thresholdMask','encoding05ROIBox799568');
    convertROIMasks([xSPM.swd,'encoding05ROIBox799568.img'],[xSPM.swd,'encoding05ROIBox9110991.img'],[maskDir,'L_vmP.img']);
    [allVox, MHeadAll] = rest_ReadNiftiImage([xSPM.swd,'encoding05ROIBox9110991.img']);
getOverlappedIndividualMast(lvmp, allVox,MHeadAll, 'lvmp',xSPM.swd);
getOverlappedIndividualMast(rvmp, allVox,MHeadAll, 'rvmp',xSPM.swd);
getOverlappedIndividualMast(ltpl, allVox,MHeadAll, 'ltpl',xSPM.swd);
getOverlappedIndividualMast(rtpl, allVox,MHeadAll, 'rtpl',xSPM.swd);
getOverlappedIndividualMast(lhpc, allVox,MHeadAll, 'lhpc',xSPM.swd);
getOverlappedIndividualMast(rhpc, allVox,MHeadAll, 'rhpc',xSPM.swd);

    % PPA and FFA rois have been extract manually for each participant, but
    % need to change the box size to fit the roi timeseries roi extraction
    % dimension
    
    faceHouseDir=[rootDir,'localization\'];
    
    convertROIMasks([faceHouseDir,'L_PPA.img'],[faceHouseDir,'L_PPABox9110991.img'],[maskDir,'L_vmP.img']);
    convertROIMasks([faceHouseDir,'R_PPA.img'],[faceHouseDir,'R_PPABox9110991.img'],[maskDir,'L_vmP.img']);
    
    convertROIMasks([faceHouseDir,'L_FFA.img'],[faceHouseDir,'L_FFABox9110991.img'],[maskDir,'L_vmP.img']);
    convertROIMasks([faceHouseDir,'R_FFA.img'],[faceHouseDir,'R_FFABox9110991.img'],[maskDir,'L_vmP.img']);
    
end


function idOverlap = getOverlappedIndividualMast(lvmp, allVox,MHeadAll, roiName,saveDir)
emptyVox = allVox;
emptyVox = logical(emptyVox.*0);
    idOverlap = find(allVox(lvmp)==1);
emptyVox(lvmp(idOverlap))=1;
numVox = length(idOverlap)
rest_WriteNiftiImage(emptyVox,MHeadAll,[saveDir,roiName,'-indivRoi.img']);