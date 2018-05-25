function [easy diffic includedSubj, trialCount] = calculatePriorExperienceEffectOnMemory(prioExpType, memType,minTCount)
% behavioral performance for easy and difficult ('easyDifficult') trial or for high
% vs low emotion/memory/attractiveness/familiarity
% if perioExpType is 'all', then all face evaluation data will be averaged
%otherwise using individual evalulation data'memory'
%'familiarity','emotion','attractiveness'
% memType: 'pairMem','faceMem','houseMem', 'easyRating'-how face rating
% affect easyDifficult rating
%TODO: automatically exclude participants with too low trial count for a
%eveluation category, e.g., difficult trial count or low Memory evaluation
%trial counts
%zhongxu May 26, 2013

if nargin<3
    minTCount = 5;
end
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

if strcmp(prioExpType, 'pca') || strcmp(prioExpType, 'pca50percentile')
        choosePCFlag = 1; % first pc
        [fam1PCA, fam2PCA, meanCorr] = calculateFaceRatingPCA(choosePCFlag);
end

for i = 1:20
    %load behavorial data
    subDir = [rootDirD, 's',sprintf('%03d',i),'\'];
    behavDataDir = [subDir,'performanceData\'];
    data=[];
    if strcmp(prioExpType, 'memory')
        load([behavDataDir,'memoryEval.mat']);
        data = memoryEval(:,1:2);
        data(:,3:4)=nan;
        data = data(idPics,:);
        data(find(data<4))=-1; % <4 must be excecuted before >3, otherwises every item will be -1
        data(find(data>3))=1;
    end
    
    if strcmp(prioExpType, 'emotion')
        load([behavDataDir,'emotionEval.mat']);
        data = emotionEval(:,1:4);
        data = data(idPics,:);
        data(find(data<4))=-1; % <4 must be excecuted before >3, otherwises every item will be -1
        data(find(data>3))=1;
    end
    
    if strcmp(prioExpType, 'familiarity')
        load([behavDataDir,'familiarityEval.mat']);
        data = familiarityEval(:,1:4);
        data = data(idPics,:);
        data(find(data<4))=-1; % <4 must be excecuted before >3, otherwises every item will be -1
        data(find(data>3))=1;
    end
    
    if strcmp(prioExpType, 'attractiveness')
        load([behavDataDir,'attractivenessEval.mat']);
        data = attractivenessEval(:,1:4);
        data = data(idPics,:);
        data(find(data<4))=-1; % <4 must be excecuted before >3, otherwises every item will be -1
        data(find(data>3))=1;
    end
    
    if strcmp(prioExpType, 'all')
        load([behavDataDir,'memoryEval.mat']);
        load([behavDataDir,'emotionEval.mat']);
        load([behavDataDir,'familiarityEval.mat']);
        load([behavDataDir,'attractivenessEval.mat']);
        
        data(:,1:2) = (memoryEval(:,1:2)+ emotionEval(:,1:2)+...
            familiarityEval(:,1:2) + attractivenessEval(:,1:2))/4;
        data(:,3:4) =                (emotionEval(:,3:4)+...
            familiarityEval(:,3:4) + attractivenessEval(:,3:4))/3;
        
        data = data(idPics,:);
        data1=data;
        for m = 1:4
            data1(find(data(:,m)<median(data(:,m))),m)=-1; % <4 must be excecuted before >3, otherwises every item will be -1
            data1(find(data(:,m)>=median(data(:,m))),m)=1;
        end
        data=data1;
    end
    
    if strcmp(prioExpType, 'pca')
  
        data(:,1:2) = [fam1PCA(:,i),fam2PCA(:,i)];
        data(:,3:4)=nan;
       data1=data;
%         data(find(data<0))=-1; % let just use mean of 0 to get high vs low prior knowledge to give a first try
%         data(find(data>0))=1;
        for m = 1:2
            data1(find(data(:,m)<=percentile(data(:,m),60)),m)=-1; % <4 must be excecuted before >3, otherwises every item will be -1
            data1(find(data(:,m)>percentile(data(:,m),60)),m)=1;
        end
        data=data1;
    end
  
    
        if strcmp(prioExpType, 'pca50percentile')
  
        data(:,1:2) = [fam1PCA(:,i),fam2PCA(:,i)];
        data(:,3:4)=nan;
       data1=data;
%         data(find(data<0))=-1; % let just use mean of 0 to get high vs low prior knowledge to give a first try
%         data(find(data>0))=1;
        for m = 1:2
            data1(find(data(:,m)<=percentile(data(:,m),50)),m)=-1; % <4 must be excecuted before >3, otherwises every item will be -1
            data1(find(data(:,m)>percentile(data(:,m),50)),m)=1;
        end
        data=data1;
    end
    
    
    if strcmp(prioExpType, 'easyDifficult')
        load([behavDataDir,'easyDifficultEval.mat']);
        data = picsEval(:,1:4);
        dataSc = scrmEval;
        data(find(data~=1))=-1; %difficult trails coded as -1
        dataSc(find(dataSc~=1)) = -1;
        
    end
    
    
    id1 = double(data==1); % count for face-house pairs
    id2 = double(data==-1);
    
    if strcmp(prioExpType, 'easyDifficult') % all enocding blocks
        id3 = double(dataSc==1); % count for scrambled pairs
        id4 = double(dataSc==-1);
        trialCountMim=min([sum(id1) sum(id2) sum(id3) sum(id4)]);
        trialCount(i,:) = [sum(id1) sum(id2) sum(id3) sum(id4)];
    else
        trialCountMim=min([sum(id1(:,1:2)) sum(id2(:,1:2))]); %only famous blocks are important
        trialCount(i,:) =[sum(id1(:,1:2)) sum(id2(:,1:2))];
    end
    
    if trialCountMim >= minTCount
        includedSubj(i,1) = true;
    else
        includedSubj(i,1) = false;
    end
    
    
    load([behavDataDir,'retrievalDataUpdatedMethod.mat']);
    %get associative false alarm recomOmitted
    [intact,recom,recomOmitted,singleFace,singleHouse,singleNoPair] = getRetrievalData(i);
    switch memType
        case 'pairMem'
            memPairData = [intactRecogFam1 + recomRecogFam1(:,3),...
                intactRecogFam2 + recomRecogFam2(:,3),...
                intactRecogNFam1 + recomRecogNFam1(:,3),...
                intactRecogNFam2 + recomRecogNFam2(:,3)];
            memPairData = memPairData(idPics,:);
            pairsIntactRecom=getTrialTypeForEncodingTrials(1)+getTrialTypeForEncodingTrials(2);
            pairsIntactRecom=pairsIntactRecom(idPics,:);
            
            for j = 1:4
                easy(i,j) = sum(id1(pairsIntactRecom(:,j)==1,j).*memPairData(pairsIntactRecom(:,j)==1,j))/ sum(id1(pairsIntactRecom(:,j)==1,j));
                
                diffic(i,j) = sum(id2(pairsIntactRecom(:,j)==1,j).*memPairData(pairsIntactRecom(:,j)==1,j))/ sum(id2(pairsIntactRecom(:,j)==1,j));
                
                easyHit(i,j) = sum(id1(pairsIntactRecom(:,j)==1,j).*memPairData(pairsIntactRecom(:,j)==1,j));
                easyTotal(i,j) = sum(id1(pairsIntactRecom(:,j)==1,j));
                difficHit(i,j) = sum(id2(pairsIntactRecom(:,j)==1,j).*memPairData(pairsIntactRecom(:,j)==1,j));
                difficTotal(i,j)=sum(id2(pairsIntactRecom(:,j)==1,j));
 
             end
        case 'pairMemNoRecom'
            memPairData = [intactRecogFam1 ,...
                intactRecogFam2 ,...
                intactRecogNFam1,...
                intactRecogNFam2 ];
            memPairData = memPairData(idPics,:); %keep only face-house pairs
            pairsIntactRecom=getTrialTypeForEncodingTrials(1);%get intact pairs
            pairsIntactRecom=pairsIntactRecom(idPics,:);
            
            for j = 1:4
                easy(i,j) = sum(id1(pairsIntactRecom(:,j)==1,j).*memPairData(pairsIntactRecom(:,j)==1,j))/ sum(id1(pairsIntactRecom(:,j)==1,j));
                
                diffic(i,j) = sum(id2(pairsIntactRecom(:,j)==1,j).*memPairData(pairsIntactRecom(:,j)==1,j))/ sum(id2(pairsIntactRecom(:,j)==1,j));
                easyHit(i,j) = sum(id1(pairsIntactRecom(:,j)==1,j).*memPairData(pairsIntactRecom(:,j)==1,j));
                easyTotal(i,j) = sum(id1(pairsIntactRecom(:,j)==1,j));
                difficHit(i,j) = sum(id2(pairsIntactRecom(:,j)==1,j).*memPairData(pairsIntactRecom(:,j)==1,j));
                difficTotal(i,j)=sum(id2(pairsIntactRecom(:,j)==1,j));
 
            end
            
            
        case 'pairMemFalseAlarmRecom'
                %get associative false alarm recomOmitted
    [intact,recom,recomOmitted,singleFace,singleHouse,singleNoPair] = getRetrievalData(i);
            memPairData=zeros(96,4);
            memPairData(recomOmitted.fam{1},1) = 1;
            memPairData(recomOmitted.fam{2},2) = 1;
            memPairData(recomOmitted.nfam{1},3) = 1;
            memPairData(recomOmitted.nfam{2},4) = 1;
            
            memPairData = memPairData(idPics,:);
            pairsIntactRecom=getTrialTypeForEncodingTrials(2);%recombined pairs
            pairsIntactRecom=pairsIntactRecom(idPics,:);
            
            for j = 1:4
                easy(i,j) = sum(id1(pairsIntactRecom(:,j)==1,j).*memPairData(pairsIntactRecom(:,j)==1,j))/ sum(id1(pairsIntactRecom(:,j)==1,j));
                
                diffic(i,j) = sum(id2(pairsIntactRecom(:,j)==1,j).*memPairData(pairsIntactRecom(:,j)==1,j))/ sum(id2(pairsIntactRecom(:,j)==1,j));
                
            end
        case 'faceMem'
            memFaceData = getTotalItemMemData(faceRecogFam1,faceRecogFam2,...
                faceRecogNFam1, faceRecogNFam2);
            memFaceData = memFaceData(idPics,:);
            
            easy(i,:) = sum(id1.*memFaceData)./sum(id1);
            diffic(i,:) = sum(id2.*memFaceData)./sum(id2);
        case 'faceMemSingle'
            trialType = getTestedSinglePicInEncodingTrials(1);
            trialType = trialType(idPics,:);
            memFaceData = getSingleItemMemData(faceRecogFam1,faceRecogFam2,...
                faceRecogNFam1, faceRecogNFam2);
            memFaceData = memFaceData(idPics,:);
            
            easy(i,:) = sum(id1.*memFaceData)./sum(id1.*trialType);
            diffic(i,:) = sum(id2.*memFaceData)./sum(id2.*trialType);
        case 'houseMem'
            memHouseData = getTotalItemMemData(houseRecogFam1,houseRecogFam2,...
                houseRecogNFam1,houseRecogNFam2);
            memHouseData = memHouseData(idPics,:);
            easy(i,:) = sum(id1.*memHouseData)./sum(id1);
            diffic(i,:) = sum(id2.*memHouseData)./sum(id2);
        case 'houseMemSingle'
            trialType = getTestedSinglePicInEncodingTrials(0);
            trialType = trialType(idPics,:);
            memHouseData = getSingleItemMemData(houseRecogFam1,houseRecogFam2,...
                houseRecogNFam1,houseRecogNFam2);
            memHouseData = memHouseData(idPics,:);
            easy(i,:) = sum(id1.*memHouseData)./sum(id1.*trialType);
            diffic(i,:) = sum(id2.*memHouseData)./sum(id2.*trialType);
        case 'easyRating'
            
            load([behavDataDir,'easyDifficultEval.mat']);
            easyRating=zeros(60,4);
            easyRating = picsEval(:,1:4);
            easyRating(find(easyRating~=1))=-1; %difficult trails coded as -1
            
            easy(i,:) = sum(id1.*easyRating)./sum(id1);
            diffic(i,:) = sum(id2.*easyRating)./sum(id2);
    end
end
%only keep data for included subjects
easy = easy(includedSubj,:);
diffic = diffic(includedSubj,:);

function dataout = getTotalItemMemData(F1,F2,NF1,NF2)
dataout(:,1) = F1.recall + F1.fml + F1.recogInOneNew + F1.recogInBothOld;
dataout(:,2) = F2.recall + F2.fml + F2.recogInOneNew + F2.recogInBothOld;
dataout(:,3) = NF1.recall + NF1.fml + NF1.recogInOneNew + NF1.recogInBothOld;
dataout(:,4) = NF2.recall + NF2.fml + NF2.recogInOneNew + NF2.recogInBothOld;

function dataout = getSingleItemMemData(F1,F2,NF1,NF2)
dataout(:,1) = F1.recall + F1.fml ;
dataout(:,2) = F2.recall + F2.fml ;
dataout(:,3) = NF1.recall + NF1.fml ;
dataout(:,4) = NF2.recall + NF2.fml ;

function trialType = getTestedSinglePicInEncodingTrials(typeFlag)
%typeFlag 
rootDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\';
codeDir= [rootDir,'matlabFunctions\'];
load([codeDir,'myDesigntestPicpairFinal.mat']);
load([codeDir,'stim1Concat.mat']);
load([codeDir,'stim2Concat.mat']);
    idScrm = find(cell2mat(stimEncode1.fmpair(:,5))==999); %scrambles id
    idPics = setdiff(1:96, idScrm)'; %pictures id

idIntactInRetr = cell2mat(testpair.flist(:,10))==typeFlag; %face or house
idFamInRetr = cell2mat(testpair.flist(:,6))==1;
idNFamInRetr = cell2mat(testpair.flist(:,6))==0;

idFamInRetr = idFamInRetr.*idIntactInRetr;
idNFamInRetr = idNFamInRetr.*idIntactInRetr;

if typeFlag==1
faceNameFam = testpair.flist(find(idFamInRetr==1),1);
faceNameNFam = testpair.flist(find(idNFamInRetr==1),1);
[idd,idaF1,idbF]=intersect(stimEncode1.fmpair(:,1),faceNameFam);
[idd,idaF2,idbF]=intersect(stimEncode1.fmShuffled{1}(:,1),faceNameFam);

[idd,idaF3,idbF]=intersect(stimEncode1.nfmpair(:,1),faceNameNFam);
[idd,idaF4,idbF]=intersect(stimEncode1.nfmShuffled{1}(:,1),faceNameNFam);
trialType=zeros(96,4);
trialType(idaF1,1)=1;
trialType(idaF2,2)=1;
trialType(idaF3,3)=1;
trialType(idaF4,4)=1;
else
houseNameFam = testpair.flist(find(idFamInRetr==1),2);
houseNameNFam = testpair.flist(find(idNFamInRetr==1),2);
[idd,idaH1,idbH]=intersect(stimEncode1.fmpair(:,2),houseNameFam);
[idd,idaH2,idbH]=intersect(stimEncode1.fmShuffled{1}(:,2),houseNameFam);
%nonfamouse

[idd,idaH3,idbH]=intersect(stimEncode1.nfmpair(:,2),houseNameNFam);

[idd,idaH4,idbH]=intersect(stimEncode1.nfmShuffled{1}(:,2),houseNameNFam);
trialType=zeros(96,4);
trialType(idaH1,1)=1;
trialType(idaH2,2)=1;
trialType(idaH3,3)=1;
trialType(idaH4,4)=1;

end





