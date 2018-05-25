function subjVox = similairty_deleteOutsideVoxel(betaTimeSeries)
if nargin <1
    betaTimeSeries=0;
end
maskDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\masks\';
maskDir1 = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelAnalysis\picEffect_Pic-Scramble\';

[lvmp, MHead] = rest_ReadNiftiImage([maskDir1,'L_vmP.img']);
[rvmp, MHead] = rest_ReadNiftiImage([maskDir1,'R_vmP.img']);
[ltpl, MHead] = rest_ReadNiftiImage([maskDir1,'L_TMP.img']);
[rtpl, MHead] = rest_ReadNiftiImage([maskDir1,'R_TMP.img']);
[lhpc, MHead] = rest_ReadNiftiImage([maskDir1,'L_HPC.img']);
[rhpc, MHead] = rest_ReadNiftiImage([maskDir1,'R_HPC.img']);
[lppa, MHead] = rest_ReadNiftiImage([maskDir,'L_PPA.img']);
[rppa, MHead] = rest_ReadNiftiImage([maskDir,'R_PPA.img']);
[lffa, MHead] = rest_ReadNiftiImage([maskDir,'L_FFA.img']);
[rffa, MHead] = rest_ReadNiftiImage([maskDir,'R_FFA.img']);

lvmp = logical(lvmp);
rvmp = logical(rvmp);
ltpl = logical(ltpl);
rtpl = logical(rtpl);
lhpc = logical(lhpc);
rhpc = logical(rhpc);
lppa = logical(lppa);
rppa = logical(rppa);
lffa = logical(lffa);
rffa = logical(rffa);

lvmp = find(lvmp==1);
rvmp = find(rvmp==1);
ltpl = find(ltpl==1);
rtpl = find(rtpl==1);
lhpc = find(lhpc==1);
rhpc = find(rhpc==1);
lppa = find(lppa==1);
rppa = find(rppa==1);
lffa = find(lffa==1);
rffa = find(rffa==1);
allvox=cat(1,lvmp, rvmp, ltpl, rtpl, lhpc, rhpc, lppa, rppa, lffa, rffa);


% check voxels that don't have data (voxels of the standard mask that are outside the individual's brain)
rootDir='C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\similarityAnalysis\';
for subj = 1:20
    
    %dataset 1 - encoding time series
    for cond = 1:4
        if betaTimeSeries ==1
            load([rootDir,'encodingBetaTimeSeriesData\subject-', sprintf('%03d',subj),...
                '-condition-', sprintf('%03d',cond*2-1),'.mat']);
        else
            load([rootDir,'encodingTimeSeriesData\subject-', sprintf('%03d',subj),...
                '-condition-', sprintf('%03d',cond),'.mat']);
        end
        
        emptyVoxEncoding{subj,cond} = find(mean(roiTimeSeriesData,1)==0);
    end
    %dataset 2 - resting
    for cond = 1:3
        load([rootDir,'restingTimeSeriesData\subject-', sprintf('%03d',subj),...
            '-condition-', sprintf('%03d',cond),'.mat']);
        emptyVoxResting{subj,cond} = find(mean(roiTimeSeriesData,1)==0);
        
    end
    subjVox(subj).deletedVox= unique(cat(2,emptyVoxResting{subj,:},emptyVoxEncoding{subj,:}));
    includedVox = allvox;
    includedVox(unique([subjVox(subj).deletedVox]))=[];
    subjVox(subj).includedVox = includedVox;
    subjVox(subj).allVox = allvox;
    
    [temp itemp subjVox(subj).idxlvmp] = intersect(lvmp, subjVox(subj).includedVox);
    [temp itemp subjVox(subj).idxrvmp] = intersect(rvmp, subjVox(subj).includedVox);
    
    [temp itemp subjVox(subj).idxltpl] = intersect(ltpl, subjVox(subj).includedVox);
    [temp itemp subjVox(subj).idxrtpl] = intersect(rtpl, subjVox(subj).includedVox);
    
    [temp itemp subjVox(subj).idxlhpc] = intersect(lhpc, subjVox(subj).includedVox);
    [temp itemp subjVox(subj).idxrhpc] = intersect(rhpc, subjVox(subj).includedVox);
    
    [temp itemp subjVox(subj).idxlppa] = intersect(lppa, subjVox(subj).includedVox);
    [temp itemp subjVox(subj).idxrppa] = intersect(rppa, subjVox(subj).includedVox);
    
    [temp itemp subjVox(subj).idxlffa] = intersect(lffa, subjVox(subj).includedVox);
    [temp itemp subjVox(subj).idxrffa] = intersect(rffa, subjVox(subj).includedVox);
    
    
end
 outDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\similarityAnalysis\corrMatrixData_EncodingResting\'; 

if betaTimeSeries ==1
    save([outDir,'subjVoxForEachROIBetaTimeSeries.mat'],'subjVox');
else
    save([outDir,'subjVoxForEachROI.mat'],'subjVox');
end
%
% newrois(newrois==1)=0;
% newrois(allvox)=1;
% rest_WriteNiftiImage(newrois,MHead,'newrois.img')


