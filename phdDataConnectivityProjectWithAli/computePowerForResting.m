
%if dataFlag = 1, using original data
%if dataFlag = 2, using residual data
roiIndx = [120 121 130:137]; %these index can be found in variable names 


projectDir = 'D:\myStudy\picpairfMRI\postEncodingRest\conn_restingConnectivity\results\preprocessing';
for i = 1:20

load(fullfile(projectDir, ['ROI_Subject',sprintf('%03d',i),'_Condition001.mat']));
xpre=cell2mat(data(roiIndx));
stdpre(:,i) =std(xpre)';
powpre(:,i) = [sum(abs(xpre).^2,1)/size(xpre,2)]';

load(fullfile(projectDir, ['ROI_Subject',sprintf('%03d',i),'_Condition002.mat']));
xpfam=cell2mat(data(roiIndx));
stdpfam(:,i) =std(xpfam)';
powpfam(:,i) = [sum(abs(xpfam).^2,1)/size(xpfam,2)]';


load(fullfile(projectDir, ['ROI_Subject',sprintf('%03d',i),'_Condition003.mat']));
xpnfam=cell2mat(data(roiIndx));
stdpnfam(:,i) =std(xpnfam)'
powpnfam(:,i) = [sum(abs(xpnfam).^2,1)/size(xpnfam,2)]';

end

for m = 1:10
    
            [H,P(m,1),CI,STATS]=ttest(powpfam(m,:)',powpnfam(m,:)');
            T(m,1) = STATS.tstat;
            
                        [H,P(m,2),CI,STATS]=ttest(powpfam(m,:)',powpre(m,:)');
            T(m,2) = STATS.tstat;
            
                        [H,P(m,3),CI,STATS]=ttest(powpnfam(m,:)',powpre(m,:)');
            T(m,3) = STATS.tstat;
            
    
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
