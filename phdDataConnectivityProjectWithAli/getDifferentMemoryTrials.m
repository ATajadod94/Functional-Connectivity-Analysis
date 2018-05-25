function [triTypeFam, triTypeNFam, trialCountFam, trialCountNFam] = ...
    getDifferentMemoryTrials(subID, isOnlyCrossPairRecom,isSave)
codeDir = pwd;
codeDir = [codeDir,'\'];
projDir = strrep(codeDir,'matlabFunctions\','');
subjDir = ['D:\myStudy\picpairfMRI\s',sprintf('%03d',subID),'\']; %modified sept 21 2014
subjPerformDir = [subjDir,'performanceData\'];
load([subjPerformDir,'retrievalDataUpdatedMethod.mat']);

%fam1
faceFam = faceRecogFam1.recall + faceRecogFam1.fml + ...
    faceRecogFam1.recogInOneNew + faceRecogFam1.recogInBothOld;
houseFam = houseRecogFam1.recall + houseRecogFam1.fml + ...
    houseRecogFam1.recogInOneNew + houseRecogFam1.recogInBothOld;
intactFam = intactRecogFam1;
recomTotalFam = recomRecogFam1(:,1);
recomCrossPairFam = recomRecogFam1(:,3);
if isOnlyCrossPairRecom==1
    associativeFam = intactFam + recomCrossPairFam;
else
    associativeFam = intactFam + recomTotalFam;
end

tempFam = faceFam+houseFam+associativeFam;
faceOnlyFam = (tempFam==1).*faceFam;
houseOnlyFam = (tempFam==1).*houseFam;

triTypeFam(:,1) = tempFam;
triTypeFam(:,2) = tempFam;
triTypeFam(faceOnlyFam==1,2) = 4;
triTypeFam(houseOnlyFam==1,2) = 5;


%fam2
faceFam = faceRecogFam2.recall + faceRecogFam2.fml + ...
    faceRecogFam2.recogInOneNew + faceRecogFam2.recogInBothOld;
houseFam = houseRecogFam2.recall + houseRecogFam2.fml + ...
    houseRecogFam2.recogInOneNew + houseRecogFam2.recogInBothOld;
intactFam = intactRecogFam2;
recomTotalFam = recomRecogFam2(:,1);
recomCrossPairFam = recomRecogFam2(:,3);
if isOnlyCrossPairRecom==1
    associativeFam = intactFam + recomCrossPairFam;
else
    associativeFam = intactFam + recomTotalFam;
end

tempFam = faceFam+houseFam+associativeFam;
faceOnlyFam = (tempFam==1).*faceFam;
houseOnlyFam = (tempFam==1).*houseFam;

triTypeFam2(:,1) = tempFam;
triTypeFam2(:,2) = tempFam;
triTypeFam2(faceOnlyFam==1,2) = 4;
triTypeFam2(houseOnlyFam==1,2) = 5;


%nonfam1
faceNFam = faceRecogNFam1.recall + faceRecogNFam1.fml + ...
    faceRecogNFam1.recogInOneNew + faceRecogNFam1.recogInBothOld;
houseNFam = houseRecogNFam1.recall + houseRecogNFam1.fml + ...
    houseRecogNFam1.recogInOneNew + houseRecogNFam1.recogInBothOld;
intactNFam = intactRecogNFam1;
recomTotalNFam = recomRecogNFam1(:,1);
recomCrossPairNFam = recomRecogNFam1(:,3);

if isOnlyCrossPairRecom==1
    associativeNFam = intactNFam + recomCrossPairNFam;
else
    associativeNFam = intactNFam + recomTotalNFam;
end

tempNFam = faceNFam+houseNFam+associativeNFam;
faceOnlyNFam = (tempNFam==1).*faceNFam;
houseOnlyNFam = (tempNFam==1).*houseNFam;

triTypeNFam(:,1) = tempNFam;
triTypeNFam(:,2) = tempNFam;
triTypeNFam(faceOnlyNFam==1,2) = 4;
triTypeNFam(houseOnlyNFam==1,2) = 5;

%nonfam2
faceNFam = faceRecogNFam2.recall + faceRecogNFam2.fml + ...
    faceRecogNFam2.recogInOneNew + faceRecogNFam2.recogInBothOld;
houseNFam = houseRecogNFam2.recall + houseRecogNFam2.fml + ...
    houseRecogNFam2.recogInOneNew + houseRecogNFam2.recogInBothOld;
intactNFam = intactRecogNFam2;
recomTotalNFam = recomRecogNFam2(:,1);
recomCrossPairNFam = recomRecogNFam2(:,3);

if isOnlyCrossPairRecom==1
    associativeNFam = intactNFam + recomCrossPairNFam;
else
    associativeNFam = intactNFam + recomTotalNFam;
end

tempNFam = faceNFam+houseNFam+associativeNFam;
faceOnlyNFam = (tempNFam==1).*faceNFam;
houseOnlyNFam = (tempNFam==1).*houseNFam;

triTypeNFam2(:,1) = tempNFam;
triTypeNFam2(:,2) = tempNFam;
triTypeNFam2(faceOnlyNFam==1,2) = 4;
triTypeNFam2(houseOnlyNFam==1,2) = 5;



%trial count using first block
%  pair no associative, pair with associative,single mem, no mem, total
% trials
trialCountFam(1,1)=sum(triTypeFam(:,1)==2);
trialCountFam(1,2)=sum(triTypeFam(:,1)==3);
trialCountFam(1,3)=sum(triTypeFam(:,1)==1);
trialCountFam(1,4)=60 - sum(trialCountFam(1,1:3));
trialCountFam(1,5)=60;
%pair no asso, pair with asso, face only, house only, no mem
trialCountFam(2,1)=sum(triTypeFam(:,2)==2);
trialCountFam(2,2)=sum(triTypeFam(:,2)==3);
trialCountFam(2,3)=sum(triTypeFam(:,2)==4);
trialCountFam(2,4)=sum(triTypeFam(:,2)==5);
trialCountFam(2,5)=60 - sum(trialCountFam(2,1:4));


%trial count
%  pair no associative, pair with associative,single mem, no mem, total
% trials
trialCountNFam(1,1)=sum(triTypeNFam(:,1)==2);
trialCountNFam(1,2)=sum(triTypeNFam(:,1)==3);
trialCountNFam(1,3)=sum(triTypeNFam(:,1)==1);
trialCountNFam(1,4)=60 - sum(trialCountNFam(1,1:3));
trialCountNFam(1,5)=60;
%pair no asso, pair with asso, face only, house only, no mem
trialCountNFam(2,1)=sum(triTypeNFam(:,2)==2);
trialCountNFam(2,2)=sum(triTypeNFam(:,2)==3);
trialCountNFam(2,3)=sum(triTypeNFam(:,2)==4);
trialCountNFam(2,4)=sum(triTypeNFam(:,2)==5);
trialCountNFam(2,5)=60 - sum(trialCountNFam(2,1:4));
if isSave==1
    save([subjPerformDir,'RetrivalMemTypeFileForMakingMulitCond.mat'],'triTypeFam', 'triTypeFam2','triTypeNFam', 'triTypeNFam2', 'trialCountFam', 'trialCountNFam');
end