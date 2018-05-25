function memoryAndPriorKnowledge
dataName={'performance','pca'};
isFamOnly=[0,1];
rootDir1 = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\';
rootDir = 'D:\myStudy\picpairfMRI\';
codeDir= [rootDir1,'matlabFunctions\'];
     choosePCFlag = 1; % first pc
        [fam1PCA, fam2PCA, meanCorr] = calculateFaceRatingPCA(choosePCFlag);
for subID=1:20
subDir = [rootDir, 's',sprintf('%03d',subID),'\'];
behavDataDir = [subDir,'performanceData\'];

    load([behavDataDir,dataName{1},'multiCondPmod-',num2str(isFamOnly(1)),'.mat']); % fMRI model specification: Multiple conditions - cfg_files
%set the fist and last two trials (filers) to zero to exclude them. .
%     if strcmp(dataName{1},'performance')
% to make it consistent with the data reported in submitted manuscript,no
% change to zero is implemented
%    for j=1:length(pmod)
%        if isempty(pmod(j).param)==0
%     pmod(j).param{1}([1:2 59:60])=0;
%        end
%    end
% end
 memDa(:,subID)=pmod(1).param{1};
 
%  load([behavDataDir,dataName{2},'multiCondPmod-',num2str(isFamOnly(2)),'.mat']); % fMRI model specification: Multiple conditions - cfg_files
% 
%  pca60Da(:,subID) = pmod(1).param{1};
 
  
 data(:,1:2) = [fam1PCA(:,subID),fam2PCA(:,subID)];
 data1=data;
 pcaContinDa(:,subID)=data(:,1);

 for m = 1:2
        data1(find(data(:,m)<=percentile(data(:,m),50)),m)=-1; % <4 must be excecuted before >3, otherwises every item will be -1
        data1(find(data(:,m)>percentile(data(:,m),50)),m)=1;
 end
 pca50Da(:,subID)=data1(:,1);
  
 
  data1=data;
 for m = 1:2
        data1(find(data(:,m)<=percentile(data(:,m),60)),m)=-1; % <4 must be excecuted before >3, otherwises every item will be -1
        data1(find(data(:,m)>percentile(data(:,m),60)),m)=1;
 end
 pca60Da(:,subID)=data1(:,1);  
 
   data1=data;
 for m = 1:2
        data1(find(data(:,m)<=percentile(data(:,m),40)),m)=-1; % <4 must be excecuted before >3, otherwises every item will be -1
        data1(find(data(:,m)>=percentile(data(:,m),60)),m)=1;
        data1(find((data(:,m)>percentile(data(:,m),40))&(data(:,m)<percentile(data(:,m),60))),m)=0;
 end
 pca70Da(:,subID)=data1(:,1);  
  
end

figure;
for i = 1:20
    
    scatter(memDa(:,i),pcaContinDa(:,i));
        mempcaCon(i)=corr(memDa(:,i),pcaContinDa(:,i));

    lsline;
    hold on;
end


figure;
for i = 1:20    
    scatter(memDa(:,i),pca50Da(:,i));
        mempca50(i)=corr(memDa(:,i),pca50Da(:,i));
    lsline;
    hold on;
end


figure;
for i = 1:20    
    scatter(memDa(:,i),pca60Da(:,i));
    mempca60(i)=corr(memDa(:,i),pca60Da(:,i));
    lsline;
    hold on;

end


for i = 1:20    
    mempca60(i)=sum(memDa(:,i).*pca60Da(:,i));
    mempca50(i)=sum(memDa(:,i).*pca50Da(:,i));
        mempca70(i)=sum(memDa(:,i).*pca70Da(:,i));

end
 