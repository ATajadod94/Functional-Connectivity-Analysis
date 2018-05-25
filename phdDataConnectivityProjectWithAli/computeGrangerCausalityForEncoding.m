function [T,P,gc] = computeGrangerCausalityForEncoding(nlags,dataFlag)
%if dataFlag = 1, using original data
%if dataFlag = 2, using residual data

projectDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI';
for i = 1:20
subjectDir = ['s',sprintf('%03d',i),'\encoding'];
if dataFlag ==1
load(fullfile(projectDir, subjectDir,'restTimeSNotResi.mat'));
elseif dataFlag ==2;
 load(fullfile(projectDir, subjectDir,'restTimeS.mat'));   
end

X=struct2array(fam1);
X=X';
outFam1 = cca_granger_regress(X,nlags);
gc(:,:,1,i)= outFam1.gc;

X=struct2array(fam2);
X=X';
outFam2 = cca_granger_regress(X,nlags);
gc(:,:,2,i)= outFam2.gc;

X=struct2array(nonfam1);
X=X';
outNonfam1 = cca_granger_regress(X,nlags);
gc(:,:,3,i)= outNonfam1.gc;

X=struct2array(nonfam2);
X=X';
outNonfam2 = cca_granger_regress(X,nlags);
gc(:,:,4,i)= outNonfam2.gc;
end

for m = 1:10
    for n = 1:10
        if m ~=n
            [H,P(m,n,1),CI,STATS]=ttest(gc(m,n,1,:),gc(m,n,3,:));
            T(m,n,1) = STATS.tstat;
            
            [H,P(m,n,2),CI,STATS]=ttest(gc(m,n,2,:),gc(m,n,4,:));
            T(m,n,2) = STATS.tstat;
            
            [H,P(m,n,3),CI,STATS]=ttest(gc(m,n,1,:)+gc(m,n,2,:),...
                gc(m,n,3,:)+gc(m,n,4,:));
            T(m,n,3) = STATS.tstat;
        end
    end
end

if dataFlag ==1
save(fullfile([projectDir,'\matlabFunctions\GrangerCResultsOriginalTS-Lag',num2str(nlags),'.mat']),...
    'gc','P','T');
elseif dataFlag ==2;
save(fullfile([projectDir,'\matlabFunctions\GrangerCResultsResidualTS-Lag',num2str(nlags),'.mat']),...
    'gc','P','T');
end

           