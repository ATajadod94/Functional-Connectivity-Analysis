% roi1Name='L-parahipp4mm05';
% roi2Name = 'L-tempole4mm05';

 roi1Name='R_HPC';
 roi2Name = 'R-vmp12mm05';%R-TPL12mm05, R-vmp12mm05
nlags = 4;
projDir='C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\';
figure;
for i=1:20  

subjPPIDir = [projDir,'s',sprintf('%03d',i),'\encoding\analysis'];
ppiRoi1=['s',sprintf('%03d',i),'_',roi1Name,'_session1_cond_PPI_regressors.mat'];
ppiRoi2=['s',sprintf('%03d',i),'_',roi2Name,'_session1_cond_PPI_regressors.mat'];

load(fullfile(subjPPIDir,ppiRoi1));
roi1Fam = OUT.PPI.C(1:574,1)+OUT.PPI.C(1:574,3);
roi1Nfam = OUT.PPI.C(575:end,5)+OUT.PPI.C(575:end,7);


% roi1Fam = OUT.PPI.C(1:287,1)+OUT.PPI.C(288:574,3);
% roi1Nfam = OUT.PPI.C(575:861,5)+OUT.PPI.C(862:1148,7);


load(fullfile(subjPPIDir,ppiRoi2));
roi2Fam = OUT.PPI.C(1:574,1)+OUT.PPI.C(1:574,3);
roi2Nfam = OUT.PPI.C(575:end,5)+OUT.PPI.C(575:end,7);

% roi2Fam = OUT.PPI.C(1:287,1)+OUT.PPI.C(288:574,3);
% roi2Nfam = OUT.PPI.C(575:861,5)+OUT.PPI.C(862:1148,7);

% roi2Fam = OUT.Y.C(1:574,1);
% roi2Nfam = OUT.Y.C(575:end,1);


roi12Fam=[roi1Fam roi2Fam]';
roi12Nfam=[roi1Nfam roi2Nfam]';

[bicFam(i) aicFam(i)] = cca_find_model_order(roi12Fam, 1, 10);
[bicNfam(i) aicNfam(i)] = cca_find_model_order(roi12Nfam, 1, 10);

a1=cca_granger_regress(roi12Fam,nlags);
a2=cca_granger_regress(roi12Nfam,nlags);

gcRoi12Fam(:,:,i) = a1.gc;
gcRoi12Nfam(:,:,i) = a2.gc;



scatter(roi1Fam', roi2Fam','bo');
p1(i,:) = polyfit(roi1Fam', roi2Fam',1); 
hold on;
plot(roi1Nfam', roi2Nfam','mo');
p2(i,:) = polyfit(roi1Nfam', roi2Nfam',1);
 lsline
end

gcFamM=mean(gcRoi12Fam,3);
gcNfamM=mean(gcRoi12Nfam,3);

 [H,P,CI,STATS] = ttest(gcRoi12Fam(1,2,:),gcRoi12Nfam(1,2,:));
Tva(1)=STATS.tstat;
 [H,P,CI,STATS] = ttest(gcRoi12Fam(2,1,:),gcRoi12Nfam(2,1,:));
Tva(2)=STATS.tstat;
 [H,P,CI,STATS] = ttest(gcRoi12Fam(1,2,:),gcRoi12Fam(2,1,:));
Tva(3)=STATS.tstat;
 [H,P,CI,STATS] = ttest(gcRoi12Nfam(1,2,:),gcRoi12Nfam(2,1,:));
Tva(4)=STATS.tstat;


mp1 = mean(p1);
mp2=  mean(p2);
x=-1:.001:1;
plot(x,mp1(2) + mp1(1)*x,'b','LineWidth',3);
plot(x,mp2(2) + mp2(1)*x,'m','LineWidth',3);
xlim([-1 1]);

figure;
subplot(2,2,1)
plot(squeeze(gcRoi12Fam(2,1,:)));
ylim([0 .07]);
subplot(2,2,3)
plot(squeeze(gcRoi12Fam(1,2,:)));
ylim([0 .07]);
subplot(2,2,2)
plot(squeeze(gcRoi12Nfam(2,1,:)));
ylim([0 .07]);
subplot(2,2,4)
plot(squeeze(gcRoi12Nfam(1,2,:)));
ylim([0 .07]);