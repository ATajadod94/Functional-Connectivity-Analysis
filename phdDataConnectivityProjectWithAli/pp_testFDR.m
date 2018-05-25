load('D:\myStudy\picpairfMRI\postEncodingRest\conn_restingConnectivity\results\firstlevel\ANALYSIS_01\resultsROI_Condition001.mat');
Z1=Z;
load('D:\myStudy\picpairfMRI\postEncodingRest\conn_restingConnectivity\results\firstlevel\ANALYSIS_01\resultsROI_Condition002.mat');
Z2=Z;

load('D:\myStudy\picpairfMRI\postEncodingRest\conn_restingConnectivity\results\firstlevel\ANALYSIS_01\resultsROI_Condition003.mat');
Z3=Z;
id1=[117 118 127:134]
id2=LowerTriangleIndex(10)
zx2=Z2(id1,id1,:)
zx3=Z3(id1,id1,:)
m=1
for i = 1:9
    for j = i+1:10
        
        [a p2(m),c s]=ttest(replaceOutliers(squeeze(zx2(i,j,:)),2.5,2),...
            replaceOutliers(squeeze(zx3(i,j,:)),2.5,2));
        m=m+1;
    end
end

m=1
for i = 1:9
for j = i+1:10
[a p1(m),c s]=ttest(squeeze(zx2(i,j,:)), squeeze(zx3(i,j,:)));
m=m+1;
end
end


[p_fdr, p_masked] = fdr( p,.05);
    mafdr(p2,'BHFDR',true)
    p(p_masked==0)=1