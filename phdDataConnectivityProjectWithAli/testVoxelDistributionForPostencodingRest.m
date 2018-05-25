

for i = 1:20
dataDir='D:\myStudy\picpairfMRI\postEncodingRest\conn_restingConnectivity\results\secondlevel\ANALYSIS_01.SUBJECT_EFFECTS_subjAll(0.0).famIntactPairMemNoOutliers(1.0).CONDITIONS_preRest(-1.0).po\AAL.Hippocampus_(R)_1_1\';
dataV1(:,:,:,i)=rest_readfile([dataDir,'CON_Subject',sprintf('%03d',i),'_compA001.nii']);
dataDir2='D:\myStudy\picpairfMRI\postEncodingRest\conn_restingConnectivity\results\secondlevel\ANALYSIS_01.SUBJECT_EFFECTS_subjAll(0.0).NfamIntactPairMemNoOutlier(1.0).CONDITIONS_preRest(-1.0).po\AAL.Hippocampus_(R)_1_1\';
dataV2(:,:,:,i)=rest_readfile([dataDir2,'CON_Subject',sprintf('%03d',i),'_compA001.nii']);
end


allData = cat(1,dataV1,dataV2);

for percentileLim=90:99;

percentData = percentile(reshape(allData,1,size(allData,1)*size(allData,2)*size(allData,3)*size(allData,4)),percentileLim);


for i = 1:20
dataDir='D:\myStudy\picpairfMRI\postEncodingRest\conn_restingConnectivity\results\secondlevel\ANALYSIS_01.SUBJECT_EFFECTS_subjAll(0.0).famIntactPairMemNoOutliers(1.0).CONDITIONS_preRest(-1.0).po\AAL.Hippocampus_(L)_1_1\';
dataV=rest_readfile([dataDir,'CON_Subject',sprintf('%03d',i),'_compA001.nii']);
for j = 1:size(dataV,2)
    id=[];
%    a= sort(reshape(squeeze(dataV(:,j,:)),1,size(dataV,1)*size(dataV,3)),'ascend');
%    bb=percentile(a,percentileLim);

  
   id=find(squeeze(dataV(:,j,:))> percentData) ;
   if ~isempty(id)
       famCount(i,j)=length(id);
   else
       famCount(i,j) = 0;
 
   end
end
end
% [a b c]=ind2sub(size(dataV),find(dataV>0));
% ab{i}=b;




% bb=cat(1,ab{:});
% figure;hist(bb,20);





for i = 1:20
dataDir2='D:\myStudy\picpairfMRI\postEncodingRest\conn_restingConnectivity\results\secondlevel\ANALYSIS_01.SUBJECT_EFFECTS_subjAll(0.0).NfamIntactPairMemNoOutlier(1.0).CONDITIONS_preRest(-1.0).po\AAL.Hippocampus_(L)_1_1\';
dataV=rest_readfile([dataDir2,'CON_Subject',sprintf('%03d',i),'_compA001.nii']);

for j = 1:size(dataV,2)
    id=[];
%    a= sort(reshape(squeeze(dataV(:,j,:)),1,size(dataV,1)*size(dataV,3)),'ascend');
%    bb=percentile(a,percentileLim);

  
   id=find(squeeze(dataV(:,j,:))> percentData) ;
   if ~isempty(id)
       nfamCount(i,j)=length(id);
   else
       nfamCount(i,j) = 0;
 
   end
end
end

% 
% figure;bar(mean(famCount,1),'r');
% figure;bar(mean(nfamCount,1),'b');
figure;bar(mean(famCount,1)-mean(nfamCount,1),'b');

for i = 1:109
   [a b c d]=ttest(famCount(:,i),nfamCount(:,i)); 
   pval(1,i)=b;
end
psig=pval<.05 & pval>0;
hold on;
scatter([1:109],psig*-50,'r');

aa=famCount-nfamCount;
aa(aa<0)=-1;
aa(aa>0)=1;
for i = 1:109
   [a b c d]=ttest(aa(:,i),0); 
   pvalbi(1,i)=b;
end
hold on;
psigbi=pvalbi<.05 & pvalbi>0;
scatter([1:109],psigbi*-20,'g');

end

