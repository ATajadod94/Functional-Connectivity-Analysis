function postFamNfamCorrDiff
% this function is used to calculated mean correlations between rois in
% resting scans, pre postfam and postnfam. this data can be used to
% calculate postencoding correlation differences. the results should be
% similar to the conn results. however, this time the subject specific rois
% are used instead of using group rois.
% results saved as 'RestingCorrMeanData.mat'
% zhongxuliu@gmail.com Dec 9, 2013

 maskDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\similarityAnalysis\corrMatrixData_EncodingResting\'; 
% when using group roi
% maskDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\masks\'; 
load([maskDir,'subjVoxForEachROI.mat']); % load the data of included voxels for each subj

corrMatrixDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\similarityAnalysis\corrMatrixData_EncodingResting\';
rootDir='C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\similarityAnalysis\';

% setup the correlation paris that need to be calculated
% first line of the corrIndex indicate the first dataset for the pair
% second line of the corrIndex indicate the second dataset for the pair
% so the column number indicate how many correlations will be calculated
% the resulting correlations is named in corrNames, in the sequence order
% correlations within encoding runs


corrMeanIndex.resting=[1 2 3];
corrMeanNames.resting={'pre','postnfam','postnfam'};


for subj = 1:20
    
    disp(subj)
    
   
    
    %dataset 2 - resting
    for cond = 1:3
        load([rootDir,'restingTimeSeriesData\subject-', sprintf('%03d',subj),...
            '-condition-', sprintf('%03d',cond),'.mat']);
        
        % delete voxels that are outside the data volume
        roiTimeSeriesData(:,subjVox(subj).deletedVox) = [];

        % calculate correlation pattern for all rois
        restingCorrMatrix(:,:,cond) = roiTimeSeriesData;
        
        
        % fisher's z transform        
%         restingCorrMatrix(:,:,cond) = 0.5 * log((1 +restingCorrMatrix(:,:,cond))./(1- restingCorrMatrix(:,:,cond)));
    end
    
    
    % don't save, take too much hard drive space
    % save([corrMatrixDir,'resting-Subject-', sprintf('%03d',subj),...
    %             '-condition-', sprintf('%03d',cond),'.mat'], 'corrMatrix');
    
    
    restingCorrMeanPerRoi(subj) = calculateSubjCorrMeanPerRoi(subj,subjVox,restingCorrMatrix,corrMeanIndex,corrMeanNames,0)
    restingCorrMeanLRMergedRoi(subj)= calculateSubjCorrMeanPerRoi(subj,subjVox,restingCorrMatrix,corrMeanIndex,corrMeanNames,1)
    restingCorrMeanAllRoi(subj)= calculateSubjCorrMeanPerRoi(subj,subjVox,restingCorrMatrix,corrMeanIndex,corrMeanNames,3)
    
    % similarityAllRoi(subj)= calculateSubjSimilarityCorrAllRoi(subj,subjVox,encodingCorrMatrix,restingCorrMatrix,corrIndex,corrNames)

    clear restingCorrMatrix;
end

% save the final results
save([corrMatrixDir,'RestingCorrMeanData.mat'], 'restingCorrMeanPerRoi',...
    'restingCorrMeanLRMergedRoi','restingCorrMeanAllRoi','corrMeanIndex','corrMeanNames');


function corrDiffMatrix = calculateSubjCorrMeanPerRoi(subj,subjVox,restingCorrMatrix,corrIndex,corrNames,LFmerge)
if LFmerge ==0
    idx{1} =subjVox(subj).idxlvmp;
    idx{2} =subjVox(subj).idxrvmp;
    idx{3} =subjVox(subj).idxltpl;
    idx{4} =subjVox(subj).idxrtpl;
    idx{5} =subjVox(subj).idxlhpc;
    idx{6} =subjVox(subj).idxrhpc;
    idx{7} =subjVox(subj).idxlppa;
    idx{8} =subjVox(subj).idxrppa;
    idx{9} =subjVox(subj).idxlffa;
    idx{10}=subjVox(subj).idxrffa;
elseif LFmerge ==1
    idx{1}=[subjVox(subj).idxlvmp; subjVox(subj).idxrvmp];
    idx{2}=[subjVox(subj).idxltpl; subjVox(subj).idxrtpl];
    idx{3}=[subjVox(subj).idxlhpc; subjVox(subj).idxrhpc];
    idx{4}=[subjVox(subj).idxlppa; subjVox(subj).idxrppa];
    idx{5}=[subjVox(subj).idxlffa; subjVox(subj).idxrffa];
else
    idx{1}=[subjVox(subj).idxlvmp; subjVox(subj).idxrvmp;...
            subjVox(subj).idxltpl; subjVox(subj).idxrtpl;...
            subjVox(subj).idxlhpc; subjVox(subj).idxrhpc;...
            subjVox(subj).idxlppa; subjVox(subj).idxrppa;...
            subjVox(subj).idxlffa; subjVox(subj).idxrffa];
end

%  aa=cat(1,idx{:});
%  plot(aa); % use to check whether the voxel concatenation is correct

for roii=1:length(idx)
    for roij = 1: roii
       
        
        %within resting
        for recorri = 1:size(corrIndex.resting,2)
            if roii==roij
                data=tril(corr(restingCorrMatrix(:,idx{roii},corrIndex.resting(1,recorri)),...
                    restingCorrMatrix(:,idx{roij},corrIndex.resting(1,recorri))),-1);
                data(data==0)=[];
                corrDiffMatrix.resting(roii,roij,recorri)= mean(data);  
            else
%             corrDiffMatrix.resting(roii,roij,recorri)= ...
%                 mean(mean(restingCorrMatrix(idx{roii},idx{roij},corrIndex.resting(1,recorri)),1),2);
                 data1=mean(restingCorrMatrix(:,idx{roii},corrIndex.resting(1,recorri)),2);
                 data2=mean(restingCorrMatrix(:,idx{roij},corrIndex.resting(1,recorri)),2);
                
                corrDiffMatrix.resting(roii,roij,recorri)=corr(data1,data2); 
            end
        end
        
    end
end
