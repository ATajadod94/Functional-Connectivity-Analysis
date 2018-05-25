function [faceCountFam, houseCountFam,associativeCountFam,...
    faceCountNFam, houseCountNFam, associativeCountNFam] = ...
    getMemoryTrialCount(subID, isOnlyCrossPairRecomCount)
codeDir = pwd;
codeDir = [codeDir,'\'];
projDir = strrep(codeDir,'matlabFunctions\','');
subjDir = ['D:\myStudy\picpairfMRI\s',sprintf('%03d',subID),'\']; %modified sept 21 2014
subjPerformDir = [subjDir,'performanceData\'];
load([subjPerformDir,'retrievalDataUpdatedMethod.mat']);

%fam
faceCountFam = sum(faceRecogFam1.recall + faceRecogFam1.fml + ...
    faceRecogFam1.recogInOneNew + faceRecogFam1.recogInBothOld);
houseCountFam = sum(houseRecogFam1.recall + houseRecogFam1.fml + ...
    houseRecogFam1.recogInOneNew + houseRecogFam1.recogInBothOld);
intactCountFam = sum(intactRecogFam1);
recomTotalCountFam = sum(recomRecogFam1(:,1));
recomCrossPairCountFam = sum(recomRecogFam1(:,3));
if isOnlyCrossPairRecomCount==1
    associativeCountFam = intactCountFam + recomCrossPairCountFam;
else
    associativeCountFam = intactCountFam + recomTotalCountFam;
end
%nonfam
faceCountNFam = sum(faceRecogNFam1.recall + faceRecogNFam1.fml + ...
    faceRecogNFam1.recogInOneNew + faceRecogNFam1.recogInBothOld);
houseCountNFam = sum(houseRecogNFam1.recall + houseRecogNFam1.fml + ...
    houseRecogNFam1.recogInOneNew + houseRecogNFam1.recogInBothOld);
intactCountNFam = sum(intactRecogNFam1);
recomTotalCountNFam = sum(recomRecogNFam1(:,1));
recomCrossPairCountNFam = sum(recomRecogNFam1(:,3));
if isOnlyCrossPairRecomCount==1
    associativeCountNFam = intactCountNFam + recomCrossPairCountNFam;
else
    associativeCountNFam = intactCountNFam + recomTotalCountNFam;
end
