function [idBlockE idBlockD idExclude] = getMemoryPerformanceForEachTrial(memId)
if nargin<1
        memId=[0 1 2 3];
end
nsubj=20;
for i = 1:nsubj
    roiDir=['D:\myStudy\picpairfMRI\s',sprintf('%03d',i),'\performanceData\'];
    load([roiDir,'retrievalDataUpdatedMethod.mat']);
    load([roiDir,'easyDifficultEval.mat']);
    
    data(i).Fam1 = getTrialData(faceRecogFam1,houseRecogFam1,intactRecogFam1,recomRecogFam1);
    data(i).Fam2 = getTrialData(faceRecogFam2,houseRecogFam2,intactRecogFam2,recomRecogFam2);
    data(i).NFam1 = getTrialData(faceRecogNFam1,houseRecogNFam1,intactRecogNFam1,recomRecogNFam1);
    data(i).NFam2 = getTrialData(faceRecogNFam2,houseRecogNFam2,intactRecogNFam2,recomRecogNFam2);
    
    
end

rootDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\';
codeDir= [rootDir,'matlabFunctions\'];
load([codeDir,'myDesigntestPicpairFinal.mat']);
a=stimEncode1.fmpair(:,1);
b=stimEncode1.fmShuffled{1}(:,1);
[aa ia ib]=intersect(a,b,'rows','stable');
c=stimEncode1.nfmpair(:,1);
d=stimEncode1.nfmShuffled{1}(:,1);
[aa ic id]=intersect(c,d,'rows','stable');

% for i = 1:20
%     datadiff(1,i) = sum(sum(data(i).Fam1 - data(i).Fam2(ib,:)));
%     datadiff(2,i) = sum(sum(data(i).NFam1 - data(i).NFam2(ib,:)));
% end
% plot(datadiff);

idScrm = find(cell2mat(stimEncode1.fmpair(:,5))==999); %scrambles id
idPics = setdiff(1:96, idScrm)'; %pictures id

%     picFam2To1 = ib(idPics);
%     picNFam2to1 =id(idPics);
%     scrmFam2To1 = ib(idScrm);
%     scrmNFam2To1=id(idScrm);
%
%     [easyDiffAll(picFam2To1,2),easyDiffAll(idPics,1)]
% easyDiffAll=zeros(96,4);
% easyDiffAll(idPics,:) = picsEval;
idExclude = zeros(20,1);
for i = 1:20
    roiDir=['D:\myStudy\picpairfMRI\s',sprintf('%03d',i),'\performanceData\'];
    
    load([roiDir,'easyDifficultEval.mat']);
    %        memData = [data(i).Fam1(idPics,:),data(i).Fam2(idPics,:),data(i).NFam1(idPics,:),data(i).NFam2(idPics,:)];
    
    memData = [data(i).Fam1(idPics,4),data(i).Fam2(idPics,4),data(i).NFam1(idPics,4),data(i).NFam2(idPics,4)];

    for j = 1:4
        for k=1:length(memId)
            %             idE{k}= find(memData(picsEval(:,j)==1,j)==memId(k)~=0);
            temp =   memData(:,j) ==memId(k);
            idE{k} = find(temp.* (picsEval(:,j)==1)==1);
            %             idD{k}= cat(1,find(memData(picsEval(:,j)==2,j)==memId(k)~=0),find(memData(picsEval(:,j)==0,j)==memId(k)~=0));
            
            idD{k} =cat(1, find(temp.* (picsEval(:,j)==2)==1),find(temp.* (picsEval(:,j)==0)==1));
            minTrialNum= min(length(idE{k}),length(idD{k}));
            if minTrialNum==0
                idE{k} = [];
                idD{k}= [];
            else
                idE{k}=randsample(idE{k},minTrialNum);
                idD{k}=randsample(idD{k},minTrialNum);
            end
            
        end
        idBlockE{i,j}= cat(1,idE{:});
        idBlockD{i,j}= cat(1,idD{:});
        if sum(cat(1,idE{:}))<5
            idExclude(i,1)=1;
        end
        %         trialCountEasy(i,j) =sum(memData(picsEval(:,j)==1,j)<=2);
        %         trialCountDiffi(i,j) =sum(memData(picsEval(:,j)==2,j)<=2) + sum(memData(picsEval(:,j)==0,j)<=2);
    end
end

function data=getTrialData(faceRecogFam1,houseRecogFam1,intactRecogFam1,recomRecogFam1)
data(:,1)=sum([faceRecogFam1.recall,faceRecogFam1.fml,faceRecogFam1.recogInOneNew,faceRecogFam1.recogInBothOld],2);
data(:,2)=sum([houseRecogFam1.recall,houseRecogFam1.fml,houseRecogFam1.recogInOneNew,houseRecogFam1.recogInBothOld],2);
data(:,3)=sum([intactRecogFam1,recomRecogFam1(:,3)],2);
data(:,4)=sum(data,2);

