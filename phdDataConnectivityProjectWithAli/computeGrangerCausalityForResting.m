function [T,P,gc] = computeGrangerCausalityForResting(nlags)
%if dataFlag = 1, using original data
%if dataFlag = 2, using residual data
roiIndx = [120 121 130:137]; %these index can be found in variable names 


projectDir = 'D:\myStudy\picpairfMRI\postEncodingRest\conn_restingConnectivity\results\preprocessing';
for i = 1:20

load(fullfile(projectDir, ['ROI_Subject',sprintf('%03d',i),'_Condition001.mat']));
X=cell2mat(data(roiIndx));
X=X';

% preResting = cca_granger_regress(X,nlags,1);
preResting = cca_partialgc(X,1,1);
gc(:,:,1,i)= preResting.doifg;
gcH(:,:,1,i) = ret.waut;

load(fullfile(projectDir, ['ROI_Subject',sprintf('%03d',i),'_Condition002.mat']));
X=cell2mat(data(roiIndx));
X=X';

% postFam = cca_granger_regress(X,nlags,1);
postFam = cca_partialgc(X,1,1);
gc(:,:,2,i)= postFam.doifg;
gcH(:,:,1,i) = ret.waut;


load(fullfile(projectDir, ['ROI_Subject',sprintf('%03d',i),'_Condition003.mat']));
X=cell2mat(data(roiIndx));
X=X';

% postNfam = cca_granger_regress(X,nlags,1);
postNfam = cca_partialgc(X,1,1);
gc(:,:,3,i)= postNfam.doifg;
gcH(:,:,1,i) = ret.waut;
end

for m = 1:10
    for n = 1:m
        if m ~=n
            [H,P(m,n,1),CI,STATS]=ttest(gc(m,n,1,:),gc(m,n,2,:));
            T(m,n,1) = STATS.tstat;
            
            [H,P(m,n,2),CI,STATS]=ttest(gc(m,n,1,:),gc(m,n,3,:));
            T(m,n,2) = STATS.tstat;
            
            [H,P(m,n,3),CI,STATS]=ttest(gc(m,n,2,:),gc(m,n,3,:));
            T(m,n,3) = STATS.tstat;
        end
    end
end
roiNames = names([120 121 130:137]); 

save(fullfile(['C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\matlabFunctions\GrangerPartialCResultsPostEncodingResting-Lag',num2str(nlags),'.mat']),...
    'gc','P','T','roiNames');

tData = T(:,:,3);
pData = P(:,:,3);
tData(pData>.05) = 0;
figure;
imagesc(tData)


tData = T(:,:,1);
pData = P(:,:,1);
tData(pData>.05) = 0;
figure;
imagesc(tData)

tData = T(:,:,2);
pData = P(:,:,2);
tData(pData>.05) = 0;
figure;
imagesc(tData)
