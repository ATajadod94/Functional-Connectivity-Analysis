load('C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\postFam_NonFam_EncodingCorr_5ROI_defense\P_V_Correlations_L-R.mat');
load('C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\EncodingCorr_5ROI_originalData_defense\P_V_Correlations_L-R.mat');

for i = 1:10
    for j=1:10
    [a b,c d]=ttest(squeeze(postFamCorrGrpLR(i,j,:)),...
        squeeze(famCorrGrpLR(i,j,:)));
     [e f g h]=ttest(squeeze(postNonFamCorrGrpLR(i,j,:)),...
        squeeze(nonfamCorrGrpLR(i,j,:))); 
    
    pFam(i,j)=b;
    pNFam(i,j)=f;
   tFam(i,j)=d.tstat;
   tNFam(i,j) = h.tstat;
  
    end
end
tFam(find(pFam >.005))=0;
figure;
imagesc(tFam);
set(gcf, 'Color', 'w');
title('Post-encoding conn changes Fam');


idd=find(pNFam >.005);
tNFam(idd)=0;
figure;
imagesc(tNFam);
set(gcf, 'Color', 'w');
title('Post-encoding conn changes NonFam');

tfamnfam=cat(2,tFam,tNFam);
figure;
imagesc(tfamnfam);
set(gcf, 'Color', 'w');
title('Post-encoding conn changes');