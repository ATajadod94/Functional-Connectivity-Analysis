function postencodingRestingHPCcorrelation
%modified April 9, 2015
%zhongxu

addpath('C:\Users\Zhongxu\Documents\MATLAB\myMatLabTools\Corr_toolbox_v2');
addpath('C:\Users\Zhongxu\Documents\MATLAB\myMatLabTools\Corr_toolbox_v2\LIBRA');
% plot lffa vs rHPC correlation in postfam nonfam rest
outpath = 'C:\Users\Zhongxu\Dropbox\picpair\PicparBehavioralmanuscript\postEncodingfMRIPub\figures\';
load(['C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\matlabFunctions\',...
    'performanceDataConcatenated.mat']);
load(['C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\matlabFunctions\',...
    'reinstatementData.mat']);
rootDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\';
[subjInfo a]=xlsread([rootDir,'matlabFunctions\picpairSubjInfo.xlsx']);
age = subjInfo(:,2);
gender  = subjInfo(:,3);

load([rootDir,'matlabFunctions\prepostRestInterview.mat']);
load('D:\myStudy\picpairfMRI\postEncodingRest\conn_restingConnectivity\results\firstlevel\ANALYSIS_01\resultsROI_Condition001.mat');

load([rootDir,'matlabFunctions\faceEvalMTotal.mat']);

mindActive=1-prepostRestInterview(:,10:12);
emotionEv=faceEvalMTotal.emotion(:,1);
memoryEv=faceEvalMTotal.memory(:,1);
familiarEv=faceEvalMTotal.familiarity(:,1);
attracEv=faceEvalMTotal.attractiveness(:,1);
idLowTri = LowerTriangleIndex(10);

%get encoding activaiton scores from encoding task
% dataDir='H:\myStudy\picpairfMRI\secondLevelAnalysis\';
% fam1Dir = [dataDir,'Fam1\'];
% nfam1Dir =[dataDir,'NonFam1\'];
% fam2Dir = [dataDir,'Fam2\'];
% nfam2Dir =[dataDir,'NonFam2\'];
% maskDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\masks\';
% rois = { 'L_PPA.img', 'R_PPA.img',...
%     'L_FFA.img', 'R_FFA.img','L_HPC.img', 'R_HPC.img', 'L_TPL.img', 'R_TPL.img',...
%     'L_vmP.img', 'R_vmP.img'};
% yfam1 = getMarsbarROIData(fam1Dir);
% ynfam1 = getMarsbarROIData(nfam1Dir);
% yfam2 = getMarsbarROIData(fam2Dir);
% ynfam2 = getMarsbarROIData(nfam2Dir);
% actData=cat(3,yfam1,yfam2,ynfam1,ynfam2);
%save('D:\myStudyFromW520Drive\picpairfMRI\matlabFunctions\brainAcitivationDataDuringEncoding_forPostencodingControlAnalysis.mat')
load('D:\myStudyFromW520Drive\picpairfMRI\matlabFunctions\brainAcitivationDataDuringEncoding_forPostencodingControlAnalysis.mat')


% controlling encoding connectivity
brainCorr.name1 = 'L_FFA';
brainCorr.name2 = 'R_HPC';
[tval pval pcomp statscomp]= controlEncodingCorrInPostCorrPrediction(brainCorr,pairMem);

[tval pval]= controlEncodingActInPostCorrPrediction(brainCorr,actData,pairMem);
[tval pval famEncodingCorr nfamEncodingCorr]= controlEncodingActCorrInPostCorrPrediction(brainCorr,actData,pairMem)

brainCorr.name1 = 'R_FFA';
brainCorr.name2 = 'L_HPC';
[tval pval pcomp statscomp]= controlEncodingCorrInPostCorrPrediction(brainCorr,pairMem);
[tval pval famEncodingCorr(:,1) nfamEncodingCorr(:,1)]= controlEncodingActCorrInPostCorrPrediction(brainCorr,actData,pairMem)

clear brainCorr;
brainCorr.name1 = 'L_PPA';
brainCorr.name2 = 'L_TMP';
[tval pval pcomp statscomp]= controlEncodingCorrInPostCorrPrediction(brainCorr,pairMem);
[tval pval famEncodingCorr(:,2) nfamEncodingCorr(:,2)]= controlEncodingActCorrInPostCorrPrediction(brainCorr,actData,pairMem)

clear brainCorr;
brainCorr.name1 = 'L_FFA';
brainCorr.name2 = 'L_TMP';
[tval pval pcomp statscomp]= controlEncodingCorrInPostCorrPrediction(brainCorr,pairMem);
[tval pval famEncodingCorr(:,3) nfamEncodingCorr(:,3)]= controlEncodingActCorrInPostCorrPrediction(brainCorr,actData,pairMem)

clear brainCorr;
brainCorr.name1 = 'R_PPA';
brainCorr.name2 = 'L_TMP';
[tval pval pcomp statscomp] = controlEncodingCorrInPostCorrPrediction(brainCorr,pairMem);
[tval pval famEncodingCorr(:,4) nfamEncodingCorr(:,4)]= controlEncodingActCorrInPostCorrPrediction(brainCorr,actData,pairMem)


clear brainCorr;
brainCorr.name1 = 'L_PPA';
brainCorr.name2 = 'R_TMP';
[tval pval pcomp statscomp]= controlEncodingCorrInPostCorrPrediction(brainCorr,pairMem);
[tval pval famEncodingCorr(:,5) nfamEncodingCorr(:,5)]= controlEncodingActCorrInPostCorrPrediction(brainCorr,actData,pairMem)


%load all encoding connectivity
idLowTri = LowerTriangleIndex(10);

for i = 1:4
load(['G:\myStudy\picpairfMRI\encoding4run\encoding4run\results\firstlevel\ANALYSIS_01\resultsROI_Condition00',num2str(i),'.mat']);

tempcorr = Z([117 118 127:134],[117 118 127:134],:);

for subj=1:20
    temp1 = tempcorr(:,:,i);
temp2(i,:)=temp1(idLowTri);
end
encodingCorr(:,:,i) = temp2;
end



figure;
[a b ]=corr(replaceOutliers(pairMem.intactFam,2.5,2),replaceOutliers(pairMem.intactNFam,2.5,2))
figure,scatter(replaceOutliers(pairMem.intactFam,2.5,2),replaceOutliers(pairMem.intactNFam,2.5,2));
lsline;


figure;
[a b ]=corr(age,replaceOutliers(pairMem.intactFam,2.5,2))
figure,scatter(age,replaceOutliers(pairMem.intactFam,2.5,2));
lsline;
figure;
[a b ]=corr(age,replaceOutliers(pairMem.intactNFam,2.5,2))
figure,scatter(age,replaceOutliers(pairMem.intactNFam,2.5,2));
lsline;


[a b c d e]=regress(replaceOutliers(pairMem.intactFam,2.5,2),[ones(20,1),...
    replaceOutliers(pairMem.intactNFam,2.5,2),age])

[a b]=robustfit([replaceOutliers(pairMem.intactNFam,2.5,2),age], replaceOutliers(pairMem.intactFam,2.5,2))
[a b]=robustfit([replaceOutliers(faceMem.totalNFam,2.5,2),age], replaceOutliers(faceMem.totalFam,2.5,2))


[a b ]=corr(replaceOutliers(faceEvalMTotal.familiarity(:,1),2.5,2),replaceOutliers(faceMem.totalFam,2.5,2))
[a b ]=corr(replaceOutliers(faceEvalMTotal.memory(:,1),2.5,2),replaceOutliers(faceMem.totalFam,2.5,2))
[a b ]=corr(replaceOutliers(faceEvalMTotal.emotion(:,1),2.5,2),replaceOutliers(faceMem.totalFam,2.5,2))
[a b ]=corr(replaceOutliers(faceEvalMTotal.attractiveness(:,1),2.5,2),replaceOutliers(faceMem.totalFam,2.5,2))


[a b ]=corr(replaceOutliers(prepostRestInterview(:,4),2.5,2),replaceOutliers(faceMem.totalFam,2.5,2))
[a b ]=corr(replaceOutliers(prepostRestInterview(:,5),2.5,2),replaceOutliers(faceMem.totalFam,2.5,2))
[a b ]=corr(replaceOutliers(prepostRestInterview(:,11),2.5,2),replaceOutliers(faceMem.totalFam,2.5,2))


[a b ]=corr(replaceOutliers(prepostRestInterview(:,7),2.5,2),replaceOutliers(faceMem.totalNFam,2.5,2))
[a b ]=corr(replaceOutliers(prepostRestInterview(:,8),2.5,2),replaceOutliers(faceMem.totalNFam,2.5,2))
[a b ]=corr(replaceOutliers(prepostRestInterview(:,12),2.5,2),replaceOutliers(faceMem.totalNFam,2.5,2))

[a b ]=corr(replaceOutliers(prepostRestInterview(:,4),2.5,2),replaceOutliers(houseMem.totalFam,2.5,2))
[a b ]=corr(replaceOutliers(prepostRestInterview(:,5),2.5,2),replaceOutliers(houseMem.totalFam,2.5,2))
[a b ]=corr(replaceOutliers(prepostRestInterview(:,11),2.5,2),replaceOutliers(houseMem.totalFam,2.5,2))


[a b ]=corr(replaceOutliers(prepostRestInterview(:,7),2.5,2),replaceOutliers(houseMem.totalNFam,2.5,2))
[a b ]=corr(replaceOutliers(prepostRestInterview(:,8),2.5,2),replaceOutliers(houseMem.totalNFam,2.5,2))
[a b ]=corr(replaceOutliers(prepostRestInterview(:,12),2.5,2),replaceOutliers(houseMem.totalNFam,2.5,2))


[a b ]=corr(replaceOutliers(prepostRestInterview(:,4),2.5,2),replaceOutliers(pairMem.intactFam,2.5,2))
[a b ]=corr(replaceOutliers(prepostRestInterview(:,5),2.5,2),replaceOutliers(pairMem.intactFam,2.5,2))
[a b ]=corr(replaceOutliers(prepostRestInterview(:,11),2.5,2),replaceOutliers(pairMem.intactFam,2.5,2))


[a b ]=corr(replaceOutliers(prepostRestInterview(:,7),2.5,2),replaceOutliers(pairMem.intactNFam,2.5,2))
[a b ]=corr(replaceOutliers(prepostRestInterview(:,8),2.5,2),replaceOutliers(pairMem.intactNFam,2.5,2))
[a b ]=corr(replaceOutliers(prepostRestInterview(:,12),2.5,2),replaceOutliers(pairMem.intactNFam,2.5,2))


[a b c d]=ttest(replaceOutliers(pairMem.intactFam,2.5,2),replaceOutliers(pairMem.intactNFam,2.5,2))
%**************************************************************************
%*************************post encoding correlations***********************
%**************************************************************************

% Cheryl suggested multiple regression

% roi1={'L_PPA','L_PPA','R_PPA','L_FFA','R_FFA','L_HPC','R_PPA','L_FFA'};
% roi2={'L_TMP','R_TMP','L_TMP','L_TMP','L_HPC','L_FFA','R_TMP','R_FFA'};

roi1={'L_PPA','L_PPA','R_PPA','L_FFA','R_FFA','L_HPC','R_PPA','L_FFA','R_PPA','L_FFA'};
roi2={'L_TMP','R_TMP','L_TMP','L_TMP','L_HPC','L_FFA','R_TMP','R_FFA','R_HPC','R_HPC'};
for i = 1:length(roi1)
[preCorr(:,i) famCorr(:,i) nonfamCorr(:,i)] = getBrainCorrData(roi1{i},roi2{i});
end
%final results using spss file in this folder
%connectivityPredictingFamPairMemIntact_CherylSuggested.sav
[a b c]=glmfit([famCorr(:,1:5)],replaceOutliers(pairMem.intactFam,2.5,2));% i = 3, 4 significant, i = 5 trend p=,07

for kk = 1:8
[a b c d e(kk,:)]=regress(replaceOutliers(pairMem.intactFam,2.5,2),[ones(20,1),famCorr(:,kk)]); 
end


% regression effect size for revision NeuroImage
for mm = 1:10
[a b c d e(mm,:)]=regress(replaceOutliers(famCorr(:,mm),2.5,2),[ones(20,1),age]); 
[a1 b1 c1{mm}]=glmfit(age,replaceOutliers(famCorr(:,mm),2.5,2))

[a b c d e2(mm,:)]=regress(replaceOutliers(pairMem.intactFam,2.5,2),[ones(20,1),replaceOutliers(famCorr(:,mm)-preCorr(:,mm),2.5,2)]); 

[a1 b1 c2{mm}]=glmfit(famCorr(:,mm)-preCorr(:,mm),replaceOutliers(pairMem.intactFam,2.5,2))
[a b c d e3(mm,:)]=regress(replaceOutliers(famCorr(:,mm),2.5,2),[ones(20,1),memoryEv]); % row 1, 2, 3 

[a b c d e4(mm,:)]=regress(replaceOutliers((pairMem.intactFam - pairMem.intactNFam),2.5,2),[ones(20,1),replaceOutliers(famCorr(:,mm)-nonfamCorr(:,mm),2.5,2)]); 
[a1 b1 c4{mm}]=glmfit(famCorr(:,mm)-nonfamCorr(:,mm),replaceOutliers((pairMem.intactFam - pairMem.intactNFam),2.5,2))

[a1 b1 c5{mm}]=glmfit(replaceOutliers(famCorr(:,mm),2.5,2),replaceOutliers(pairMem.intactFam,2.5,2))
[a b c d e5(mm,:)]=regress(replaceOutliers(pairMem.intactFam,2.5,2),[ones(20,1),famCorr(:,mm)]); 

[a1 b1 c6{mm}]=glmfit(replaceOutliers(nonfamCorr(:,mm),2.5,2),replaceOutliers(pairMem.intactNFam,2.5,2))
[a b c d e6(mm,:)]=regress(replaceOutliers(pairMem.intactNFam,2.5,2),[ones(20,1),nonfamCorr(:,mm)]); 

end



[a1 b1 c1]=glmfit([famCorr(:,1:5),age],replaceOutliers(pairMem.intactFam,2.5,2));% i = 3, 4 significant, i = 5 trend p=,07

for i= 1:8
    
   [temp1 temp2 temp3{i}]=glmfit([famCorr(:,i),replaceOutliers(pairMem.intactNFam,2.5,2)],replaceOutliers(pairMem.intactFam,2.5,2));% i = 3, 4 significant, i = 5 trend p=,07
 
end
[a b c]=glmfit([famCorr,age],replaceOutliers(pairMem.intactFam,2.5,2));
[a b c]=glmfit([famCorr(:,1:5),replaceOutliers(faceMem.totalFam,2.5,2)],replaceOutliers(pairMem.intactFam,2.5,2));% i = 3, 4 significant, i = 5 trend p=,07


[a b]=partialcorr(famCorr(:,1:5),replaceOutliers(pairMem.intactFam,2.5,2),preCorr(:,1:5))
[a b]=partialcorr(famCorr(:,1:5),replaceOutliers(pairMem.intactFam,2.5,2),nonfamCorr(:,1:5))
[a b]=partialcorr(famCorr(:,1:5),replaceOutliers(pairMem.intactFam,2.5,2),[nonfamCorr(:,1:5),preCorr(:,1:5)])
[a b]=partialcorr(famCorr(:,1:5),replaceOutliers(pairMem.intactFam,2.5,2),replaceOutliers(pairMem.intactNFam,2.5,2))
[temp1 temp2]=partialcorr(age,replaceOutliers(pairMem.intactFam,2.5,2),replaceOutliers(pairMem.intactNFam,2.5,2))
[aaa bbb] = corr(replaceOutliers(pairMem.intactNFam,2.5,2),replaceOutliers(pairMem.intactFam,2.5,2))


[a b c]=glmfit([famCorr],replaceOutliers(pairMem.intactNFam,2.5,2))

[a b c]=glmfit([nonfamCorr,age],replaceOutliers(pairMem.intactNFam,2.5,2))
[a b c]=glmfit([nonfamCorr,mean(mean(actData(:,1:8,3:4),3),2)],replaceOutliers(pairMem.intactNFam,2.5,2))

[a b c]=glmfit([famCorr,mean(mean(actData(:,1:8,1:2),3),2)],replaceOutliers(pairMem.intactFam,2.5,2))
[a b c]=glmfit([mean(mean(actData(:,1:8,1:2),3),2)],replaceOutliers(pairMem.intactFam,2.5,2))
[a b c]=glmfit(mean(actData(:,1:8,1:2),3),replaceOutliers(pairMem.intactFam,2.5,2))

1-var(c.resid)./var(replaceOutliers(pairMem.intactNFam,2.5,2))

[a b c d Rsquare]=regress(replaceOutliers(pairMem.intactFam,2.5,2),[ones(20,1),famCorr(:,1:5)]); 
for kk=1:10000
    rng = kk;
    idshuff=randsample(1:20,20);
    xx = pairMem.intactFam(idshuff);
   [a b c d e(kk,:)]=regress(replaceOutliers(xx,2.5,2),[ones(20,1),famCorr(:,1:5)]); 
end
meanSS = mean(e); %mean Rsquare = . 263 
stdSS=std(e); %sd=.136
z=(Rsquare(1) - meanSS(1))/stdSS(1) %z=3.294
hist(e(:,1),40);
set(gcf,'color','White')
h=line([meanSS,meanSS],[0,600])
set(h,'Color','r')
h2=line([Rsquare(1),Rsquare(1)],[0,600])
set(h2,'Color','b')
sum(e(:,1)>Rsquare(1))/10000;
%p=.001
%histgram saved to neurimage dropbox folder

for kk=1:8
[aaa(kk) bbb(kk)]= partialcorr(famCorr(:,kk),replaceOutliers(pairMem.intactFam,2.5,2),replaceOutliers(faceMem.totalFam,2.5,2))
end

for kk=1:8
[aaa(kk) bbb(kk)]= partialcorr(famCorr(:,kk),replaceOutliers(pairMem.intactFam,2.5,2),replaceOutliers(houseMem.totalFam,2.5,2))
end

for kk=1:8
[aaa(kk) bbb(kk)]= partialcorr(famCorr(:,kk),replaceOutliers(pairMem.intactFam,2.5,2),[replaceOutliers(houseMem.totalFam,2.5,2),replaceOutliers(faceMem.totalFam,2.5,2)])
end

for kk=1:8
[aaa(kk) bbb(kk)]= partialcorr(famCorr(:,kk),replaceOutliers(pairMem.intactFam,2.5,2),[replaceOutliers(pairMem.intactNFam,2.5,2)]);
end

for kk=1:8
[a  b c]= glmfit(preCorr(:,kk),replaceOutliers(pairMem.intactFam,2.5,2));
pval(kk)=c.p(2);
tval(kk)=c.t(2);
end

[rr pp] = corr([replaceOutliers(faceMem.totalFam,2.5,2),replaceOutliers(houseMem.totalFam,2.5,2),replaceOutliers(pairMem.intactFam,2.5,2)])
mean(replaceOutliers(houseMem.totalFam,2.5,2))
mean(replaceOutliers(faceMem.totalFam,2.5,2))
[aa bb]=corr(replaceOutliers(pairMem.intactFam,2.5,2),replaceOutliers(faceMem.totalFam,2.5,2))
clear precorr famCorr nonfamCorr


% Z([117 118 127:134],[117 118 127:134],:)
[preCorrAllRoi famCorrAllRoi nonfamCorrAllRoi] = getAllBrainCorrData;
%fam
connMean = mean(famCorrAllRoi,3);
connStd = std(famCorrAllRoi,[],3);
idLowTri = LowerTriangleIndex(10);
connStd(idLowTri) = connMean(idLowTri);
figure;h=imagesc(connStd,[-1.5 1.5]);
impixelregion(h);

%nofam
connMean = mean(nonfamCorrAllRoi,3);
connStd = std(nonfamCorrAllRoi,[],3);
idLowTri = LowerTriangleIndex(10);
connStd(idLowTri) = connMean(idLowTri);
figure;h=imagesc(connStd,[-1.5 1.5]);
impixelregion(h);

%fam-nonfam

% connMean = mean((famCorrAllRoi - nonfamCorrAllRoi),3);
% connStd = std((famCorrAllRoi - nonfamCorrAllRoi),[],3);
% idLowTri = LowerTriangleIndex(10);
% connStd(idLowTri) = connMean(idLowTri);
% figure;h=imagesc(connStd,[-1.5 1.5]);
% impixelregion(h);

x=(famCorrAllRoi - nonfamCorrAllRoi)
for i = 1:20
temp = x(:,:,i);
tempc(i,:)=temp(idLowTri);
end

[aa bb cc dd]=ttest(tempc,0)
x=mean(x,3);
tempa=zeros(10,10)
tempa(idLowTri)=x(idLowTri)
tempb=zeros(10,10)
tempb(idLowTri)=dd.tstat;
tempb=tempb'
x=tempa+tempb;
x(x==0)=nan;
figure;h=imagesc(x,[-5 5]);
impixelregion(h);

%p plot
x=zeros(10,10)
x(idLowTri)=bb;
x=x+x';
figure;h=imagesc(x,[0,.2]);
impixelregion(h);



%fam predicting associative memory
x=famCorrAllRoi;
for i = 1:20
temp = x(:,:,i);
tempc(i,:)=temp(idLowTri);
end

for j = 1:size(tempc,2)
[a b c]=glmfit(tempc(:,j),replaceOutliers(pairMem.intactFam,2.5,2));% i = 3, 4 significant, i = 5 trend p=,07
[a b c]=glmfit(tempc(:,j),replaceOutliers(faceMem.totalFam,2.5,2));% i = 3, 4 significant, i = 5 trend p=,07
[a b c]=glmfit(tempc(:,j),replaceOutliers(houseMem.totalFam,2.5,2));% i = 3, 4 significant, i = 5 trend p=,07

bval(j)=a(2);
tval(j) = c.t(2);
pval(j)=c.p(2);
end

tempa=zeros(10,10);
tempa(idLowTri) = tval;
tempa=tempa';
tempa(idLowTri) = bval;
tempa(tempa==0)=nan;
figure;h=imagesc(tempa,[-5 5]);
impixelregion(h);


%p plot
x=zeros(10,10)
x(idLowTri)=pval;
x=x+x';
figure;h=imagesc(x,[0,.05]);
impixelregion(h);
[COEFF, SCORE, LATENT] = princomp(tempc);
[a b c]=glmfit(SCORE(:,1:6),replaceOutliers(pairMem.intactFam,2.5,2));% i = 3, 4 significant, i = 5 trend p=,07
1-var(c.resid)./var(replaceOutliers(pairMem.intactNFam,2.5,2))

%nonfam predicting associative memory

x=nonfamCorrAllRoi;
for i = 1:20
temp = x(:,:,i);
tempc(i,:)=temp(idLowTri);
end

for j = 1:size(tempc,2)
% [a b c]=glmfit(tempc(:,j),replaceOutliers(pairMem.intactNFam,2.5,2));% i = 3, 4 significant, i = 5 trend p=,07

[a b c]=glmfit(tempc(:,j),replaceOutliers(faceMem.totalNFam,2.5,2));% i = 3, 4 significant, i = 5 trend p=,07
[a b c]=glmfit(tempc(:,j),replaceOutliers(houseMem.totalNFam,2.5,2));% i = 3, 4 significant, i = 5 trend p=,07

bval(j)=a(2);
tval(j) = c.t(2);
pval(j)=c.p(2);
end

tempa=zeros(10,10);
tempa(idLowTri) = tval;
tempa=tempa';
tempa(idLowTri) = bval;
tempa(tempa==0)=nan;
figure;h=imagesc(tempa,[-5 5]);
impixelregion(h);

%p val
x=zeros(10,10)
x(idLowTri)=pval;
x=x+x';
figure;h=imagesc(x,[0,.05]);
impixelregion(h);


%%pre-encoding conn predicting associative memory

%predicting fam memory only bilateral PPA predicting associative fam memory
%at p = .02 t = 2.53
x=preCorrAllRoi;
for i = 1:20
temp = x(:,:,i);
tempc(i,:)=temp(idLowTri);
end

for j = 1:size(tempc,2)
[a b c]=glmfit(tempc(:,j),replaceOutliers(pairMem.intactFam,2.5,2));% i = 3, 4 significant, i = 5 trend p=,07
bval(j)=a(2);
tval(j) = c.t(2);
pval(j)=c.p(2);
end

tempa=zeros(10,10);
tempa(idLowTri) = tval;
tempa=tempa';
tempa(idLowTri) = bval;
tempa(tempa==0)=nan;
figure;h=imagesc(tempa,[-5 5]);
impixelregion(h);

%p val
x=zeros(10,10)
x(idLowTri)=pval;
x=x+x';
figure;h=imagesc(x,[0,.05]);
impixelregion(h);


%predict nonfam memory: results: only bilateral HPC conn predict nonfam
%memory at p = .04 t = -2.28 negatively
for j = 1:size(tempc,2)
[a b c]=glmfit(tempc(:,j),replaceOutliers(pairMem.intactNFam,2.5,2));% i = 3, 4 significant, i = 5 trend p=,07
bval(j)=a(2);
tval(j) = c.t(2);
pval(j)=c.p(2);
end

tempa=zeros(10,10);
tempa(idLowTri) = tval;
tempa=tempa';
tempa(idLowTri) = bval;
tempa(tempa==0)=nan;
figure;h=imagesc(tempa,[-5 5]);
impixelregion(h);

%p val
x=zeros(10,10)
x(idLowTri)=pval;
x=x+x';
figure;h=imagesc(x,[0,.05]);
impixelregion(h);


%%fampost-encoding - pre-encoding conn predicting fam associative memory
x=famCorrAllRoi-preCorrAllRoi;
for i = 1:20
temp = x(:,:,i);
tempc(i,:)=temp(idLowTri);
end

for j = 1:size(tempc,2)
[a b c]=glmfit(tempc(:,j),replaceOutliers(pairMem.intactFam,2.5,2));% i = 3, 4 significant, i = 5 trend p=,07
bval(j)=a(2);
tval(j) = c.t(2);
pval(j)=c.p(2);
end

tempa=zeros(10,10);
tempa(idLowTri) = tval;
tempa=tempa';
tempa(idLowTri) = bval;
tempa(tempa==0)=nan;
figure;h=imagesc(tempa,[-5 5]);
impixelregion(h);

%p val
x=zeros(10,10)
x(idLowTri)=pval;
x=x+x';
figure;h=imagesc(x,[0,.05]);
impixelregion(h);



%%famp-nonfam post-encoding -conn predicting fam-nonfam associative memory
x=famCorrAllRoi-nonfamCorrAllRoi;
for i = 1:20
temp = x(:,:,i);
tempc(i,:)=temp(idLowTri);
end

for j = 1:size(tempc,2)
[a b c]=glmfit(tempc(:,j),replaceOutliers(pairMem.intactFam,2.5,2)-replaceOutliers(pairMem.intactNFam,2.5,2));% i = 3, 4 significant, i = 5 trend p=,07
[a b c]=glmfit(tempc(:,j),replaceOutliers(pairMem.intactFam-pairMem.intactNFam,2.5,2));% i = 3, 4 significant, i = 5 trend p=,07

bval(j)=a(2);
tval(j) = c.t(2);
pval(j)=c.p(2);
end

tempa=zeros(10,10);
tempa(idLowTri) = tval;
tempa=tempa';
tempa(idLowTri) = bval;
tempa(tempa==0)=nan;
figure;h=imagesc(tempa,[-5 5]);
impixelregion(h);

%p val
x=zeros(10,10)
x(idLowTri)=pval;
x=x+x';
figure;h=imagesc(x,[0,.05]);
impixelregion(h);

%%
%choose 5 best predictors

idin=find(pval<.1);
%depending on using which conn value, if use the ones selected from famous
%condition, those conn accounts more variance in fam than nonfam, but if
%choose the best predictors in both conditions, there is no cond diff in
%terms of explained variance
[a b c d Rsquare2]=regress(replaceOutliers(houseMem.totalNFam,2.5,2),[ones(20,1),tempc(:,idin)]); %no cond diff if use this
[a b c d Rsquare2]=regress(replaceOutliers(houseMem.totalNFam,2.5,2),[ones(20,1),nonfamCorr(:,1:5)]); %there is cond diff

[a b c d Rsquare1]=regress(replaceOutliers(pairMem.intactFam,2.5,2),[ones(20,1),famCorr(:,1:5)]); 
for kk=1:10000
    rng = kk;
    idshuff=randsample(1:20,20);
    xx1 = pairMem.intactFam(idshuff);
    xx2 = pairMem.intactNFam(idshuff);
   [a b c d e1(kk,:)]=regress(replaceOutliers(xx1,2.5,2),[ones(20,1),famCorr(:,1:5)]); 
[a b c d e2(kk,:)]=regress(replaceOutliers(xx2,2.5,2),[ones(20,1),nonfamCorr(:,1:5)]);
% [a b c d e2(kk,:)]=regress(replaceOutliers(xx2,2.5,2),[ones(20,1),tempc(:,idin)]);

edif(kk)=e1(kk,1)-e2(kk,1);
end
meanSS = mean(edif); %mean Rsquare = . 263 
stdSS=std(edif); %sd=.136
z=((Rsquare1(1)-Rsquare2(1)) - meanSS(1))/stdSS(1) %z=3.294
figure;hist(edif,40);
set(gcf,'color','White')
h=line([meanSS,meanSS],[0,600])
set(h,'Color','r')
h2=line([Rsquare(1),Rsquare(1)],[0,600])
set(h2,'Color','b')
% sum(edif(:,1)>(Rsquare1(1)-Rsquare2(1)))/10000;
%%


%famous condition
brainCorr.name1 = 'L_FFA';
brainCorr.name2 = 'R_HPC';
[preCorr famCorr nonfamCorr] = getBrainCorrData(brainCorr.name1,brainCorr.name2);
[a b c]=glmfit([reinstatementData(:,6),pairMem.intactFam,pairMem.recomFam],famCorr) %no sig effects for all predictors

brainCorr.data = famCorr;
brainCorr.fameFlag = 'Fam';
% plot scatter plot bwt brain correlation and associative memory
% performance
plotBrainCorrWithAssociativeMem(brainCorr,pairMem.intactFam);
LFFARHPCConFamNfamPareMem = regressionSlopDiff(famCorr, nonfamCorr,pairMem.intactFam,pairMem.intactNFam);
[zpfCorrDiff, zpfPval] = ZPFTest(famCorr, pairMem.intactFam,nonfamCorr,pairMem.intactNFam,20);

clear brainCorr;
brainCorr.name1 = 'L_FFA';
brainCorr.name2 = 'R_HPC';
brainCorr.data = famCorr-preCorr;
brainCorr.data2 = nonfamCorr-preCorr;
brainCorr.fameFlag = 'post-preWondering';
plotBrainCorrWith2AssociativeMems(brainCorr,prepostRestInterview(:,11),prepostRestInterview(:,12),'post-preWondering');

clear brainCorr;
brainCorr.name1 = 'L_FFA';
brainCorr.name2 = 'R_HPC';
brainCorr.data = famCorr-nonfamCorr;
brainCorr.fameFlag = 'postfam-nfam-Wondering';
plotBrainCorrWith2AssociativeMems(brainCorr,mindActive(:,2),mindActive(:,3),brainCorr.fameFlag);


brainCorr.preCorr = preCorr;
brainCorr.famCorr = famCorr;
brainCorr.nonfamCorr = nonfamCorr;
plot3BrainCorrWithOnePredictor(brainCorr,age,'Age');
plot3BrainCorrWithOnePredictor(brainCorr,mindActive,'Mind activeness');
plot3BrainCorrWithOnePredictor(brainCorr,emotionEv,'Emotion');
plot3BrainCorrWithOnePredictor(brainCorr,memoryEv,'Memory');
plot3BrainCorrWithOnePredictor(brainCorr,familiarEv,'Familiarity');
plot3BrainCorrWithOnePredictor(brainCorr,attracEv,'Attractiveness');

%nonfamous condition
clear brainCorr;
brainCorr.name1 = 'L_FFA';
brainCorr.name2 = 'R_HPC';
[preCorr famCorr nonfamCorr] = getBrainCorrData(brainCorr.name1,brainCorr.name2);
statLffaRhpc = plot3bars(preCorr,famCorr,nonfamCorr,'L-FFA-R-HPC',outpath);

brainCorr.data = nonfamCorr;
brainCorr.fameFlag = 'NFam';
% plot scatter plot bwt brain correlation and associative memory
% performance
plotBrainCorrWithAssociativeMem(brainCorr,pairMem.intactNFam);

% plot bar graph for brain correlations in the two fame condition
s = figure; 
fsize=8;
ss = bar(mean([famCorr,nonfamCorr],1),'k');
hold on;
errorbar(mean([famCorr,nonfamCorr],1),std([famCorr,nonfamCorr],1)/sqrt(19),'k');
hold on;
%     scatter(1.1*ones(20,1),famCorr, 20, randColor);
%         scatter(1.9*ones(20,1),nonfamCorr, 20, randColor);
     scatter(1.1*ones(20,1),famCorr, 20,'k');
         scatter(1.9*ones(20,1),nonfamCorr,20,'k'); 
    hold on;
for i = 1:20
    randColor(i,:) = rand(1,3);
    plot([1.1,1.9],[famCorr(i),nonfamCorr(i)],'Color',randColor(i,:));

    hold on;
end

   
ylabel('L-FFA - R-HPC'); 
set(gca,'fontsize',fsize);
box off;
set(gcf, 'Color', 'w');
setfigsize(s,8,'Helvetica',8,'Helvetica',6,5);
set(gca,'YLim',[-.16 .81]);
set(gca, 'XTickLabel', {'Post-famous','Post-nonfamous'});
export_fig([outpath 'lFFAvsRHPC-bar_withdatapoint'],'-pdf');
plot2svg([outpath 'lFFAvsRHPC-bar_withdatapoint.svg'],s);



% plot bar graph for brain correlations in the 3 resting condition
s = figure; 
fsize=8;
ss = bar(mean([preCorr, famCorr,nonfamCorr],1),.5,'k');
hold on;
errorbar(mean([preCorr, famCorr,nonfamCorr],1),std([preCorr, famCorr,nonfamCorr],1)/sqrt(20),'k');
hold on;
%     scatter(1.1*ones(20,1),famCorr, 20, randColor);
%         scatter(1.9*ones(20,1),nonfamCorr, 20, randColor);
     scatter(1.1*ones(20,1),preCorr, 20,'k');
     scatter(1.9*ones(20,1),famCorr, 20,'k');
         scatter(2.9*ones(20,1),nonfamCorr,20,'k'); 
    hold on;
for i = 1:20
    randColor(i,:) = rand(1,3);
       plot([1.1,1.9],[preCorr(i),famCorr(i)],'Color',randColor(i,:));
    plot([1.9,2.9],[famCorr(i),nonfamCorr(i)],'Color',randColor(i,:));

    hold on;
end

   
ylabel('L-FFA - R-HPC'); 
set(gca,'fontsize',fsize);
box off;
set(gcf, 'Color', 'w');
setfigsize(s,8,'Helvetica',8,'Helvetica',8.5,8);
set(gca,'YLim',[-.2 .61]);
set(gca, 'XTickLabel', {'Pre-encoding','Post-famous','Post-nonfamous'});
export_fig([outpath 'lFFAvsRHPC-3bar_withdatapoint'],'-pdf');
plot2svg([outpath 'lFFAvsRHPC-3bar_withdatapoint.svg'],s);



% plot rffa vs lHPC correlation in postfam nonfam rest
clear brainCorr;
brainCorr.name1 = 'R_FFA';
brainCorr.name2 = 'L_HPC';
[preCorr famCorr nonfamCorr] = getBrainCorrData(brainCorr.name1,brainCorr.name2);
statRffaLhpc = plot3bars(preCorr,famCorr,nonfamCorr,'R-FFA-L-HPC',outpath);
[zpfCorrDiff, zpfPval] = ZPFTest(famCorr, pairMem.intactFam,nonfamCorr,pairMem.intactNFam,20)
%z=1.825 p = .068

% reinstatement
[a b]=corr(famCorr,age)
[a b]=corr(age,reinstatementData(:,6)) % sig positive correlation
[a b]=corr(age,reinstatementData(:,5)) %no effects
[a b]=corr(famCorr,reinstatementData(:,6)) %sig positive correlation
[a b]=corr(preCorr,reinstatementData(:,6)) % no effects
[a b c]=glmfit([reinstatementData(:,6),pairMem.intactFam,pairMem.recomFam],famCorr)


% reinstatement anterior hpc
clear brainCorr;
brainCorr.name1 = 'R_FFA';
brainCorr.name2 = 'L_aHC';
[preCorr famCorr nonfamCorr] = getBrainCorrData(brainCorr.name1,brainCorr.name2);
[a b]=corr(famCorr,age)
[a b]=corr(famCorr,reinstatementData(:,6)) %sig positive correlation
[a b]=corr(preCorr,reinstatementData(:,6)) % no effects
[a b]=corr(famCorr,pairMem.intactFam)
[a b c]=glmfit([reinstatementData(:,6),pairMem.intactFam],famCorr)
[a b c]=glmfit([reinstatementData(:,6),pairMem.intactFam,pairMem.recomFam],famCorr)


% reinstatement posterior hpc
clear brainCorr;
brainCorr.name1 = 'R_FFA';
brainCorr.name2 = 'L_pHC';
[preCorr famCorr nonfamCorr] = getBrainCorrData(brainCorr.name1,brainCorr.name2);
[a b]=corr(famCorr,age)
[a b]=corr(famCorr,reinstatementData(:,6)) %sig positive correlation
[a b]=corr(preCorr,reinstatementData(:,6)) % no effects
[a b]=corr(famCorr,pairMem.intactFam)
[a b c]=glmfit([reinstatementData(:,6),pairMem.intactFam],famCorr)
[a b c]=glmfit([reinstatementData(:,6),pairMem.intactFam,pairMem.recomFam],famCorr)


brainCorr.data = famCorr-nonfamCorr;
brainCorr.fameFlag = 'postfam-nfam-Wondering';
plotBrainCorrWith2AssociativeMems(brainCorr,mindActive(:,2),mindActive(:,3),brainCorr.fameFlag);


clear brainCorr;
brainCorr.name1 = 'R_FFA';
brainCorr.name2 = 'L_HPC';
brainCorr.data = famCorr-preCorr;
brainCorr.data2 = nonfamCorr-preCorr;
brainCorr.fameFlag = 'post-preWondering';
plotBrainCorrWith2AssociativeMems(brainCorr,prepostRestInterview(:,11),prepostRestInterview(:,12),'post-preWondering');



clear brainCorr;
brainCorr.name1 = 'R_FFA';
brainCorr.name2 = 'L_HPC';
brainCorr.data = famCorr;
brainCorr.data2 = nonfamCorr;
brainCorr.fameFlag = 'post-wondering';
plotBrainCorrWith2AssociativeMems(brainCorr,prepostRestInterview(:,11),prepostRestInterview(:,12),brainCorr.fameFlag );


clear brainCorr;
brainCorr.name1 = 'R_FFA';
brainCorr.name2 = 'L_HPC';
brainCorr.data = famCorr;
brainCorr.fameFlag = 'Fam';
% plot scatter plot bwt brain correlation and associative memory
% performance
plotBrainCorrWithAssociativeMem(brainCorr,pairMem.intactFam);
plotBrainCorrWith2AssociativeMems(brainCorr,pairMem.intactFam,pairMem.intactNFam,'PairMem');
%zMCorrDiff =1.5312 zmp=.126

plotBrainCorrWith2AssociativeMems(brainCorr,faceMem.totalFam,houseMem.totalFam,'FHMem');

clear brainCorr;
brainCorr.name1 = 'R_FFA';
brainCorr.name2 = 'L_HPC';
brainCorr.data = preCorr;
brainCorr.fameFlag = 'Pre';
plotBrainCorrWith2AssociativeMems(brainCorr,pairMem.intactFam,pairMem.intactNFam,'PairMem');
brainCorr.data = famCorr-preCorr;
brainCorr.fameFlag = 'Fam-Pre';
plotBrainCorrWith2AssociativeMems(brainCorr,pairMem.intactFam,pairMem.intactNFam,'PairMem');

brainCorr.preCorr = preCorr;
brainCorr.famCorr = famCorr;
brainCorr.nonfamCorr = nonfamCorr;
plot3BrainCorrWithOnePredictor(brainCorr,age,'Age');
plot3BrainCorrWithOnePredictor(brainCorr,mindActive,'Mind activeness');
plot3BrainCorrWithOnePredictor(brainCorr,emotionEv,'Emotion');
plot3BrainCorrWithOnePredictor(brainCorr,memoryEv,'Memory');
plot3BrainCorrWithOnePredictor(brainCorr,familiarEv,'Familiarity');
plot3BrainCorrWithOnePredictor(brainCorr,attracEv,'Attractiveness');

% plot lffa vs rHPC correlation in postfam nonfam rest
clear brainCorr;
brainCorr.name1 = 'L_FFA';
brainCorr.name2 = 'R_HPC';
[preCorr famCorr nonfamCorr] = getBrainCorrData(brainCorr.name1,brainCorr.name2);
brainCorr.data = preCorr;
brainCorr.fameFlag = 'Fam';
% plot scatter plot bwt brain correlation and associative memory
% performance
% plotBrainCorrWithAssociativeMem(brainCorr,pairMem.intactNFam);
plotBrainCorrWith2AssociativeMems(brainCorr,pairMem.intactFam,pairMem.intactNFam,'PairMemF');
plotBrainCorrWith2AssociativeMems(brainCorr,faceMem.totalNFam,houseMem.totalNFam,'FHMemF');

clear brainCorr;
brainCorr.name1 = 'L_FFA';
brainCorr.name2 = 'R_HPC';
brainCorr.data = famCorr-preCorr;
brainCorr.fameFlag = 'Fam-Pre';
plotBrainCorrWith2AssociativeMems(brainCorr,pairMem.intactFam,pairMem.intactNFam,'PairMemF');

clear brainCorr;
brainCorr.name1 = 'L_FFA';
brainCorr.name2 = 'R_HPC';
brainCorr.data = famCorr;
brainCorr.data2 = preCorr;
brainCorr.fameFlag = 'Prefam';
plotBrainCorrWith2AssociativeMems(brainCorr,pairMem.intactFam,pairMem.intactFam,'PairMemF');





% plot lffa vs rHPC correlation in postfam nonfam rest
clear brainCorr;
brainCorr.name1 = 'L_FFA';
brainCorr.name2 = 'R_HPC';
[preCorr famCorr nonfamCorr] = getBrainCorrData(brainCorr.name1,brainCorr.name2);
% associative reinstatement and identification predict connectivity
[a b c]=glmfit([reinstatementData(:,6),pairMem.intactFam],famCorr);

brainCorr.data = preCorr;
brainCorr.fameFlag = 'NFam';
% plot scatter plot bwt brain correlation and associative memory
% performance
% plotBrainCorrWithAssociativeMem(brainCorr,pairMem.intactNFam);
plotBrainCorrWith2AssociativeMems(brainCorr,pairMem.intactFam,pairMem.intactNFam,'PairMemNF');
plotBrainCorrWith2AssociativeMems(brainCorr,faceMem.totalNFam,houseMem.totalNFam,'FHMemNF');

clear brainCorr;
brainCorr.name1 = 'L_FFA';
brainCorr.name2 = 'R_HPC';
brainCorr.data = nonfamCorr-preCorr;
brainCorr.fameFlag = 'nFam-Pre';
plotBrainCorrWith2AssociativeMems(brainCorr,pairMem.intactFam,pairMem.intactNFam,'PairMemNF');
clear brainCorr;
brainCorr.name1 = 'L_FFA';
brainCorr.name2 = 'R_HPC';
brainCorr.data = preCorr;
brainCorr.data2 = nonfamCorr;
brainCorr.fameFlag = 'PreNfam';
plotBrainCorrWith2AssociativeMems(brainCorr,pairMem.intactNFam,pairMem.intactNFam,'PairMemNF');

% 
clear brainCorr;
brainCorr.name1 = 'L_PPA';
brainCorr.name2 = 'L_TMP';
[preCorr famCorr nonfamCorr] = getBrainCorrData(brainCorr.name1,brainCorr.name2);
statLPpaLAtpl = plot3bars(preCorr,famCorr,nonfamCorr,'L-PPA-L-aTPL',outpath);
[zpfCorrDiff, zpfPval] = ZPFTest(famCorr, pairMem.intactFam,nonfamCorr,pairMem.intactNFam,20)
%z=1.428 p = .15

[a b]=corr(famCorr,age)
brainCorr.data = famCorr-nonfamCorr;
brainCorr.fameFlag = 'postfam-nfam-Wondering';
plotBrainCorrWith2AssociativeMems(brainCorr,mindActive(:,2),mindActive(:,3),brainCorr.fameFlag);
% associative reinstatement and identification predict connectivity
[a b c]=glmfit([reinstatementData(:,6),pairMem.intactFam],famCorr);
[a b c]=glmfit([reinstatementData(:,6),pairMem.recomFam],famCorr);
[a b c]=glmfit([reinstatementData(:,6),pairMem.intactFam,pairMem.recomFam],famCorr)


brainCorr.preCorr = preCorr;
brainCorr.famCorr = famCorr;
brainCorr.nonfamCorr = nonfamCorr;
plot3BrainCorrWithOnePredictor(brainCorr,age,'Age');
plot3BrainCorrWithOnePredictor(brainCorr,mindActive,'Mind activeness');
plot3BrainCorrWithOnePredictor(brainCorr,emotionEv,'Emotion');
plot3BrainCorrWithOnePredictor(brainCorr,memoryEv,'Memory');
plot3BrainCorrWithOnePredictor(brainCorr,familiarEv,'Familiarity');
plot3BrainCorrWithOnePredictor(brainCorr,attracEv,'Attractiveness');

% clear brainCorr;
% brainCorr.name1 = 'L_PPA';
% brainCorr.name2 = 'L_TMP';
% brainCorr.data = famCorr-preCorr;
% brainCorr.data2 = nonfamCorr-preCorr;
% brainCorr.fameFlag = 'post-preWondering';
% plotBrainCorrWith2AssociativeMems(brainCorr,prepostRestInterview(:,11),prepostRestInterview(:,12),'post-preWondering');
% 
% clear brainCorr;
% brainCorr.name1 = 'L_PPA';
% brainCorr.name2 = 'L_TMP';
% brainCorr.data = famCorr;
% brainCorr.data2 = nonfamCorr;
% brainCorr.fameFlag = 'post-wondering';
% plotBrainCorrWith2AssociativeMems(brainCorr,prepostRestInterview(:,11),prepostRestInterview(:,12),brainCorr.fameFlag );


clear brainCorr;
brainCorr.name1 = 'L_PPA';
brainCorr.name2 = 'L_TMP';
brainCorr.data = famCorr;
brainCorr.fameFlag = 'Fam';
% plot scatter plot bwt brain correlation and associative memory
% performance
plotBrainCorrWithAssociativeMem(brainCorr,pairMem.intactFam);
plotBrainCorrWith2AssociativeMems(brainCorr,pairMem.intactFam,pairMem.intactNFam,'PairMem');
%zm=2.343,p=.0191

plotBrainCorrWith2AssociativeMems(brainCorr,faceMem.totalFam,houseMem.totalFam,'FHMem');
clear brainCorr;
brainCorr.name1 = 'L_PPA';
brainCorr.name2 = 'L_TMP';
brainCorr.data = preCorr;
brainCorr.fameFlag = 'Pre';
plotBrainCorrWith2AssociativeMems(brainCorr,pairMem.intactFam,pairMem.intactNFam,'PairMem');
brainCorr.data = famCorr-preCorr;
brainCorr.fameFlag = 'Fam-Pre';
plotBrainCorrWith2AssociativeMems(brainCorr,pairMem.intactFam,pairMem.intactNFam,'PairMem');

clear brainCorr;
brainCorr.name1 = 'R_PPA';
brainCorr.name2 = 'L_TMP';
[preCorr famCorr nonfamCorr] = getBrainCorrData(brainCorr.name1,brainCorr.name2);
statRppaLaTPL = plot3bars(preCorr,famCorr,nonfamCorr,[brainCorr.name1,'-',brainCorr.name2],outpath);

[zpfCorrDiff, zpfPval] = ZPFTest(famCorr, pairMem.intactFam,nonfamCorr,pairMem.intactNFam,20)
%z=1.625 p = .104
brainCorr.preCorr = preCorr;
brainCorr.famCorr = famCorr;
brainCorr.nonfamCorr = nonfamCorr;
plot3BrainCorrWithOnePredictor(brainCorr,age,'Age');
plot3BrainCorrWithOnePredictor(brainCorr,mindActive,'Mind activeness');

brainCorr.data = famCorr-nonfamCorr;
brainCorr.fameFlag = 'postfam-nfam-Wondering';
plotBrainCorrWith2AssociativeMems(brainCorr,mindActive(:,2),mindActive(:,3),brainCorr.fameFlag);


plot3BrainCorrWithOnePredictor(brainCorr,emotionEv,'Emotion');
plot3BrainCorrWithOnePredictor(brainCorr,memoryEv,'Memory');
plot3BrainCorrWithOnePredictor(brainCorr,familiarEv,'Familiarity');
plot3BrainCorrWithOnePredictor(brainCorr,attracEv,'Attractiveness');

clear brainCorr;
brainCorr.name1 = 'R_PPA';
brainCorr.name2 = 'L_TMP';
brainCorr.data = famCorr;
brainCorr.fameFlag = 'Fam';
% plot scatter plot bwt brain correlation and associative memory
% performance
plotBrainCorrWithAssociativeMem(brainCorr,pairMem.intactFam);
plotBrainCorrWith2AssociativeMems(brainCorr,pairMem.intactFam,pairMem.intactNFam,'PairMem');
%Zm=1.326;p=.185
plotBrainCorrWith2AssociativeMems(brainCorr,faceMem.totalFam,houseMem.totalFam,'FHMem');

clear brainCorr;
brainCorr.name1 = 'R_PPA';
brainCorr.name2 = 'L_TMP';
brainCorr.data = preCorr;
brainCorr.fameFlag = 'Pre';
plotBrainCorrWith2AssociativeMems(brainCorr,pairMem.intactFam,pairMem.intactNFam,'PairMem');
clear brainCorr;
brainCorr.name1 = 'R_PPA';
brainCorr.name2 = 'L_TMP';
brainCorr.data = famCorr-preCorr;
brainCorr.fameFlag = 'Fam-Pre';
plotBrainCorrWith2AssociativeMems(brainCorr,pairMem.intactFam,pairMem.intactNFam,'PairMem');

clear brainCorr;
brainCorr.name1 = 'L_FFA';
brainCorr.name2 = 'L_TMP';
[preCorr famCorr nonfamCorr] = getBrainCorrData(brainCorr.name1,brainCorr.name2);
statLffaLaTPL = plot3bars(preCorr,famCorr,nonfamCorr,[brainCorr.name1,'-',brainCorr.name2],outpath);
[zpfCorrDiff, zpfPval] = ZPFTest(famCorr, pairMem.intactFam,nonfamCorr,pairMem.intactNFam,20)
%zpf= 1.251,p=.211
brainCorr.data = famCorr-nonfamCorr;
brainCorr.fameFlag = 'postfam-nfam-Wondering';
plotBrainCorrWith2AssociativeMems(brainCorr,mindActive(:,2),mindActive(:,3),brainCorr.fameFlag);


brainCorr.preCorr = preCorr;
brainCorr.famCorr = famCorr;
brainCorr.nonfamCorr = nonfamCorr;
plot3BrainCorrWithOnePredictor(brainCorr,age,'Age');
plot3BrainCorrWithOnePredictor(brainCorr,mindActive,'Mind activeness');plot3BrainCorrWithOnePredictor(brainCorr,emotionEv,'Emotion');
plot3BrainCorrWithOnePredictor(brainCorr,memoryEv,'Memory');
plot3BrainCorrWithOnePredictor(brainCorr,familiarEv,'Familiarity');
plot3BrainCorrWithOnePredictor(brainCorr,attracEv,'Attractiveness');

brainCorr.data = famCorr;
brainCorr.fameFlag = 'Fam';
% plot scatter plot bwt brain correlation and associative memory
% performance
plotBrainCorrWithAssociativeMem(brainCorr,pairMem.intactFam);
plotBrainCorrWith2AssociativeMems(brainCorr,pairMem.intactFam,pairMem.intactNFam,'PairMem');
%zm = .94 p = .347
plotBrainCorrWith2AssociativeMems(brainCorr,faceMem.totalFam,houseMem.totalFam,'FHMem');
clear brainCorr;
brainCorr.name1 = 'L_FFA';
brainCorr.name2 = 'L_TMP';
brainCorr.data = preCorr;
brainCorr.fameFlag = 'Pre';
plotBrainCorrWith2AssociativeMems(brainCorr,pairMem.intactFam,pairMem.intactNFam,'PairMem');
clear brainCorr;
brainCorr.name1 = 'L_FFA';
brainCorr.name2 = 'L_TMP';
brainCorr.data = famCorr-preCorr;
brainCorr.fameFlag = 'Fam-Pre';
plotBrainCorrWith2AssociativeMems(brainCorr,pairMem.intactFam,pairMem.intactNFam,'PairMem');


clear brainCorr;
brainCorr.name1 = 'L_PPA';
brainCorr.name2 = 'R_TMP';
[preCorr famCorr nonfamCorr] = getBrainCorrData(brainCorr.name1,brainCorr.name2);
statLppaRaTPL = plot3bars(preCorr,famCorr,nonfamCorr,[brainCorr.name1,'-',brainCorr.name2],outpath);
[zpfCorrDiff, zpfPval] = ZPFTest(famCorr, pairMem.intactFam,nonfamCorr,pairMem.intactNFam,20)
%zpf=1.50,p = .134
[a b]=corr(famCorr,age)
brainCorr.data = famCorr-nonfamCorr;
brainCorr.fameFlag = 'postfam-nfam-Wondering';
plotBrainCorrWith2AssociativeMems(brainCorr,mindActive(:,2),mindActive(:,3),brainCorr.fameFlag);

brainCorr.preCorr = preCorr;
brainCorr.famCorr = famCorr;
brainCorr.nonfamCorr = nonfamCorr;
plot3BrainCorrWithOnePredictor(brainCorr,age,'Age');
plot3BrainCorrWithOnePredictor(brainCorr,mindActive,'Mind activeness');
plot3BrainCorrWithOnePredictor(brainCorr,emotionEv,'Emotion');
plot3BrainCorrWithOnePredictor(brainCorr,memoryEv,'Memory');
plot3BrainCorrWithOnePredictor(brainCorr,familiarEv,'Familiarity');
plot3BrainCorrWithOnePredictor(brainCorr,attracEv,'Attractiveness');

brainCorr.data = famCorr;
brainCorr.fameFlag = 'Fam';
% plot scatter plot bwt brain correlation and associative memory
% performance
plotBrainCorrWithAssociativeMem(brainCorr,pairMem.intactFam);
plotBrainCorrWith2AssociativeMems(brainCorr,pairMem.intactFam,pairMem.intactNFam,'PairMem');
%zm=2.13;p=.033
plotBrainCorrWith2AssociativeMems(brainCorr,faceMem.totalFam,houseMem.totalFam,'FHMem');
clear brainCorr;
brainCorr.name1 = 'L_PPA';
brainCorr.name2 = 'R_TMP';
brainCorr.data = preCorr;
brainCorr.fameFlag = 'Pre';
plotBrainCorrWith2AssociativeMems(brainCorr,pairMem.intactFam,pairMem.intactNFam,'PairMem');
clear brainCorr;
brainCorr.name1 = 'L_PPA';
brainCorr.name2 = 'R_TMP';
brainCorr.data = famCorr-preCorr;
brainCorr.fameFlag = 'Fam-Pre';
plotBrainCorrWith2AssociativeMems(brainCorr,pairMem.intactFam,pairMem.intactNFam,'PairMem');


clear preCorr; 
clear famCorr;
clear nonfamCorr;
clear brainCorr;
brainCorr.name1 ='AAL.Hippocampus (L)_1_1';
brainCorr.name2 ='AAL.Precuneus (R)_1_1';
[preCorr famCorr nonfamCorr] = getBrainCorrData(brainCorr.name1,brainCorr.name2);
stathpcPrecu = plot3bars(preCorr,famCorr,nonfamCorr,[brainCorr.name1,'-',brainCorr.name2],outpath);
brainCorr.data = famCorr-nonfamCorr;
brainCorr.fameFlag = 'postfam-nfam-Wondering';
plotBrainCorrWith2AssociativeMems(brainCorr,mindActive(:,2),mindActive(:,3),brainCorr.fameFlag);

brainCorr.preCorr = preCorr;
brainCorr.famCorr = famCorr;
brainCorr.nonfamCorr = nonfamCorr;
plot3BrainCorrWithOnePredictor(brainCorr,age,'Age');
plot3BrainCorrWithOnePredictor(brainCorr,mindActive,'Mind activeness');
plot3BrainCorrWithOnePredictor(brainCorr,emotionEv,'Emotion');
plot3BrainCorrWithOnePredictor(brainCorr,memoryEv,'Memory');
plot3BrainCorrWithOnePredictor(brainCorr,familiarEv,'Familiarity');
plot3BrainCorrWithOnePredictor(brainCorr,attracEv,'Attractiveness');


brainCorr.data = famCorr;
brainCorr.fameFlag = 'Fam';
plotBrainCorrWith2AssociativeMems(brainCorr,faceMem.totalFam,houseMem.totalFam,'FHMem');
clear brainCorr;
brainCorr.name1 ='AAL.Hippocampus (L)_1_1';
brainCorr.name2 ='AAL.Precuneus (R)_1_1';
brainCorr.data = famCorr-preCorr;
brainCorr.fameFlag = 'Fam-Pre';
plotBrainCorrWith2AssociativeMems(brainCorr,pairMem.intactFam,pairMem.intactNFam,'PairMem');
clear brainCorr;
brainCorr.name1 ='AAL.Hippocampus (L)_1_1';
brainCorr.name2 ='AAL.Precuneus (R)_1_1';
brainCorr.data = famCorr;
brainCorr.fameFlag = 'Fam';
% plot scatter plot bwt brain correlation and associative memory
% performance
plotBrainCorrWithAssociativeMem(brainCorr,pairMem.intactFam);


clear preCorr; 
clear famCorr;
clear nonfamCorr;
clear brainCorr;
brainCorr.name1 ='AAL.Hippocampus (L)_1_1';
brainCorr.name2 ='AAL.Precuneus (L)_1_1';
[preCorr famCorr nonfamCorr] = getBrainCorrData(brainCorr.name1,brainCorr.name2);
stathpcPrecuL = plot3bars(preCorr,famCorr,nonfamCorr,[brainCorr.name1,'-',brainCorr.name2],outpath);
brainCorr.data = famCorr-nonfamCorr;
brainCorr.fameFlag = 'postfam-nfam-Wondering';
plotBrainCorrWith2AssociativeMems(brainCorr,mindActive(:,2),mindActive(:,3),brainCorr.fameFlag);

brainCorr.preCorr = preCorr;
brainCorr.famCorr = famCorr;
brainCorr.nonfamCorr = nonfamCorr;
plot3BrainCorrWithOnePredictor(brainCorr,age,'Age');
plot3BrainCorrWithOnePredictor(brainCorr,mindActive,'Mind activeness');
plot3BrainCorrWithOnePredictor(brainCorr,emotionEv,'Emotion');
plot3BrainCorrWithOnePredictor(brainCorr,memoryEv,'Memory');
plot3BrainCorrWithOnePredictor(brainCorr,familiarEv,'Familiarity');
plot3BrainCorrWithOnePredictor(brainCorr,attracEv,'Attractiveness');


brainCorr.data = famCorr;
brainCorr.fameFlag = 'Fam';
plotBrainCorrWith2AssociativeMems(brainCorr,faceMem.totalFam,houseMem.totalFam,'FHMem');

clear brainCorr;
brainCorr.name1 ='AAL.Hippocampus (L)_1_1';
brainCorr.name2 ='AAL.Precuneus (L)_1_1';
brainCorr.data = famCorr;
brainCorr.fameFlag = 'Fam';
% plot scatter plot bwt brain correlation and associative memory
% performance
plotBrainCorrWithAssociativeMem(brainCorr,pairMem.intactFam);

clear brainCorr;
brainCorr.name1 ='AAL.Hippocampus (L)_1_1';
brainCorr.name2 ='AAL.Cingulum Mid (R)_1_1';
[preCorr famCorr nonfamCorr] = getBrainCorrData(brainCorr.name1,brainCorr.name2);
stathpcCingu = plot3bars(preCorr,famCorr,nonfamCorr,[brainCorr.name1,'-',brainCorr.name2],outpath);
brainCorr.preCorr = preCorr;
brainCorr.famCorr = famCorr;
brainCorr.nonfamCorr = nonfamCorr;
plot3BrainCorrWithOnePredictor(brainCorr,age,'Age');
plot3BrainCorrWithOnePredictor(brainCorr,mindActive,'Mind activeness');
plot3BrainCorrWithOnePredictor(brainCorr,emotionEv,'Emotion');
plot3BrainCorrWithOnePredictor(brainCorr,memoryEv,'Memory');
plot3BrainCorrWithOnePredictor(brainCorr,familiarEv,'Familiarity');
plot3BrainCorrWithOnePredictor(brainCorr,attracEv,'Attractiveness');

brainCorr.data = famCorr;
brainCorr.fameFlag = 'Fam';
plotBrainCorrWith2AssociativeMems(brainCorr,faceMem.totalFam,houseMem.totalFam,'FHMem');

% plot scatter plot bwt brain correlation and associative memory
% performance
plotBrainCorrWithAssociativeMem(brainCorr,pairMem.intactFam);
plotBrainCorrWith2AssociativeMems(brainCorr,pairMem.intactFam,pairMem.intactNFam,'PairMem');

clear brainCorr;
brainCorr.name1 ='AAL.Hippocampus (L)_1_1';
brainCorr.name2 ='AAL.Frontal Sup Orb (R)_1_1';
[preCorr famCorr nonfamCorr] = getBrainCorrData(brainCorr.name1,brainCorr.name2);
stathpcFrontsuporb = plot3bars(preCorr,famCorr,nonfamCorr,[brainCorr.name1,'-',brainCorr.name2],outpath);
brainCorr.preCorr = preCorr;
brainCorr.famCorr = famCorr;
brainCorr.nonfamCorr = nonfamCorr;
plot3BrainCorrWithOnePredictor(brainCorr,age,'Age');
plot3BrainCorrWithOnePredictor(brainCorr,mindActive,'Mind activeness');
plot3BrainCorrWithOnePredictor(brainCorr,emotionEv,'Emotion');
plot3BrainCorrWithOnePredictor(brainCorr,memoryEv,'Memory');
plot3BrainCorrWithOnePredictor(brainCorr,familiarEv,'Familiarity');
plot3BrainCorrWithOnePredictor(brainCorr,attracEv,'Attractiveness');

clear brainCorr;
brainCorr.name1 ='AAL.Hippocampus (L)_1_1';
brainCorr.name2 ='AAL.Frontal Sup Orb (R)_1_1';
brainCorr.data = famCorr;
brainCorr.fameFlag = 'Fam';
plotBrainCorrWith2AssociativeMems(brainCorr,faceMem.totalFam,houseMem.totalFam,'FHMem');

% plot scatter plot bwt brain correlation and associative memory
% performance
plotBrainCorrWithAssociativeMem(brainCorr,pairMem.intactFam);
plotBrainCorrWith2AssociativeMems(brainCorr,pairMem.intactFam,pairMem.intactNFam,'PairMem');

clear brainCorr;
brainCorr.name1 ='AAL.Temporal Pole Sup (L)_1_1';
brainCorr.name2 ='AAL.Precuneus (R)_1_1';
[preCorr famCorr nonfamCorr] = getBrainCorrData(brainCorr.name1,brainCorr.name2);
stathpcPrecuR = plot3bars(preCorr,famCorr,nonfamCorr,[brainCorr.name1,'-',brainCorr.name2],outpath);

brainCorr.preCorr = preCorr;
brainCorr.famCorr = famCorr;
brainCorr.nonfamCorr = nonfamCorr;
plot3BrainCorrWithOnePredictor(brainCorr,age,'Age');
plot3BrainCorrWithOnePredictor(brainCorr,mindActive,'Mind activeness');
plot3BrainCorrWithOnePredictor(brainCorr,emotionEv,'Emotion');
plot3BrainCorrWithOnePredictor(brainCorr,memoryEv,'Memory');
plot3BrainCorrWithOnePredictor(brainCorr,familiarEv,'Familiarity');
plot3BrainCorrWithOnePredictor(brainCorr,attracEv,'Attractiveness');

brainCorr.data = famCorr;
brainCorr.fameFlag = 'Fam';
plotBrainCorrWith2AssociativeMems(brainCorr,faceMem.totalFam,houseMem.totalFam,'FHMem');

% plot scatter plot bwt brain correlation and associative memory
% performance
plotBrainCorrWithAssociativeMem(brainCorr,pairMem.intactFam);

clear brainCorr;
brainCorr.name1 ='AAL.Frontal Inf Tri (L)_1_1';
brainCorr.name2 ='AAL.Calcarine (L)_1_1';
[preCorr famCorr nonfamCorr] = getBrainCorrData(brainCorr.name1,brainCorr.name2);
statFrontCalc = plot3bars(preCorr,famCorr,nonfamCorr,[brainCorr.name1,'-',brainCorr.name2],outpath);
brainCorr.preCorr = preCorr;
brainCorr.famCorr = famCorr;
brainCorr.nonfamCorr = nonfamCorr;
plot3BrainCorrWithOnePredictor(brainCorr,age,'Age');
plot3BrainCorrWithOnePredictor(brainCorr,mindActive,'Mind activeness');
plot3BrainCorrWithOnePredictor(brainCorr,emotionEv,'Emotion');
plot3BrainCorrWithOnePredictor(brainCorr,memoryEv,'Memory');
plot3BrainCorrWithOnePredictor(brainCorr,familiarEv,'Familiarity');
plot3BrainCorrWithOnePredictor(brainCorr,attracEv,'Attractiveness');

brainCorr.data = famCorr;
brainCorr.fameFlag = 'Fam';
plotBrainCorrWith2AssociativeMems(brainCorr,faceMem.totalFam,houseMem.totalFam,'FHMem');

% plot scatter plot bwt brain correlation and associative memory
% performance
plotBrainCorrWithAssociativeMem(brainCorr,pairMem.intactFam);


%**************************************************************************
%*******Controlling pre, post-encoding correlations predict memory*********
%**************************************************************************
brainCorr.name1 = 'R_FFA';
brainCorr.name2 = 'L_HPC';
[preCorr famCorr nonfamCorr] = getBrainCorrData(brainCorr.name1,brainCorr.name2);

brainCorr.data = famCorr-preCorr;
brainCorr.fameFlag = 'Fam-controlPre';
% plot scatter plot bwt brain correlation and associative memory
% performance
plotBrainCorrWithAssociativeMem(brainCorr,pairMem.intactFam);
% corrResults = robust_correlation(brainCorr.data,pairMem.intactFam-pairMem.intactNFam);

brainCorr.name1 = 'L_PPA';
brainCorr.name2 = 'L_TMP';
[preCorr famCorr nonfamCorr] = getBrainCorrData(brainCorr.name1,brainCorr.name2);

brainCorr.data = famCorr-preCorr;
brainCorr.fameFlag = 'Fam-controlPre';
% plot scatter plot bwt brain correlation and associative memory
% performance
plotBrainCorrWithAssociativeMem(brainCorr,pairMem.intactFam);
% corrResults = robust_correlation(brainCorr.data,pairMem.intactFam-pairMem.intactNFam);


%**************************************************************************
%******* post-encoding correlation diff predict memory diff *********
%**************************************************************************
brainCorr.name1 = 'R_PPA';
brainCorr.name2 = 'L_TMP';
[preCorr famCorr nonfamCorr] = getBrainCorrData(brainCorr.name1,brainCorr.name2);

brainCorr.data = famCorr-nonfamCorr;
brainCorr.fameFlag = 'Fam-NFam';
% plot scatter plot bwt brain correlation and associative memory
% performance
plotBrainCorrWithAssociativeMem(brainCorr,pairMem.intactFam-pairMem.intactNFam);
% corrResults = robust_correlation(brainCorr.data,pairMem.intactFam-pairMem.intactNFam);
x1=brainCorr.data;
x2=pairMem.intactFam-pairMem.intactNFam
x1(10)=[];
x2(10)=[];
[h p]=corr(x1,x2)


brainCorr.name1 = 'R_PPA';
brainCorr.name2 = 'R_TMP';
[preCorr famCorr nonfamCorr] = getBrainCorrData(brainCorr.name1,brainCorr.name2);

brainCorr.data = famCorr-nonfamCorr;
brainCorr.fameFlag = 'Fam-NFam';
% plot scatter plot bwt brain correlation and associative memory
% performance
plotBrainCorrWithAssociativeMem(brainCorr,pairMem.intactFam-pairMem.intactNFam);
x1=brainCorr.data;
x2=pairMem.intactFam-pairMem.intactNFam;



brainCorr.name1 = 'L_HPC';
brainCorr.name2 = 'L_vmP';
[preCorr famCorr nonfamCorr] = getBrainCorrData(brainCorr.name1,brainCorr.name2);

brainCorr.data = famCorr-nonfamCorr;
brainCorr.fameFlag = 'Fam-NFam';
% plot scatter plot bwt brain correlation and associative memory
% performance
plotBrainCorrWithAssociativeMem(brainCorr,pairMem.intactFam-pairMem.intactNFam);
% corrResults = robust_correlation(brainCorr.data,pairMem.intactFam-pairMem.intactNFam);


brainCorr.name1 = 'R_PPA';
brainCorr.name2 = 'R_HPC';
[preCorr famCorr nonfamCorr] = getBrainCorrData(brainCorr.name1,brainCorr.name2);

brainCorr.data = famCorr-nonfamCorr;
brainCorr.fameFlag = 'Fam-NFam';
% plot scatter plot bwt brain correlation and associative memory
% performance
plotBrainCorrWithAssociativeMem(brainCorr,pairMem.intactFam-pairMem.intactNFam);
% corrResults = robust_correlation(brainCorr.data,pairMem.intactFam-pairMem.intactNFam);


brainCorr.name1 = 'L_PPA';
brainCorr.name2 = 'L_TMP';
[preCorr famCorr nonfamCorr] = getBrainCorrData(brainCorr.name1,brainCorr.name2);

brainCorr.data = famCorr-nonfamCorr;
brainCorr.fameFlag = 'Fam-NFam';
% plot scatter plot bwt brain correlation and associative memory
% performance
plotBrainCorrWithAssociativeMem(brainCorr,pairMem.intactFam-pairMem.intactNFam);
% corrResults = robust_correlation(brainCorr.data,pairMem.intactFam-pairMem.intactNFam);

nodeDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\matlabFunctions\';
roiDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelAnalysis\picEffect_Pic-Scramble\';
BrainNet_MapCfg('BrainMesh_ICBM152_tal.nv',[roiDir,'allFunctionalROI.img'],[nodeDir,'postEncodingFamPredictMem.node'],...
    [nodeDir,'postEncodingFamPredictMem.edge'],[nodeDir,'postEncodingBrainNetNewSetupOption_anteriorTop.mat'],...
    [outpath,'postEncodingFamPredictMem.jpg']);



BrainNet_MapCfg('BrainMesh_ICBM152_tal.nv',[roiDir,'allFunctionalROI.img'],[nodeDir,'postEncodingDiff.node'],...
    [nodeDir,'postEncodingDiff.edge'],[nodeDir,'postEncodingBrainNetNewSetupOption_anteriorTop.mat'],...
    [outpath,'postEncodingFamNfamDiff.jpg']);

BrainNet_MapCfg('BrainMesh_ICBM152_tal.nv',[roiDir,'allFunctionalROI.img'],[nodeDir,'postEncodingNonFamPredictMem.node'],...
    [nodeDir,'postEncodingNonFamPredictMem.edge'],[nodeDir,'postEncodingBrainNetNewSetupOption_anteriorTop.mat'],...
    [outpath,'postEncodingNonFamPredictMem.jpg']);

BrainNet_MapCfg('BrainMesh_ICBM152_tal.nv',[roiDir,'allFunctionalROI.img'],[nodeDir,'postEncodingFamPredictMemControlPre.node'],...
    [nodeDir,'postEncodingFemPredictMemControlPre.edge'],[nodeDir,'postEncodingBrainNetNewSetupOption_anteriorTop.mat'],...
    [outpath,'postEncodingFamPredictMemControlPre.jpg']);


BrainNet_MapCfg('BrainMesh_ICBM152_tal.nv',[roiDir,'allFunctionalROI.img'],[nodeDir,'postEncodingConnectDiffPredictMemDiff_novmpfc.node'],...
    [nodeDir,'postEncodingConnectDiffPredictMemDiff_novmpfc.edge'],[nodeDir,'postEncodingBrainNetNewSetupOption_anteriorTop.mat'],...
    [outpath,'postEncodingConnectDiffPredictMemDiff_novmpfc.jpg']);


 BrainNet_MapCfg('BrainMesh_ICBM152_tal.nv',[roiDir,'allFunctionalROI.img'],[nodeDir,'postEncodingBrainNetNewSetupOption_anteriorTop.mat'],...
     [outpath,'ROIs.jpg']);

 
 %prerest l hpc see-to-voxel brain net figure
 inputDir = 'D:\myStudy\picpairfMRI\postEncodingRest\conn_restingConnectivity\results\secondlevel\ANALYSIS_01.SUBJECT_EFFECTS_subjAll.CONDITIONS_preRest\AAL.Hippocampus_(L)_1_1\';
dataTImage = [inputDir, 'spmT_0001.img'];
% p=.005 threshold
savefigName = 'prerest-hpc-l-001';
savefigNote = [dataTImage,'___',savefigName];
outpath = 'C:\Users\Zhongxu\Dropbox\picpair\PicparBehavioralmanuscript\postEncodingfMRIPub\figures\';

outDir = outpath;
makeBrainNetSurfacePlot(dataTImage,savefigName,savefigNote,outDir,...
                     2.861, 10,'MediumView', 10); %'MediumView' 3.58 p = .001
                 
 
%prerest r hpc see-to-voxel brain net figure                
 inputDir = 'D:\myStudy\picpairfMRI\postEncodingRest\conn_restingConnectivity\results\secondlevel\ANALYSIS_01.SUBJECT_EFFECTS_subjAll.CONDITIONS_preRest\AAL.Hippocampus_(R)_1_1\';
dataTImage = [inputDir, 'spmT_0001.img'];
% p=.005 threshold
savefigName = 'prerest-hpc-r-001';
savefigNote = [dataTImage,'___',savefigName];
outpath = 'C:\Users\Zhongxu\Dropbox\picpair\PicparBehavioralmanuscript\postEncodingfMRIPub\figures\';

outDir = outpath;
makeBrainNetSurfacePlot(dataTImage,savefigName,savefigNote,outDir,...
                     2.861, 10,'MediumView', 10); %'MediumView' 
                 

%postfam l hpc see-to-voxel brain net figure
 inputDir = 'D:\myStudy\picpairfMRI\postEncodingRest\conn_restingConnectivity\results\secondlevel\ANALYSIS_01.SUBJECT_EFFECTS_subjAll.CONDITIONS_postFam\AAL.Hippocampus_(L)_1_1\';
dataTImage = [inputDir, 'spmT_0001.img'];
% p=.005 threshold
savefigName = 'postfam-hpc-l-001';
savefigNote = [dataTImage,'___',savefigName];
outpath = 'C:\Users\Zhongxu\Dropbox\picpair\PicparBehavioralmanuscript\postEncodingfMRIPub\figures\';

outDir = outpath;
makeBrainNetSurfacePlot(dataTImage,savefigName,savefigNote,outDir,...
                     2.861, 10,'MediumView', 10); %'MediumView'                  
                 
%postfam r hpc see-to-voxel brain net figure
 inputDir = 'D:\myStudy\picpairfMRI\postEncodingRest\conn_restingConnectivity\results\secondlevel\ANALYSIS_01.SUBJECT_EFFECTS_subjAll.CONDITIONS_postFam\AAL.Hippocampus_(R)_1_1\';
dataTImage = [inputDir, 'spmT_0001.img'];
% p=.005 threshold
savefigName = 'postfam-hpc-r-001';
savefigNote = [dataTImage,'___',savefigName];
outpath = 'C:\Users\Zhongxu\Dropbox\picpair\PicparBehavioralmanuscript\postEncodingfMRIPub\figures\';

outDir = outpath;
makeBrainNetSurfacePlot(dataTImage,savefigName,savefigNote,outDir,...
                     2.861, 10,'MediumView', 10); %'MediumView'                   
                 
                 
                 
%postnonfam l hpc see-to-voxel brain net figure
 inputDir = 'D:\myStudy\picpairfMRI\postEncodingRest\conn_restingConnectivity\results\secondlevel\ANALYSIS_01.SUBJECT_EFFECTS_subjAll.CONDITIONS_postNonFam\AAL.Hippocampus_(L)_1_1\';
dataTImage = [inputDir, 'spmT_0001.img'];
% p=.005 threshold
savefigName = 'postnonfam-hpc-l-001';
savefigNote = [dataTImage,'___',savefigName];
outpath = 'C:\Users\Zhongxu\Dropbox\picpair\PicparBehavioralmanuscript\postEncodingfMRIPub\figures\';

outDir = outpath;
makeBrainNetSurfacePlot(dataTImage,savefigName,savefigNote,outDir,...
                     2.861, 10,'MediumView', 10); %'MediumView'                    
                 
                 
                 
%postnonfam r hpc see-to-voxel brain net figure
 inputDir = 'D:\myStudy\picpairfMRI\postEncodingRest\conn_restingConnectivity\results\secondlevel\ANALYSIS_01.SUBJECT_EFFECTS_subjAll.CONDITIONS_postNonFam\AAL.Hippocampus_(R)_1_1\';
dataTImage = [inputDir, 'spmT_0001.img'];
% p=.005 threshold
savefigName = 'postnonfam-hpc-r-001';
savefigNote = [dataTImage,'___',savefigName];
outpath = 'C:\Users\Zhongxu\Dropbox\picpair\PicparBehavioralmanuscript\postEncodingfMRIPub\figures\';

outDir = outpath;
makeBrainNetSurfacePlot(dataTImage,savefigName,savefigNote,outDir,...
                     2.861, 10,'MediumView', 10); %'MediumView'                    
                 
                 
                 
%postfam-nonfam l hpc see-to-voxel brain net figure
 inputDir = 'D:\myStudy\picpairfMRI\postEncodingRest\conn_restingConnectivity\results\secondlevel\ANALYSIS_01.SUBJECT_EFFECTS_subjAll.CONDITIONS_postFam(1.0).postNonFam(-1.0)\AAL.Hippocampus_(L)_1_1\';
dataTImage = [inputDir, 'spmT_0001.img'];
% p=.005 threshold
savefigName = 'postfam-nonfam-hpc-l-005';
savefigNote = [dataTImage,'___',savefigName];
outpath = 'C:\Users\Zhongxu\Dropbox\picpair\PicparBehavioralmanuscript\postEncodingfMRIPub\figures\';

outDir = outpath;
makeBrainNetSurfacePlot(dataTImage,savefigName,savefigNote,outDir,...
                     2.861, 5,'MediumView', 10); %'MediumView'                    
                                  
%postfam-nonfam r hpc see-to-voxel brain net figure
 inputDir = 'D:\myStudy\picpairfMRI\postEncodingRest\conn_restingConnectivity\results\secondlevel\ANALYSIS_01.SUBJECT_EFFECTS_subjAll.CONDITIONS_postFam(1.0).postNonFam(-1.0)\AAL.Hippocampus_(R)_1_1\';
dataTImage = [inputDir, 'spmT_0001.img'];
% p=.005 threshold
savefigName = 'postfam-nonfam-hpc-r-005';
savefigNote = [dataTImage,'___',savefigName];
outpath = 'C:\Users\Zhongxu\Dropbox\picpair\PicparBehavioralmanuscript\postEncodingfMRIPub\figures\';

outDir = outpath;
makeBrainNetSurfacePlot(dataTImage,savefigName,savefigNote,outDir,...
                     2.861, 5,'MediumView', 10); %'MediumView'                    
                 
                 
%postfam-nonfam l hpc see-to-voxel predict fampairmem brain net figure
 inputDir = 'D:\myStudy\picpairfMRI\postEncodingRest\conn_restingConnectivity\results\secondlevel\ANALYSIS_01.SUBJECT_EFFECTS_subjAll(0.0).famIntactPairMemNoOutliers(1.0).CONDITIONS_postFam\AAL.Hippocampus_(L)_1_1\';
dataTImage = [inputDir, 'spmT_0001.img'];
% p=.005 threshold
savefigName = 'lhpc-postfam-predict-fampairmem005';
savefigNote = [dataTImage,'___',savefigName];
outpath = 'C:\Users\Zhongxu\Dropbox\picpair\PicparBehavioralmanuscript\postEncodingfMRIPub\figures\';

outDir = outpath;
makeBrainNetSurfacePlot(dataTImage,savefigName,savefigNote,outDir,...
                     2.878, 4,'MediumView', 10); %'MediumView'   
                 
 inputDir = 'D:\myStudy\picpairfMRI\postEncodingRest\conn_restingConnectivity\results\secondlevel\ANALYSIS_01.SUBJECT_EFFECTS_subjAll(0.0).famIntactPairMemNoOutliers(1.0).CONDITIONS_postFam\AAL.Hippocampus_(R)_1_1\';
dataTImage = [inputDir, 'spmT_0001.img'];
% p=.005 threshold
savefigName = 'rhpc-postfam-predict-fampairmem005';
savefigNote = [dataTImage,'___',savefigName];
outpath = 'C:\Users\Zhongxu\Dropbox\picpair\PicparBehavioralmanuscript\postEncodingfMRIPub\figures\';

outDir = outpath;
makeBrainNetSurfacePlot(dataTImage,savefigName,savefigNote,outDir,...
                     2.878, 4,'MediumView', 10); %'MediumView'   
                 
                 
%postnonfam l hpc see-to-voxel predict fampairmem brain net figure
 inputDir = 'D:\myStudy\picpairfMRI\postEncodingRest\conn_restingConnectivity\results\secondlevel\ANALYSIS_01.SUBJECT_EFFECTS_subjAll(0.0).NfamIntactPairMemNoOutlier(1.0).CONDITIONS_postNonFam\AAL.Hippocampus_(L)_1_1\';
dataTImage = [inputDir, 'spmT_0001.img'];
% p=.005 threshold
savefigName = 'lhpc-postNfam-predict-Nfampairmem005';
savefigNote = [dataTImage,'___',savefigName];
outpath = 'C:\Users\Zhongxu\Dropbox\picpair\PicparBehavioralmanuscript\postEncodingfMRIPub\figures\';

outDir = outpath;
makeBrainNetSurfacePlot(dataTImage,savefigName,savefigNote,outDir,...
                     2.878, 4,'MediumView', 10); %'MediumView'
                 
                 
    
                 
%postfam-nonfam l hpc see-to-voxel predict fampairmem brain net figure
 inputDir = 'D:\myStudy\picpairfMRI\postEncodingRest\conn_restingConnectivity\results\secondlevel\ANALYSIS_01.SUBJECT_EFFECTS_subjAll(0.0).NfamIntactPairMemNoOutlier(1.0).CONDITIONS_postNonFam\AAL.Hippocampus_(R)_1_1\';
dataTImage = [inputDir, 'spmT_0001.img'];
% p=.005 threshold
savefigName = 'rhpc-postNfam-predict-Nfampairmem005';
savefigNote = [dataTImage,'___',savefigName];
outpath = 'C:\Users\Zhongxu\Dropbox\picpair\PicparBehavioralmanuscript\postEncodingfMRIPub\figures\';

outDir = outpath;
makeBrainNetSurfacePlot(dataTImage,savefigName,savefigNote,outDir,...
                     2.878, 4,'MediumView', 10); %'MediumView'                 
                 
                 
%postnonfam l hpc see-to-voxel fam-nonfam vs mindactive
 inputDir = 'D:\myStudy\picpairfMRI\postEncodingRest\conn_restingConnectivity\results\secondlevel\ANALYSIS_01.SUBJECT_EFFECTS_subjAll(0.0).famMindActive(1.0).CONDITIONS_postFam(1.0).postNonFam(-1.0)\AAL.Hippocampus_(L)_1_1\';
dataTImage = [inputDir, 'spmT_0001.img'];
% p=.005 threshold
savefigName = 'lhpc-postfam-Nfam-predict-mindactive005';
savefigNote = [dataTImage,'___',savefigName];
outpath = 'C:\Users\Zhongxu\Dropbox\picpair\PicparBehavioralmanuscript\postEncodingfMRIPub\figures\';

outDir = outpath;
makeBrainNetSurfacePlot(dataTImage,savefigName,savefigNote,outDir,...
                     2.878, 4,'MediumView', 10); %'MediumView'
                                  

%postnonfam l hpc see-to-voxel fam-nonfam vs mindactive
 inputDir = 'D:\myStudy\picpairfMRI\postEncodingRest\conn_restingConnectivity\results\secondlevel\ANALYSIS_01.SUBJECT_EFFECTS_subjAll(0.0).famMindActive(1.0).CONDITIONS_postFam(1.0).postNonFam(-1.0)\AAL.Hippocampus_(R)_1_1\';
dataTImage = [inputDir, 'spmT_0001.img'];
% p=.005 threshold
savefigName = 'rhpc-postfam-Nfam-predict-mindactive005';
savefigNote = [dataTImage,'___',savefigName];
outpath = 'C:\Users\Zhongxu\Dropbox\picpair\PicparBehavioralmanuscript\postEncodingfMRIPub\figures\';

outDir = outpath;
makeBrainNetSurfacePlot(dataTImage,savefigName,savefigNote,outDir,...
                     2.878, 4,'MediumView', 10); %'MediumView'
                              
                 
                 
maskDir = 'D:\myStudy\picpairfMRI\postEncodingRest\conn_restingConnectivity\results\secondlevel\';
maskFile = [maskDir,'rhpc-lffa-positiveFamMem-mask.img'];
[mValHPCL mValHPCR] = extractMeanConnUsingRex(maskFile);
preCorr = mValHPCR(:,1);
famCorr = mValHPCR(:,2);
nonfamCorr = mValHPCR(:,3);

brainCorr.name1 ='rhpc';
brainCorr.name2 ='lffa';

statFrontCalc = plot3bars(preCorr,famCorr,nonfamCorr,[brainCorr.name1,'-',brainCorr.name2],outpath);
brainCorr.data = famCorr;
brainCorr.data2 = nonfamCorr;
brainCorr.fameFlag = 'FamRhpcLffaSeedVoxel';
plotBrainCorrWith2AssociativeMems(brainCorr,pairMem.intactFam,pairMem.intactNFam,'PairMem');    


maskDir = 'D:\myStudy\picpairfMRI\postEncodingRest\conn_restingConnectivity\results\secondlevel\';
maskFile = [maskDir,'lhpc-lfrontalpole-positivePredictNFampareMem-mask.img'];
[mValHPCL mValHPCR] = extractMeanConnUsingRex(maskFile);
preCorr = mValHPCL(:,1);
famCorr = mValHPCL(:,2);
nonfamCorr = mValHPCL(:,3);

brainCorr.name1 ='lhpc';
brainCorr.name2 ='lpfcPole';

statFrontpole = plot3bars(preCorr,famCorr,nonfamCorr,[brainCorr.name1,'-',brainCorr.name2],outpath);
brainCorr.data = famCorr;
brainCorr.data2 = nonfamCorr;
brainCorr.fameFlag = 'FamLhpcLPFCPoleSeedVoxel';
plotBrainCorrWith2AssociativeMems(brainCorr,pairMem.intactFam,pairMem.intactNFam,'PairMem');  


maskDir = 'D:\myStudy\picpairfMRI\postEncodingRest\conn_restingConnectivity\results\secondlevel\';
maskFile = [maskDir,'lhpc-lsupfront-postivePredictNFamPairmem-mask.img'];
[mValHPCL mValHPCR] = extractMeanConnUsingRex(maskFile);
preCorr = mValHPCL(:,1);
famCorr = mValHPCL(:,2);
nonfamCorr = mValHPCL(:,3);

brainCorr.name1 ='lhpc';
brainCorr.name2 ='lpfcsup';

statFrontsup = plot3bars(preCorr,famCorr,nonfamCorr,[brainCorr.name1,'-',brainCorr.name2],outpath);
brainCorr.data = famCorr;
brainCorr.data2 = nonfamCorr;
brainCorr.fameFlag = 'FamLhpcLPFCsupSeedVoxel';
plotBrainCorrWith2AssociativeMems(brainCorr,pairMem.intactFam,pairMem.intactNFam,'PairMem');


maskDir = 'D:\myStudy\picpairfMRI\postEncodingRest\conn_restingConnectivity\results\secondlevel\';
maskFile = [maskDir,'rhpc-latpl-postivepredictFamPairMem.img'];
[mValHPCL mValHPCR] = extractMeanConnUsingRex(maskFile);
preCorr = mValHPCR(:,1);
famCorr = mValHPCR(:,2);
nonfamCorr = mValHPCR(:,3);

brainCorr.name1 ='rhpc';
brainCorr.name2 ='latplSTV';

statlatprhpc = plot3bars(preCorr,famCorr,nonfamCorr,[brainCorr.name1,'-',brainCorr.name2],outpath);
brainCorr.data = famCorr;
brainCorr.data2 = nonfamCorr;
brainCorr.fameFlag = 'FamRhpcLaTPLSeedVoxel';
plotBrainCorrWith2AssociativeMems(brainCorr,pairMem.intactFam,pairMem.intactNFam,'PairMem');
brainCorr.preCorr = preCorr;
brainCorr.famCorr = famCorr;
brainCorr.nonfamCorr = nonfamCorr;
plot3BrainCorrWithOnePredictor(brainCorr,age,'Age');
plot3BrainCorrWithOnePredictor(brainCorr,mindActive,'Mind activeness');
plot3BrainCorrWithOnePredictor(brainCorr,emotionEv,'Emotion');
plot3BrainCorrWithOnePredictor(brainCorr,memoryEv,'Memory');



maskDir = 'D:\myStudy\picpairfMRI\postEncodingRest\conn_restingConnectivity\results\secondlevel\';
maskFile = [maskDir,'rhpc-rfrontalpole-positivePredictNfamPairMem.img'];
[mValHPCL mValHPCR] = extractMeanConnUsingRex(maskFile);
preCorr = mValHPCR(:,1);
famCorr = mValHPCR(:,2);
nonfamCorr = mValHPCR(:,3);

brainCorr.name1 ='rhpc';
brainCorr.name2 ='rPFCPoleSTV';

statpfcpolerhpc = plot3bars(preCorr,famCorr,nonfamCorr,[brainCorr.name1,'-',brainCorr.name2],outpath);
brainCorr.data = famCorr;
brainCorr.data2 = nonfamCorr;
brainCorr.fameFlag = 'FamRhpcLPFCPoleSeedVoxel';
plotBrainCorrWith2AssociativeMems(brainCorr,pairMem.intactFam,pairMem.intactNFam,'PairMem');



maskDir = 'D:\myStudy\picpairfMRI\postEncodingRest\conn_restingConnectivity\results\secondlevel\';
maskFile = [maskDir,'rhpc-rcentral-positivePredictNfamPairMem.img'];
[mValHPCL mValHPCR] = extractMeanConnUsingRex(maskFile);
preCorr = mValHPCR(:,1);
famCorr = mValHPCR(:,2);
nonfamCorr = mValHPCR(:,3);

brainCorr.name1 ='rhpc';
brainCorr.name2 ='rcentralLobuleSTV';

statprecetralrhpc = plot3bars(preCorr,famCorr,nonfamCorr,[brainCorr.name1,'-',brainCorr.name2],outpath);
brainCorr.data = famCorr;
brainCorr.data2 = nonfamCorr;
brainCorr.fameFlag = 'FamRhpcRcentralLobuleSeedVoxel';
plotBrainCorrWith2AssociativeMems(brainCorr,pairMem.intactFam,pairMem.intactNFam,'PairMem');




function [tval pval pcomp statscomp,encodingCorr4run]= controlEncodingCorrInPostCorrPrediction(brainCorr,pairMem)
[preCorr famCorr nonfamCorr] = getBrainCorrData(brainCorr.name1,brainCorr.name2);
[encodingCorrBeta] = getEncodingBrainCorrData(brainCorr.name1,brainCorr.name2);
[encodingCorr4run] = getEncodingBrainCorrData4runs(brainCorr.name1,brainCorr.name2);
% using beta series correlations
[a b ctemp]=glmfit([famCorr encodingCorrBeta(:,1)],pairMem.intactFam);
tval(:,1) = ctemp.t(2:3);
pval(:,1) = ctemp.p(2:3);

[a b ctemp]=glmfit([famCorr encodingCorrBeta(:,3)],pairMem.intactFam);
tval(:,2) = ctemp.t(2:3);
pval(:,2) = ctemp.p(2:3);

[a b ctemp]=glmfit([famCorr encodingCorrBeta(:,1)+encodingCorrBeta(:,3)],pairMem.intactFam);
tval(:,3) = ctemp.t(2:3);
pval(:,3) = ctemp.p(2:3);

[a b ctemp]=glmfit([famCorr mean(encodingCorrBeta,2)],pairMem.intactFam);
tval(:,4) = ctemp.t(2:3);
pval(:,4) = ctemp.p(2:3);

%using original time series correlations
[a b ctemp]=glmfit([famCorr encodingCorr4run(:,1)],pairMem.intactFam);
tval(:,5) = ctemp.t(2:3);
pval(:,5) = ctemp.p(2:3);

[a b ctemp]=glmfit([famCorr encodingCorr4run(:,2)],pairMem.intactFam);
tval(:,6) = ctemp.t(2:3);
pval(:,6) = ctemp.p(2:3);

[a b ctemp]=glmfit([famCorr mean(encodingCorr4run,2)],pairMem.intactFam);
tval(:,7) = ctemp.t(2:3);
pval(:,7) = ctemp.p(2:3);

[a b c d]=ttest(repmat(encodingCorr4run(:,1),[1,3]),[preCorr,famCorr nonfamCorr]);
pcomp(1,:) = b;
statscomp.fam1 = d;
[a b c d]=ttest(repmat(encodingCorr4run(:,2),[1,3]),[preCorr,famCorr nonfamCorr]);
pcomp(2,:) = b;
statscomp.fam2 = d;
[a b c d]=ttest(repmat(mean(encodingCorr4run,2),[1,3]),[preCorr,famCorr nonfamCorr]);
pcomp(3,:) = b;
statscomp.fam12 = d;
[a b c d]=ttest(sum(encodingCorr4run(:,1:2),2),sum(encodingCorr4run(:,3:4),2))
statscomp.fam12_nonfam12_t = d;
statscomp.fam12_nonfam12_p = b;

function [tval pval]= controlEncodingActInPostCorrPrediction(brainCorr,actData,pairMem)
rois = { 'L_PPA.img', 'R_PPA.img',...
    'L_FFA.img', 'R_FFA.img','L_HPC.img', 'R_HPC.img', 'L_TPL.img', 'R_TPL.img',...
    'L_vmP.img', 'R_vmP.img'};
[preCorr famCorr nonfamCorr] = getBrainCorrData(brainCorr.name1,brainCorr.name2);

id1=find(~cellfun(@isempty,strfind(rois,brainCorr.name1)));
id2=find(~cellfun(@isempty,strfind(rois,brainCorr.name2)));

actFam=mean(mean(actData(:,[id1,id2],1:2),3),2);
actNFam=mean(mean(actData(:,[id1,id2],3:4),3),2);
actDataAll= mean(mean(actData(:,[id1,id2],:),3),2);

%famous condition
%control fam activation
[a b ctemp]=glmfit([famCorr actFam],pairMem.intactFam);
tval(:,1) = ctemp.t(2:3);
pval(:,1) = ctemp.p(2:3);
[a b ctemp]=glmfit(actFam,pairMem.intactFam);
tval(3,1) = ctemp.t(2);
pval(3,1) = ctemp.p(2);
%control famnonfam activation
[a b ctemp]=glmfit([famCorr actDataAll],pairMem.intactFam);
tval(1:2,2) = ctemp.t(2:3);
pval(1:2,2) = ctemp.p(2:3);
[a b ctemp]=glmfit(actDataAll,pairMem.intactFam);
tval(3,2) = ctemp.t(2);
pval(3,2) = ctemp.p(2);

function [tval pval famEncodingCorr nfamEncodingCorr]= controlEncodingActCorrInPostCorrPrediction(brainCorr,actData,pairMem)
rois = { 'L_PPA.img', 'R_PPA.img',...
    'L_FFA.img', 'R_FFA.img','L_HPC.img', 'R_HPC.img', 'L_TPL.img', 'R_TPL.img',...
    'L_vmP.img', 'R_vmP.img'};
[preCorr famCorr nonfamCorr] = getBrainCorrData(brainCorr.name1,brainCorr.name2);
[encodingCorr4run] = getEncodingBrainCorrData4runs(brainCorr.name1,brainCorr.name2);

id1=find(~cellfun(@isempty,strfind(rois,brainCorr.name1)));
id2=find(~cellfun(@isempty,strfind(rois,brainCorr.name2)));

actFam=mean(mean(actData(:,[id1,id2],1:2),3),2);
actNFam=mean(mean(actData(:,[id1,id2],3:4),3),2);
actDataAll= mean(mean(actData(:,[id1,id2],:),3),2);

%famous condition
%control fam activationand connectivity

[a b ctemp]=glmfit([famCorr actFam,mean(encodingCorr4run(:,1:2),2)],pairMem.intactFam);
tval(:,1) = ctemp.t(2:4);
pval(:,1) = ctemp.p(2:4);


%nonfamous condition
%control nonfam activation and connectivity
[a b ctemp]=glmfit([nonfamCorr actNFam mean(encodingCorr4run(:,3:4),2)],pairMem.intactNFam);
tval(:,2) = ctemp.t(2:4);
pval(:,2) = ctemp.p(2:4);
famEncodingCorr =mean(encodingCorr4run(:,1:2),2);
nfamEncodingCorr = mean(encodingCorr4run(:,3:4),2);


function [mValHPCL mValHPCR] = extractMeanConnUsingRex(maskFile)
sourceDir = 'D:\myStudy\picpairfMRI\postEncodingRest\conn_restingConnectivity\results\firstlevel\ANALYSIS_01\';
filePreHPCL = dir([sourceDir,'*Condition001_Source037.nii']);
filePreHPCR = dir([sourceDir,'*Condition001_Source038.nii']);
filePostFamHPCL = dir([sourceDir,'*Condition002_Source037.nii']);
filePostFamHPCR = dir([sourceDir,'*Condition002_Source038.nii']);
filePostNFamHPCL = dir([sourceDir,'*Condition003_Source037.nii']);
filePostNFamHPCR = dir([sourceDir,'*Condition003_Source038.nii']);
idshuf=[11 13:20,1:10 12]; %change the order of id to 1:20
for i = 1:length(filePreHPCL)
fileNames = [sourceDir,char(filePreHPCL(i).name)];
mValHPCL(i,1) = rex(fileNames,maskFile);


fileNames = [sourceDir,char(filePostFamHPCL(i).name)];
mValHPCL(i,2) = rex(fileNames,maskFile);

fileNames = [sourceDir,char(filePostNFamHPCL(i).name)];
mValHPCL(i,3) = rex(fileNames,maskFile);

fileNames = [sourceDir,char(filePreHPCR(i).name)];
mValHPCR(i,1) = rex(fileNames,maskFile);

fileNames = [sourceDir,char(filePostFamHPCR(i).name)];
mValHPCR(i,2) = rex(fileNames,maskFile);

fileNames = [sourceDir,char(filePostNFamHPCR(i).name)];
mValHPCR(i,3) = rex(fileNames,maskFile);

end                 
mValHPCL=mValHPCL(idshuf,:);   
mValHPCR=mValHPCR(idshuf,:); 
function [preCorrAllRoi famCorrAllRoi nonfamCorrAllRoi] = getAllBrainCorrData

load('D:\myStudy\picpairfMRI\postEncodingRest\conn_restingConnectivity\results\firstlevel\ANALYSIS_01\resultsROI_Condition001.mat');

ida =[117 118 127:134];
idb =[117 118 127:134];

preCorrAllRoi=squeeze(Z(ida,idb,:));

load('D:\myStudy\picpairfMRI\postEncodingRest\conn_restingConnectivity\results\firstlevel\ANALYSIS_01\resultsROI_Condition002.mat');
famCorrAllRoi=squeeze(Z(ida,idb,:));

load('D:\myStudy\picpairfMRI\postEncodingRest\conn_restingConnectivity\results\firstlevel\ANALYSIS_01\resultsROI_Condition003.mat');
nonfamCorrAllRoi=squeeze(Z(ida,idb,:));

                 
function [preCorr famCorr nonfamCorr] = getBrainCorrData(roiName1, roiName2)

load('D:\myStudy\picpairfMRI\postEncodingRest\conn_restingConnectivity\results\firstlevel\ANALYSIS_01\resultsROI_Condition001.mat');

ida = FdIndexCellstr(names,roiName1);

    if isempty(ida)
    error('wrong roi names ida');
end
idb = FdIndexCellstr(names2,roiName2);

if isempty(idb)
    error('wrong roi names idb');
end

preCorr=squeeze(Z(ida,idb,:));

load('D:\myStudy\picpairfMRI\postEncodingRest\conn_restingConnectivity\results\firstlevel\ANALYSIS_01\resultsROI_Condition002.mat');
famCorr=squeeze(Z(ida,idb,:));

load('D:\myStudy\picpairfMRI\postEncodingRest\conn_restingConnectivity\results\firstlevel\ANALYSIS_01\resultsROI_Condition003.mat');
nonfamCorr=squeeze(Z(ida,idb,:));

function [encodingCorr] = getEncodingBrainCorrData(roiName1, roiName2)
for i = 1:8
load(['G:\myStudy\picpairfMRI\encodingConnectivityConn_usingBetaSeries_withWMCSFRegressor\conn_eoncodingUsingBetaSeries\results\firstlevel\ANALYSIS_01\resultsROI_Condition00',num2str(i),'.mat']);

ida = FdIndexCellstr(names,roiName1);

    if isempty(ida)
    error('wrong roi names ida');
end
idb = FdIndexCellstr(names2,roiName2);

if isempty(idb)
    error('wrong roi names idb');
end

encodingCorr(:,i)=squeeze(Z(ida,idb,:));

end

function [encodingCorr] = getEncodingBrainCorrData4runs(roiName1, roiName2)
for i = 1:4
load(['G:\myStudy\picpairfMRI\encoding4run\encoding4run\results\firstlevel\ANALYSIS_01\resultsROI_Condition00',num2str(i),'.mat']);

ida = FdIndexCellstr(names,roiName1);

    if isempty(ida)
    error('wrong roi names ida');
end
idb = FdIndexCellstr(names2,roiName2);

if isempty(idb)
    error('wrong roi names idb');
end

encodingCorr(:,i)=squeeze(Z(ida,idb,:));

end

function plotBrainCorrWithAssociativeMem(brainCorr,associMem)
s=figure;
fsize=8;
% scatter(brainCorr.data,associMem,10,'ok','filled')
% ll=lsline;
% set(ll,'LineWidth',1.3,'Color','k');
% hold on;

x = replaceOutliers(brainCorr.data,2.5,2);
y = replaceOutliers(associMem,2.5,2);
scatter(x,y,10,'ok','filled')
l2=lsline;
set(l2,'LineWidth',1.3,'Color','k','LineStyle','-');
[B,BINT,R,RINT,STATS] = regress(y,[ones(length(x),1),x]);
t=sqrt(STATS(2));
p=STATS(3);
title(['regt= ',num2str(t),'regp= ',num2str(p)]);
xlabel([brainCorr.name1,'-',brainCorr.name2, ' correlation']);
ylabel('Associative memory');
set(gca,'fontsize',fsize);
box off;
set(gcf, 'Color', 'w');
setfigsize(s,8,'Helvetica',8,'Helvetica',6.5,4.5);
% xlim([min(x)-.05 max(x)+.05]);
xlim([-.2 .61]);
ylim([min(y)-.05 max(y)+.05]);
outpath = 'C:\Users\Zhongxu\Dropbox\picpair\PicparBehavioralmanuscript\postEncodingfMRIPub\figures\';
export_fig([outpath brainCorr.name1,'-',brainCorr.name2, ' correlation',brainCorr.fameFlag],'-pdf');


function [zpfCorrDiff, zpfPval] = plotBrainCorrWith2AssociativeMems(brainCorr,associMem1, associMem2,memType)
s=figure;
fsize=8;
% scatter(brainCorr.data,associMem,10,'ok','filled')
% ll=lsline;
% set(ll,'LineWidth',1.3,'Color','k');
% hold on;
y1 = replaceOutliers(associMem1,2.5,2);
y2 = replaceOutliers(associMem2,2.5,2);

x1 = replaceOutliers(brainCorr.data,2.5,2);
if isfield(brainCorr,'data2')
    x2=replaceOutliers(brainCorr.data2,2.5,2);
    %zpf test

[zpfCorrDiff, zpfPval] = ZPFTest(x1,y1,x2,y2,20)

else
    x2=x1;
    %meng test modified

[zMCorrDiff, zMPval] = MengTest(x1,y1,y2,20)

end


scatter(x1,y1,10,'or','filled');
l1=lsline;
set(l1,'LineWidth',1.3,'Color','r','LineStyle','-');
hold on;
scatter(x2,y2,10,'ob','filled');
l2=lsline;
set(l2,'LineWidth',1.3,'Color','b','LineStyle','-');

[B,BINT,R,RINT,STATS] = regress(y1,[ones(length(x1),1),x1]);
t1=sqrt(STATS(2));
p1=STATS(3);

[B,BINT,R,RINT,STATS] = regress(y2,[ones(length(x2),1),x2]);
t2=sqrt(STATS(2));
p2=STATS(3);


title(['regt= ',num2str(t1),num2str(t2),'regp= ',num2str(p1),num2str(p2)]);
xlabel([brainCorr.name1,'-',brainCorr.name2, ' correlation']);
ylabel('Associative memory');
set(gca,'fontsize',fsize);
box off;
set(gcf, 'Color', 'w');
setfigsize(s,8,'Helvetica',8,'Helvetica',6.5,4.5);
% xlim([min(x)-.05 max(x)+.05]);
xlim([min([x1;x2])-.05 max([x1;x2])+.05]);
ylim([min([y1;y2])-.05 max([y1;y2])+.05]);
outpath = 'C:\Users\Zhongxu\Dropbox\picpair\PicparBehavioralmanuscript\postEncodingfMRIPub\figures\';
% if ~exist([outpath brainCorr.name1,'-',brainCorr.name2, ' correlation',brainCorr.fameFlag,memType,'2mems.pdf']);
% export_fig([outpath brainCorr.name1,'-',brainCorr.name2, ' correlation',brainCorr.fameFlag,memType,'2mems'],'-pdf');
% end

function plot3BrainCorrWithOnePredictor(brainCorr,x,xName)
s=figure;
fsize=8;
% scatter(brainCorr.data,associMem,10,'ok','filled')
% ll=lsline;
% set(ll,'LineWidth',1.3,'Color','k');
% hold on;

% y1 = replaceOutliers(brainCorr.preCorr,2.5,2);
% y2 = replaceOutliers(brainCorr.famCorr,2.5,2);
% y3 = replaceOutliers(brainCorr.nonfamCorr,2.5,2);

y1 = brainCorr.preCorr;
y2 = brainCorr.famCorr;
y3 = brainCorr.nonfamCorr;

if size(x,2)==1
    x1=x;
    x2=x;
    x3=x;
elseif size(x,2)==3
    x1=x(:,1);
    x2=x(:,2);
    x3=x(:,3);
end


scatter(x1,y1,10,'vk');
l1=lsline;
set(l1,'LineWidth',1.3,'Color','k','LineStyle','-');
hold on;
scatter(x2,y2,10,'or','filled');
l2=lsline;
set(l2,'LineWidth',1.3,'Color','r','LineStyle','-');
scatter(x3,y3,10,'sg','filled');
l3=lsline;
set(l3,'LineWidth',1.3,'Color','g','LineStyle','-');


[B,BINT,R,RINT,STATS] = regress(y1,[ones(length(x1),1),x1]);
t1=sqrt(STATS(2));
p1=STATS(3);

[B,BINT,R,RINT,STATS] = regress(y2,[ones(length(x2),1),x2]);
t2=sqrt(STATS(2));
p2=STATS(3);

[B,BINT,R,RINT,STATS] = regress(y3,[ones(length(x3),1),x3]);
t3=sqrt(STATS(2));
p3=STATS(3);

title(['regt= ',num2str(roundoff(t1,4)),';',num2str(roundoff(t2,4)),';',num2str(roundoff(t3,4)),...
    'regp= ',num2str(roundoff(p1,4)),';',num2str(roundoff(p2,4)),';',num2str(roundoff(p3,4))],...
    'fontsize',5);
ylabel([brainCorr.name1,'-',brainCorr.name2, ' correlation']);
xlabel(xName);
set(gca,'fontsize',fsize);
box off;
set(gcf, 'Color', 'w');
setfigsize(s,8,'Helvetica',8,'Helvetica',5,4);
% xlim([min(x)-.05 max(x)+.05]);
xlim([min([x1;x2;x3])-.05 max([x1;x2;x3])+.05]);
ylim([min([y1;y2;y3])-.05 max([y1;y2;y3])+.05]);
outpath = 'C:\Users\Zhongxu\Dropbox\picpair\PicparBehavioralmanuscript\postEncodingfMRIPub\figures\';
export_fig([outpath brainCorr.name1,'-',brainCorr.name2,'with',xName],'-pdf');



function stat = plot3bars(preCorr,famCorr,nonfamCorr,connLabel,outpath)
s = figure; 
fsize=7;
ss = bar(mean([preCorr, famCorr,nonfamCorr],1),.5,'k');
hold on;
errorbar(mean([preCorr, famCorr,nonfamCorr],1),std([preCorr, famCorr,nonfamCorr],1)/sqrt(20),'k');
[a b c d]=ttest(famCorr,nonfamCorr);
stat.p(1)=b;
stat.t(1)=d.tstat;
[a b c d]=ttest(famCorr,preCorr);
stat.p(2)=b;
stat.t(2)=d.tstat;
[a b c d]=ttest(nonfamCorr,preCorr);
stat.p(3)=b;
stat.t(3)=d.tstat;
 
[a b c d]=ttest(preCorr,0);
stat.po(1)=b;
stat.to(1)=d.tstat;

[a b , ~, d]=ttest(famCorr,0);
stat.po(2)=b;
stat.to(2)=d.tstat;

[a b c d]=ttest(nonfamCorr,0);
stat.po(3)=b;
stat.to(3)=d.tstat;

ylabel('Connectivity'); 
set(gca,'fontsize',fsize);
box off;
set(gcf, 'Color', 'w');
setfigsize(s,7,'Helvetica',7,'Helvetica',1.5,2.5);
%  set(gca,'YLim',[0 max(mean([preCorr, famCorr,nonfamCorr]))+ max(std([preCorr, famCorr,nonfamCorr]))]);
% set(gca, 'XTickLabel', {'Pre-encoding','Post-famous','Post-nonfamous'});
export_fig([outpath,connLabel, '3bars'],'-pdf');
% plot2svg([outpath 'lFFAvsRHPC-3bar_withdatapoint.svg'],s);

% 
% % ida = [131:134 117,118,127,128];
% % idb = [131:134 117,118,127,128];
% ida = [131:134 ];
% idb = [117,118,127,128];
% pvalFam=[]; fvalNfam=[];
% for i = 1:4
%     for j = 1:4
%         
% outpath = 'C:\Users\Zhongxu\Dropbox\picpair\PicparBehavioralmanuscript\postEncodingfMRIPub\figures\';
% load('D:\myStudy\picpairfMRI\postEncodingRest\conn_restingConnectivity\results\firstlevel\ANALYSIS_01\resultsROI_Condition002.mat');
% names{ida(i)}
% names2{idb(j)}
% famCorr=squeeze(Z(ida(i),idb(j),:));
% load('D:\myStudy\picpairfMRI\postEncodingRest\conn_restingConnectivity\results\firstlevel\ANALYSIS_01\resultsROI_Condition003.mat');
% nonfamCorr=squeeze(Z(ida(i),idb(j),:));
% 
% load('D:\myStudy\picpairfMRI\postEncodingRest\conn_restingConnectivity\results\firstlevel\ANALYSIS_01\resultsROI_Condition001.mat');
% preCorr=squeeze(Z(ida(i),idb(j),:));
% 
%  [B,BINT,R,RINT,STATS] = regress(pairMem.intactFam-pairMem.intactNFam,[ones(20,1) famCorr - nonfamCorr]);
%  fvalFamNfam(i,j) = STATS(2);
%  pvalFamNfam(i,j)= STATS(3);
%     end
% end
% % indx = LowerTriangleIndex(4);
% % pp=pval(indx);
% ppFamNfam=reshape(pvalFamNfam,16,1);
% [fdrFamNfam] = mafdr(ppFamNfam, 'BHFDR', true);
% fdrFamNfam = reshape(fdrFamNfam,4,4);
% 
% 
% ida = [131:134 ];
% idb = [117,118,127,128];
% pvalPreFam=[]; fvalPreFam=[];
% for i = 1:4
%     for j = 1:4
%         
% outpath = 'C:\Users\Zhongxu\Dropbox\picpair\PicparBehavioralmanuscript\postEncodingfMRIPub\figures\';
% load('D:\myStudy\picpairfMRI\postEncodingRest\conn_restingConnectivity\results\firstlevel\ANALYSIS_01\resultsROI_Condition002.mat');
% names{ida(i)}
% names2{idb(j)}
% famCorr=squeeze(Z(ida(i),idb(j),:));
% load('D:\myStudy\picpairfMRI\postEncodingRest\conn_restingConnectivity\results\firstlevel\ANALYSIS_01\resultsROI_Condition003.mat');
% nonfamCorr=squeeze(Z(ida(i),idb(j),:));
% 
% load('D:\myStudy\picpairfMRI\postEncodingRest\conn_restingConnectivity\results\firstlevel\ANALYSIS_01\resultsROI_Condition001.mat');
% preCorr=squeeze(Z(ida(i),idb(j),:));
% 
%  [B,BINT,R,RINT,STATS] = regress(pairMem.intactFam,[ones(20,1) famCorr-preCorr]);
%  fvalPreFam(i,j) = STATS(2);
%  pvalPreFam(i,j)= STATS(3);
%  BPreFam(i,j) = B(2);
%     end
% end
% % indx = LowerTriangleIndex(4);
% % pp=pval(indx);
% ppPreFam=reshape(pvalPreFam,16,1);
% [fdrPreFam] = mafdr(ppPreFam, 'BHFDR', true);
% fdrPreFam = reshape(fdrPreFam,4,4);
% 
% ida = [131:134 ];
% idb = [117,118,127,128];
% pvalPreNfam=[]; fvalPreNfam=[];
% for i = 1:4
%     for j = 1:4
%         
% outpath = 'C:\Users\Zhongxu\Dropbox\picpair\PicparBehavioralmanuscript\postEncodingfMRIPub\figures\';
% load('D:\myStudy\picpairfMRI\postEncodingRest\conn_restingConnectivity\results\firstlevel\ANALYSIS_01\resultsROI_Condition002.mat');
% names{ida(i)}
% names2{idb(j)}
% famCorr=squeeze(Z(ida(i),idb(j),:));
% load('D:\myStudy\picpairfMRI\postEncodingRest\conn_restingConnectivity\results\firstlevel\ANALYSIS_01\resultsROI_Condition003.mat');
% nonfamCorr=squeeze(Z(ida(i),idb(j),:));
% 
% load('D:\myStudy\picpairfMRI\postEncodingRest\conn_restingConnectivity\results\firstlevel\ANALYSIS_01\resultsROI_Condition001.mat');
% preCorr=squeeze(Z(ida(i),idb(j),:));
% 
%  [B,BINT,R,RINT,STATS] = regress(pairMem.intactFam,[ones(20,1) nonfamCorr-preCorr]);
%  fvalPreNfam(i,j) = STATS(2);
%  pvalPreNfam(i,j)= STATS(3);
%  BPreNfam(i,j) = B(2);
%     end
% end
% % indx = LowerTriangleIndex(4);
% % pp=pval(indx);
% ppPreNfam=reshape(pvalPreNfam,16,1);
% [fdrPreNfam] = mafdr(ppPreNfam, 'BHFDR', true);
% fdrPreNfam = reshape(fdrPreNfam,4,4);


% PLS analysis
% rootDir='C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\similarityAnalysis\dataUsingGroupROIs\';
% 
% for subj = 1:20
%     
%     disp(subj)
%     
%     %dataset 1 - encoding time series
%          
%         load([rootDir,'restingTimeSeriesData_groupROIs\subject-', sprintf('%03d',subj),...
%             '-condition-', sprintf('%03d',2),'.mat']);
%        datafam(:,:,subj) = corr(roiTimeSeriesData(:,a)); 
%                load([rootDir,'restingTimeSeriesData_groupROIs\subject-', sprintf('%03d',subj),...
%             '-condition-', sprintf('%03d',3),'.mat']);
%        datanfam(:,:,subj) = corr(roiTimeSeriesData(:,a)); 
%         
% end
% 
% for i = 1:size(datafam,1)
%     for j = 1:i
%     [a p c f] = ttest(squeeze(datafam(i,j,:)),squeeze(datanfam(i,j,:)));
%     
%     t(i,j)=f.tstat;
%     end
% end
% t(abs(t)<5)=0;
% imagesc(t)
% 
% lowTriagDataIndx = LowerTriangleIndex(size(datafam,1));
% 
% 
% %stack the low triagle matrix data into a row
% for i = 1:20
% temp1 = datafam(:,:,i);
% preEnco10Stack(i,:)= temp1(lowTriagDataIndx);   
%     
% temp2 = datanfam(:,:,i);
% postFamEnco10Stack(i,:)= temp2(lowTriagDataIndx);
% 
% % temp3 = postNonFamEncoRest(roiIndx, roiIndx,i);
% % postNonFamEnco10Stack(i,:)= temp3(lowTriagDataIndx);
% % clear temp1 temp2 temp3
% end
% 
% % making input data for commend line pls: concatenating 3 resting data
% % together
% datamat_list{1} = cat(1, preEnco10Stack,postFamEnco10Stack);
% % specify other parameter for pls analysis
% num_subj_lst = 20;
% num_cond = 2;
% option.method = 2; %non-rotated
% option.num_perm = 500;
% option.num_boot = 500;
% option.clim = 95;
% option.stacked_designdata = [1 -1]'; % I only have 2 contrast
% 
% result = pls_analysis(datamat_list, num_subj_lst, num_cond,option);
% 
% % Comparing postfam vs. postnonfam
% temp1=result.boot_result.compare_u(:,1);
% dataForPlot = zeros(length(roiIndx));
% dataForPlot(lowTriagDataIndx)= temp1;
% figure;
% imagesc(dataForPlot);
% figure;
% dataForPlot(abs(dataForPlot)<3)=0;
% imagesc(dataForPlot);
