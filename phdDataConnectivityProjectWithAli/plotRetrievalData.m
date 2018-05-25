for i = 1:20
path = ['C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\s',...
               sprintf('%03d',i),'\performanceData\'];
load([path 'retrievalDataSummarry.mat']);
hitFam(i)=intact.Fam.hit;
falseFam(i) = intact.Fam.false;
hitNFam(i)=intact.NFam.hit;
falseNFam(i) = intact.NFam.false;
end

figure;bar(mean([hitFam-falseFam;hitNFam-falseNFam],2));

for i = 1:20
path = ['C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\s',...
               sprintf('%03d',i),'\performanceData\'];
load([path 'retrievalDataSummarry.mat']);
hitFam(i)=recom.Fam.hit;
falseFam(i) = recom.Fam.false;
hitNFam(i)=recom.NFam.hit;
falseNFam(i) = recom.NFam.false;
end

bar(mean([hitFam;falseFam;hitNFam;falseNFam],2));