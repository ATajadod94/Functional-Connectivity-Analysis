function bootstrappingMediationEffects
dataDirc ='C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelPmodAnalysis\pca-continuous\fam12\';
dataDircp ='C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelPmodAnalysis\performancepca_continuous\pca-fam12\';
addpath C:\Users\Zhongxu\Documents\MATLAB\myMatLabTools\boostrapFromDelormeMatlabFileExchange
addpath C:\Users\Zhongxu\Downloads\MediationToolbox-master(1)\MediationToolbox-master\mediation_toolbox

yc=getRawY(dataDirc);
ycp = getRawY(dataDircp);
%using delorme bootstrap pval
[t df pvals] = statcond({yc' ycp'}, 'mode', 'bootstrap', 'naccu', 1000); 
fdr(pvals)
[t1 df1 pvals1] = statcond({yc' ycp'}); 
fdr(pvals1);
%using Tor Wager bias-corrected bootstrap pval
[pvalfdrPrio pvalPrio zvalPrio] = getbiasecorrectedPval(yc, ycp);

dataDirc ='C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelPmodAnalysis\performance-UsedinCereCor\Fam12\';
dataDircp ='C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelPmodAnalysis\performancepca_continuous\performance-fam12\';
yc=getRawY(dataDirc);
ycp = getRawY(dataDircp);
[pvalfdrSubseqM pvalSubseqM zvalSubseqM] = getbiasecorrectedPval(yc, ycp);
save(['C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\matlabFunctions\',...
'bootstrappingMeditionCerebralRevision.mat'],'pvalfdrPrio','pvalPrio','zvalPrio',...
'pvalfdrSubseqM', 'pvalSubseqM', 'zvalSubseqM');

function [pvalfdr pval zval] = getbiasecorrectedPval(yc, ycp)
for i = 1:10
data1=yc(:,i)-ycp(:,i);
 stat = mean(data1);
 bootstat = bootstrp(1000, @mean, data1);
[p, z] = bootbca_pval(0, @mean, bootstat,stat,data1);
zval(i)=z;
pval(i)=p;
end
pvalfdr = fdr(pval)

function y=getRawY(dataDir)
addpath C:\Users\Zhongxu\Documents\MATLAB\myMatLabTools\majorNeuroImagingTools\marsbar-0.43
maskDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\masks\';
rois = { 'L_PPA.img', 'R_PPA.img',...
    'L_FFA.img', 'R_FFA.img','L_HPC.img', 'R_HPC.img', 'L_TPL.img', 'R_TPL.img',...
    'L_vmP.img', 'R_vmP.img'};
for i = 1:10
    marsbar('on');
    contr_model = mardo(fullfile(dataDir, 'SPM.mat'));
%     contr_model = cd_images(contr_model, 'D:\myStudy\picpairfMRI');
%     save_spm(contr_model);
    roiFile = fullfile(maskDir,rois{i});
    o = maroi_image(struct('vol', spm_vol(roiFile)));
    R{i}=maroi(o);
    
    Y = get_marsy(R{i},contr_model,'mean');
    y(:,i)  = summary_data(Y);
end

