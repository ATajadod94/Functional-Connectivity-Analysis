function corrMatrixFrom675Seeds
% [data header]=rest_ReadNiftiImage(['C:\Users\Zhongxu\Downloads\compact_parcellate\compact_parcellate\parcellated_aalComplete.nii']);
% [c ia ib]= unique(data);

[maskData maskHeader]=rest_ReadNiftiImage(['C:\Users\Zhongxu\Downloads\uniform_parcellate (1)\uniform_parcellate\parcellated_aalCompleteUni.nii']);
[c ia ib]= unique(maskData);
dataDir = 'D:\myStudy\picpairfMRI\postEncodingRest\conn_restingConnectivity\results\preprocessing\';

for subj=1:20
    for cond=2:3
        [data header]= rest_ReadNiftiImage([dataDir, 'niftiDATA_Subject',sprintf('%03d',subj),'_Condition',sprintf('%03d',cond),'.nii']);
        sampleLength = size(data,4);
        for x=1:length(c)-1
            disp([subj cond x])
            maskROI= maskData == c(x+1);
            for t=1:sampleLength,
                theTimePoint = squeeze(data(:,:,:, t));
                theTimePoint = theTimePoint(maskROI);
                if ~isempty(theTimePoint),
                    theROITimeCourses(t, x) =mean(theTimePoint);
                end
            end
        end
        filename=[dataDir, 'Subject',sprintf('%03d',subj),'_Condition',sprintf('%03d',cond)];
        save([filename,'_675ROISignals.mat'],'theROITimeCourses'); %% Revised by YAN Chao-Gan, 100420. Change the output name from "ROITimeCourses" to "ROISeries'. %YAN 110504: Change to ROISignals
        
        ResultCorr =corrcoef(theROITimeCourses);
        save([filename,'_675ResultCorr.mat'],'ResultCorr');
    end
end
