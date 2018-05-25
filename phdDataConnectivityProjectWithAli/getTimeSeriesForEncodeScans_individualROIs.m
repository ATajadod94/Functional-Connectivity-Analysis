function getTimeSeriesForEncodeScans_individualROIs
dataDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\similarityAnalysis\encodingPreprocessed\conn_eoncoding_only4Runs\results\preprocessing\';

outDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\similarityAnalysis\encodingTimeSeriesData\';


for isubj = 1:20
    disp(isubj)
[lvmp, rvmp, ltpl, rtpl, lhpc, rhpc, lppa, rppa, lffa, rffa]=getIndividualROIs(isubj);
    
    for icond = 1:4
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


