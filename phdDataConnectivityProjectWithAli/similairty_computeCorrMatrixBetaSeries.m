function similairty_computeCorrMatrixBetaSeries
% this function is used to calculated similiary, i.e., correlations
% between and within encoding runs and resting runs. The data will be saved
% in corrMatrixDir
% the output data can be directly used (need fisher's z transform)to test
% the similarity between these runs between two rois
% zhongxuliu@gmail.com Dec 9, 2013

 maskDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\similarityAnalysis\corrMatrixData_EncodingResting\'; 
% when using group roi
% maskDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\masks\';
load([maskDir,'subjVoxForEachROIBetaTimeSeries.mat']); % load the data of included voxels for each subj

corrMatrixDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\similarityAnalysis\corrMatrixData_EncodingResting\';
rootDir='C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\similarityAnalysis\';

% setup the correlation paris that need to be calculated
% first line of the corrIndex indicate the first dataset for the pair
% second line of the corrIndex indicate the second dataset for the pair
% so the column number indicate how many correlations will be calculated
% the resulting correlations is named in corrNames, in the sequence order
% correlations within encoding runs

corrIndex.encoding=[1 3 1 1 2 2 ;2 4 3 4 3 4];
corrNames.encoding={'fam12','nfam12','fam1nfam1','fam1nfam2','fam2nfam1','fam2nfam2'};
% correlations witin resting runs
corrIndex.resting=[1 1 2;2 3 3];
corrNames.resting={'pre-postfam','pre-postnfam','postfam-postnfam'};
% correlations between encoding and resting runs
corrIndex.encoRest = [1 1 1 2 2 2 3 3 3 4 4 4;
                      1 2 3 1 2 3 1 2 3 1 2 3];
corrNames.encoRest = {'fam1-pre','fam1-postfam','fam1-postnfam',...
                      'fam2-pre','fam2-postfam','fam2-postnfam',...
                      'nfam1-pre','nfam1-postfam','nfam1-postnfam',...
                      'nfam2-pre','nfam2-postfam','nfam2-postnfam'};

corrIndex.encoRestPartialPost = [1 1 2 2 3 3 4 4;
                                 2 3 2 3 2 3 2 3;
                                 3 2 3 2 3 2 3 2];
corrIndex.encoRestPartialPre = [1 1 2 2 3 3 4 4;
                                2 3 2 3 2 3 2 3;
                                1 1 1 1 1 1 1 1]; 
                            
corrNames.encoRestPartial = {'fam1-postfam','fam1-postnfam',...
                             'fam2-postfam','fam2-postnfam',...
                             'nfam1-postfam','nfam1-postnfam',...
                             'nfam2-postfam','nfam2-postnfam'};

for subj = 1:20
    
    disp(subj)
    
    %dataset 1 - encoding time series
    for cond = 1:4        
        load([rootDir,'encodingBetaTimeSeriesData\subject-', sprintf('%03d',subj),...
            '-condition-', sprintf('%03d',cond*2-1),'.mat']);
        
        % delete voxels that are outside the data volume
        roiTimeSeriesData(:,subjVox(subj).deletedVox) = [];
        
        % calculate correlation pattern for all rois
        encodingCorrMatrix(:,:,cond) = corr(roiTimeSeriesData);
        
        % fisher's z transform
        encodingCorrMatrix(:,:,cond) = 0.5 * log((1 +encodingCorrMatrix(:,:,cond))./(1- encodingCorrMatrix(:,:,cond)));
    end
   
    % don't save, take too much hard drive space
    % save([corrMatrixDir,'encoding-Subject-', sprintf('%03d',subj),...
    %             '-condition-', sprintf('%03d',cond),'.mat'], 'corrMatrix');
    
    %dataset 2 - resting
    for cond = 1:3
        load([rootDir,'restingTimeSeriesData\subject-', sprintf('%03d',subj),...
            '-condition-', sprintf('%03d',cond),'.mat']);
        
        % delete voxels that are outside the data volume
        roiTimeSeriesData(:,subjVox(subj).deletedVox) = [];

        % calculate correlation pattern for all rois
        restingCorrMatrix(:,:,cond) = corr(roiTimeSeriesData);
        
        % fisher's z transform        
        restingCorrMatrix(:,:,cond) = 0.5 * log((1 +restingCorrMatrix(:,:,cond))./(1- restingCorrMatrix(:,:,cond)));
    end
    
    
    % don't save, take too much hard drive space
    % save([corrMatrixDir,'resting-Subject-', sprintf('%03d',subj),...
    %             '-condition-', sprintf('%03d',cond),'.mat'], 'corrMatrix');
    
    
    similarityPerRoi(subj) = calculateSubjSimilarityCorrPerRoi(subj,subjVox,encodingCorrMatrix,restingCorrMatrix,corrIndex,corrNames,0)
    similarityLRMergedRoi(subj)= calculateSubjSimilarityCorrPerRoi(subj,subjVox,encodingCorrMatrix,restingCorrMatrix,corrIndex,corrNames,1)
    similarityAllRoi(subj)= calculateSubjSimilarityCorrPerRoi(subj,subjVox,encodingCorrMatrix,restingCorrMatrix,corrIndex,corrNames,3)
    
    % similarityAllRoi(subj)= calculateSubjSimilarityCorrAllRoi(subj,subjVox,encodingCorrMatrix,restingCorrMatrix,corrIndex,corrNames)
    
    clear encodingCorrMatrix;
    clear restingCorrMatrix;
end

% save the final results
save([corrMatrixDir,'similarityDataUsingBetaSeries.mat'], 'similarityPerRoi',...
    'similarityLRMergedRoi','similarityAllRoi','corrIndex','corrNames');

function similarityMatrix = calculateSubjSimilarityCorrPerRoi(subj,subjVox,encodingCorrMatrix,restingCorrMatrix,corrIndex,corrNames,LFmerge)
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
        % 'en/enco' -encoding, 're'-resting,'corr'-correlation,'par'-partial
        %within encding
        for encorri = 1:size(corrIndex.encoding,2)
            similarityMatrix.encoding(roii,roij,encorri)= ...
                calculateCorrBwt2cond(encodingCorrMatrix(idx{roii},idx{roij},corrIndex.encoding(1,encorri)),...
                encodingCorrMatrix(idx{roii},idx{roij},corrIndex.encoding(2,encorri)),roii,roij);
        end
        
        %within resting
        for recorri = 1:size(corrIndex.resting,2)
            similarityMatrix.resting(roii,roij,recorri)= ...
                calculateCorrBwt2cond(restingCorrMatrix(idx{roii},idx{roij},corrIndex.resting(1,recorri)),...
                restingCorrMatrix(idx{roii},idx{roij},corrIndex.resting(2,recorri)),roii,roij);
        end
        
        %encodng vs. resting
        for enrecorri = 1:size(corrIndex.encoRest,2)
            similarityMatrix.encoRest(roii,roij,enrecorri)= ...
                calculateCorrBwt2cond(encodingCorrMatrix(idx{roii},idx{roij},corrIndex.encoRest(1,enrecorri)),...
                restingCorrMatrix(idx{roii},idx{roij},corrIndex.encoRest(2,enrecorri)),roii,roij);
        end

        
        %post-encodng vs. resting partial out the other post-encoding rest
        for enreparcorri = 1:size(corrIndex.encoRestPartialPost,2)
            similarityMatrix.encoRestPartialPost(roii,roij,enreparcorri)= ...
                calculatePartialCorrBwt2cond(encodingCorrMatrix(idx{roii},idx{roij},corrIndex.encoRestPartialPost(1,enreparcorri)),...
                restingCorrMatrix(idx{roii},idx{roij},corrIndex.encoRestPartialPost(2,enreparcorri)),...
                restingCorrMatrix(idx{roii},idx{roij},corrIndex.encoRestPartialPost(3,enreparcorri)),roii,roij);
        end
        
        %post-encodng vs. resting partial out pre-encoding rest 
        for enreparcorri = 1:size(corrIndex.encoRestPartialPre,2)
            similarityMatrix.encoRestPartialPre(roii,roij,enreparcorri)= ...
                calculatePartialCorrBwt2cond(encodingCorrMatrix(idx{roii},idx{roij},corrIndex.encoRestPartialPre(1,enreparcorri)),...
                restingCorrMatrix(idx{roii},idx{roij},corrIndex.encoRestPartialPre(2,enreparcorri)),...
                restingCorrMatrix(idx{roii},idx{roij},corrIndex.encoRestPartialPre(3,enreparcorri)),roii,roij);
        end        
        
    end
end



%         function similarityAllRoi= calculateSubjSimilarityCorrAllRoi(subj,subjVox,encodingCorrMatrix,restingCorrMatrix,corrIndex,corrNames)
%
%
%                 %within encding
%                 for encorri = 1:size(corrIndex.encoding,2)
%                     similarityAllRoi.encoding(encorri)= ...
%                         calculateCorrBwt2cond(encodingCorrMatrix(:,:,corrIndex.encoding(1,encorri)),...
%                         encodingCorrMatrix(:,:,corrIndex.encoding(2,encorri)),1,1);
%                 end
%
%                 %within resting
%                 for recorri = 1:size(corrIndex.resting,2)
%                     similarityAllRoi.resting(recorri)= ...
%                         calculateCorrBwt2cond(encodingCorrMatrix(:,:,corrIndex.resting(1,recorri)),...
%                         encodingCorrMatrix(:,:,corrIndex.resting(2,recorri)),1,1);
%                 end
%
%                 %encodng vs. resting
%                 for enrecorri = 1:size(corrIndex.encoRest,2)
%                     similarityAllRoi.encoRest(enrecorri)= ...
%                         calculateCorrBwt2cond(encodingCorrMatrix(:,:,corrIndex.encoRest(1,enrecorri)),...
%                         encodingCorrMatrix(:,:,corrIndex.encoRest(2,enrecorri)),1,1);
%                 end

% numCor=(size(data,3)^2-size(data,3))/2;

function simiCorr = calculateCorrBwt2cond(data1,data2,roii,roij)
if roii == roij %for same roi correlation, only keep the low triagle matrix without the diagnal values
    x1= reshape(tril(data1,-1),size(data1,1)*size(data1,2),1);
    x1(x1==0)=[];
    x2=reshape(tril(data2,-1),size(data2,1)*size(data2,2),1);
    x2(x2==0)=[];
    simiCorr=corr(x1,x2);
else % for between rois, using 2 dimension correlation
    simiCorr=corr2(data1,data2);
end

function simiCorr = calculatePartialCorrBwt2cond(data1,data2,data3,roii,roij)
if roii == roij %for same roi correlation, only keep the low triagle matrix without the diagnal values
    x1= reshape(tril(data1,-1),size(data1,1)*size(data1,2),1);
    x1(x1==0)=[];
    x2=reshape(tril(data2,-1),size(data2,1)*size(data2,2),1);
    x2(x2==0)=[];    
    x3=reshape(tril(data3,-1),size(data3,1)*size(data3,2),1);
    x3(x3==0)=[];
    simiCorr=partialcorr(x1,x2,x3);
else % for between rois, using 2 dimension correlation
    x1= reshape(data1,size(data1,1)*size(data1,2),1);
    x2= reshape(data2,size(data2,1)*size(data2,2),1);
    x3= reshape(data3,size(data3,1)*size(data3,2),1);
    simiCorr=partialcorr(x1,x2,x3);
end