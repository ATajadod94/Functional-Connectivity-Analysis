function subjVox = similairty_deleteOutsideVoxel_individualROIs(betaTimeSeries)
if nargin <1
    betaTimeSeries=0;
end
outDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\similarityAnalysis\corrMatrixData_EncodingResting\';

% check voxels that don't have data (voxels of the standard mask that are outside the individual's brain)
rootDir='C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\similarityAnalysis\';
for subj = 1:20
    disp(subj)
[lvmp, rvmp, ltpl, rtpl, lhpc, rhpc, lppa, rppa, lffa, rffa]=getIndividualROIs(subj);
    

allvox=cat(1,lvmp, rvmp, ltpl, rtpl, lhpc, rhpc, lppa, rppa, lffa, rffa);
   
    
    
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
        load([rootDir,'restingVoxelTimeSeriesData\subject-', sprintf('%03d',subj),...
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
    
   clear allvox;
   clear includedVox;
end
if betaTimeSeries ==1
    save([outDir,'subjVoxForEachROIBetaTimeSeries.mat'],'subjVox');
else
    save([outDir,'subjVoxForEachROI.mat'],'subjVox');
end
%
% newrois(newrois==1)=0;
% newrois(allvox)=1;
% rest_WriteNiftiImage(newrois,MHead,'newrois.img')


