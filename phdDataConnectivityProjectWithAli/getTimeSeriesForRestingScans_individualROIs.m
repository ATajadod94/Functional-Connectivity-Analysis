function getTimeSeriesForRestingScans_individualROIs

dataDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\similarityAnalysis\restingProcessedData\';
outDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\similarityAnalysis\restingVoxelTimeSeriesData\';

for isubj = 3:20
        disp(isubj)
[lvmp, rvmp, ltpl, rtpl, lhpc, rhpc, lppa, rppa, lffa, rffa]=getIndividualROIs(isubj);
    
    for icond = 1:5
        dataFileName = ['niftiDATA_Subject',sprintf('%03d',isubj),'_Condition',sprintf('%03d',icond),'.nii'];
        [Data, Head] = rest_ReadNiftiImage([dataDir,dataFileName]);
               
        for tr = 1:size(Data,4)
            a = Data(:,:,:,tr);
            roiTimeSeriesData(tr,:) = a(cat(1,lvmp, rvmp, ltpl, rtpl, lhpc, rhpc, lppa, rppa, lffa, rffa));
        end
        
        newName = ['subject-',sprintf('%03d',isubj),'-condition-',sprintf('%03d',icond),'.mat'];
        save([outDir,newName],'roiTimeSeriesData');
        
        clear roiTimeSeriesData;
        clear a;
        
        if icond==1            
            save([outDir,'roiInfo-',num2str(isubj),'.mat'],'lvmp','rvmp','ltpl','rtpl','lhpc','rhpc',...
                'lppa','rppa','lffa','rffa');
        end
    end
end





% roiCorrData = corrcoef(roiTimeSeriesData);
% roiCorrData = sparse(tril(roiCorrData,-1));
% 
% 
% points = randn(5,5)
% pp = tril(points-1)
% II=find(pp~=0)
% pp(II)
% 
% 
% MData(234829)
% data1=zeros(size(MData));
% data1(maskvoxels)=1;
% max(max(max(MData)))
