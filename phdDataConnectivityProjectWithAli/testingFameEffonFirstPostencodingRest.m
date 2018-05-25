
load('D:\myStudy\picpairfMRI\postEncodingRest\conn_restingConnectivity\results\firstlevel\ANALYSIS_01\resultsROI_Condition002.mat');
famCorr=squeeze(Z([117 118 127:134],[117 118 127:134],:));

load('D:\myStudy\picpairfMRI\postEncodingRest\conn_restingConnectivity\results\firstlevel\ANALYSIS_01\resultsROI_Condition003.mat');
nonfamCorr=squeeze(Z([117 118 127:134],[117 118 127:134],:));
indlowtri = LowerTriangleIndex(10);
for i = 1:10
    for j = 1:10
        if i ~=j
            xh=prepforBWAOVPicpair([replaceOutliers(squeeze(famCorr(i,j,:)),2.5,2),...
                replaceOutliers(squeeze(nonfamCorr(i,j,:)),2.5,2)]);
            xh(3:4:end,2)=2;
            xh(4:4:end,2)=2;
            [P1(i,j) P2(i,j) P3(i,j)] = BWAOVPicpair(xh,.05);
            
    [a b c d]=ttest2(famCorr(i,j,1:2:end),nonfamCorr(i,j,2:2:end));
    tval{i,j} = d;
    pval(i,j)=b;
    
    
        [a b c d]=ttest2(famCorr(i,j,1:2:end),nonfamCorr(i,j,2:2:end));
    tval2{i,j} = d;
    pval2(i,j)=b;
        end
    
    end
end
names(131)
names(118)

for i = 1:10
    x=P3(:,i);
    x(x==0)=[];
FDRAnovaInter(:,i) = mafdr(x,'BHFDR',true)
end

for i = 1:10
    x=pval(:,i);
    x(x==0)=[];
FDRtPval(:,i) = mafdr(x,'BHFDR',true)
end