function [fam1PCA, fam2PCA, meanCorr PCweight PCvar] = calculateFaceRatingPCA(choosePCFlag)


rootDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\';
codeDir= [rootDir,'matlabFunctions\'];
rootDirD = 'D:\myStudy\picpairfMRI\';

load([codeDir,'easyDiffiPicScrmbleIncludedSubj.mat']);
%load design data
load([codeDir,'myDesigntestPicpairFinal.mat']);
load([codeDir,'stim1Concat.mat']);
load([codeDir,'stim2Concat.mat']);
idScrm = find(cell2mat(stimEncode1.fmpair(:,5))==999); %scrambles id
idPics = setdiff(1:96, idScrm)'; %pictures id
  data=[];
for i = 1:20
    %load behavorial data
    subDir = [rootDirD, 's',sprintf('%03d',i),'\'];
    behavDataDir = [subDir,'performanceData\'];
  

        load([behavDataDir,'memoryEval.mat']);
        load([behavDataDir,'emotionEval.mat']);
        load([behavDataDir,'familiarityEval.mat']);
        load([behavDataDir,'attractivenessEval.mat']);
        
        data{i} = [memoryEval(:,1:2), emotionEval(:,1:2),...
            familiarityEval(:,1:2), attractivenessEval(:,1:2)]
            data{i}=data{i}(idPics,:);   
            data{i}=data{i}(3:58,:);
            datatemp = data{i}(:,1:2:end);
            [allpca,PC, lambda]=pca1(datatemp');
            pca1All(:,i) =allpca(1,:)';
            varExplained(i)=lambda(1)^2/sum(lambda.^2);
            weightAll(:,i)=PC(:,choosePCFlag);
            
            %correlation
            corrAll(:,:,i)=corr(datatemp);
end
meanCorr = nanmean(corrAll,3);
ttest(reshape(corrAll,16,20),0)
dataall=cat(1,data{:});
fam1 = dataall(:,1:2:end);
fam2 = dataall(:,2:2:end);

corr(fam1)
% run i ca
% [weights,sphere,compvars,bias,signs,lrates,activations]  = runica(fam1(:,1:3)');
% fam1comp=reshape(activations',56,3,20);
% fam1orig = reshape(fam1,56,4,20);
[aa PCweight PCvar]=pca1(fam1');
fam1PCA = reshape(aa(choosePCFlag,:)',56,20);
fam1PCA = cat(1,cat(1,repmat(mean(fam1PCA),2,1),fam1PCA),repmat(mean(fam1PCA),2,1));

[aa PCweight PCvar]=pca1(fam2');
fam2PCA = reshape(aa(choosePCFlag,:)',56,20);
fam2PCA = cat(1,cat(1,repmat(mean(fam2PCA),2,1),fam2PCA),repmat(mean(fam2PCA),2,1));
fam2PCA = -1*fam2PCA;
% fam1PCA(:,:,2)=reshape(aa(2,:)',56,20);
% fam1PCA(:,:,3)=reshape(aa(3,:)',56,20);
% fam1PCA(:,:,4)=reshape(aa(14,:)',56,20);

   