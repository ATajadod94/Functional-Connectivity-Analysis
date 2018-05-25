function [summaryAccu] = getRetrievalSummaryData(subjID,saveOrNot,datapath,outPath)
%get encoding trials that produce different retrieval performance.
% this can be used to construct design matrix in fmri analysis
%or used as modualation factors (in parameter modualation in fmri design.)
%******need change participant number for each participant (a string)******
%imput: participantNumber, e.g., '01', or '02', two digit string
%       saveOrNot: whether save data, usually should be 1: save. 
%       datapath outpath: default is participant performance folder
%******!!!! the singleNopair data is not complete because the calculation
%is not optimal. it cannot be used to check the convergence of the trial
%retrieval perfomrance. the item but noassoication meomory should be
%calucluated from both face and house but no intact and recom. Jan 09 13

participantNumber = sprintf('%03d',subjID);
rootDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\';
if nargin ==1
    datapath = ['C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\',...
        's', participantNumber,'\performanceData\'];
    outPath = datapath;
    saveOrNot = 0;
end

if nargin ==2
    datapath = ['C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\',...
        's', participantNumber,'\performanceData\'];
    outPath = datapath;
end
% load design data in which stimEncode1 stim list is used
load([rootDir,'matlabFunctions\', 'myDesigntestPicpairFinal.mat']);

% load retrieval txt file (converted manually from eprime eData file)
[numData,txtData]=xlsread([datapath,'PicPairfMRI_',sprintf('%02d',subjID),'-1-13.txt']);
varNames = txtData(2,:); % names of the columns. the first and last column in the numData is deleted automatically
txtData = txtData(3:end,:);

%column 120 in numData is the log6level column in the eprime retrieval
%file. Only log6level = nan and 1 should be used because value 2 3... is
%the counting down break. therefore, filter the data using value 'nan' and
%1
idColz = find(strcmp(varNames,'LogLevel6')==1);
idRetrieval = sort(cat(1,find((numData(:,idColz-1) == 1)),...
    find(isnan(numData(:,idColz-1)))));
txtData = txtData(idRetrieval,:);
numData = numData(idRetrieval,:);
%*************************************************************************
%check the correctness of the data "filtering" using column 50 in the
%numData, which is the trial number and should be 1:192
if any(numData(:,50)-[1:192]') % if there is a non-zero element
    warn('need check whether the countingdown entries are deleted correctly');
end




%find the colum of pairtype
idCola = find(strcmp(varNames,'TestItemType')==1);
% find pairtypes
idIntactPair = find(numData(:,idCola-1) == 1);
idRecomPair = find(numData(:,idCola-1) == 2);
idHalfNewPair = find(numData(:,idCola-1) == 3);
idNewNewPair =find(numData(:,idCola-1) == 4);

%find response
idColb = find(strcmp(varNames,'PairOldQ.RESP')==1);
idIntactResp = find(numData(:,idColb-1) ==1);
idRecomResp = find(numData(:,idColb-1) ==2);
idNotKnowResp = find(numData(:,idColb-1) ==3);

% response to intact pair
idIntact.intact = intersect(idIntactPair,idIntactResp);%this index is important intact hit
idIntact.notKnow = intersect(idIntactPair,idNotKnowResp);% respond to intact pairs as don't know intact miss
idIntact.recom = intersect(idIntactPair,idRecomResp);% respond to intact pairs as recombine,i.e. false alarm

% response to recombined pairs
idRecom.recom = intersect(idRecomPair,idRecomResp);
idRecom.notKnow = intersect(idRecomPair,idNotKnowResp);
idRecom.intact = intersect(idRecomPair,idIntactResp);% false alarm

% response to halfnew pairs
idHalfN.recom = intersect(idHalfNewPair,idRecomResp);
idHalfN.notKnow = intersect(idHalfNewPair,idNotKnowResp);
idHalfN.intact = intersect(idHalfNewPair,idIntactResp);

% response to newnew pairs
idNewN.recom = intersect(idNewNewPair,idRecomResp);
idNewN.notKnow = intersect(idNewNewPair,idNotKnowResp);
idNewN.intact = intersect(idNewNewPair,idIntactResp);


%**************************************************************************
%*** single pictures 
%**************************************************************************

%***************** single faces alone ******************
idColfh = find(strcmp(varNames,'fh')==1);
idFaceTrial = find(numData(:,idColfh-1) == 1);
idHouseTrial = find(numData(:,idColfh-1) == 0);

%find ids of faces that are truely old
idColj = find(strcmp(varNames,'TargetOldNew')==1);
idFaceOldTrial = find(numData(:,idColj-1) == 1);
idFaceNewTrial = find(numData(:,idColj-1) == 0);
%responses
idColg = find(strcmp(varNames,'FHFAMQ.RESP')==1);
idRecResp = find(numData(:,idColg-1) == 1);
idFmlResp = find(numData(:,idColg-1) == 2); 
idNewResp = find(numData(:,idColg-1) == 3);

% face perform
idFaceFirstO.rec = intersect(intersect(idFaceTrial,idFaceOldTrial),idRecResp);
idFaceFirstO.fml = intersect(intersect(idFaceTrial,idFaceOldTrial),idFmlResp);
idFaceFirstO.new = intersect(intersect(idFaceTrial,idFaceOldTrial),idNewResp);

idFaceFirstN.rec = intersect(intersect(idFaceTrial,idFaceNewTrial),idRecResp);
idFaceFirstN.fml = intersect(intersect(idFaceTrial,idFaceNewTrial),idFmlResp);
idFaceFirstN.new = intersect(intersect(idFaceTrial,idFaceNewTrial),idNewResp);

%find ids of houses that are truely old
idColk = find(strcmp(varNames,'ContextOldNew')==1);
idHouseOldTrial = find(numData(:,idColk-1) == 1);
idHouseNewTrial = find(numData(:,idColk-1) == 0);

% House perform
idHouseFirstO.rec = intersect(intersect(idHouseTrial,idHouseOldTrial),idRecResp);
idHouseFirstO.fml = intersect(intersect(idHouseTrial,idHouseOldTrial),idFmlResp);
idHouseFirstO.new = intersect(intersect(idHouseTrial,idHouseOldTrial),idNewResp);

idHouseFirstN.rec = intersect(intersect(idHouseTrial,idHouseNewTrial),idRecResp);
idHouseFirstN.fml = intersect(intersect(idHouseTrial,idHouseNewTrial),idFmlResp);
idHouseFirstN.new = intersect(intersect(idHouseTrial,idHouseNewTrial),idNewResp);




%*************************************************************************
% single picture after the associates been presented
%**************************************************************************
%find column of bothold, i.e., 'PairTypeQ.RESP'
idColf = find(strcmp(varNames,'PairTypeQ.RESP')==1);
idBothOldResp = find(numData(:,idColf-1) == 1);
idNotBothOldResp = find(numData(:,idColf-1) == 2);
%find oneNew response
idColi = find(strcmp(varNames,'PairNewQ.RESP')==1);
idOneNewResp = find(numData(:,idColi-1) == 1);
idTwoNewResp = find(numData(:,idColi-1) == 2);

idFace2ndO.recog = intersect(intersect(idHouseTrial,idFaceOldTrial),idBothOldResp);
idFace2ndO.new = intersect(intersect(intersect(idHouseTrial,idHouseOldTrial),idFaceOldTrial),idNotBothOldResp);
idFace3rdO.recog = intersect(intersect(intersect(idHouseTrial,idNewResp),idFaceOldTrial),idOneNewResp);
idFace3rdO.new = intersect(intersect(intersect(idHouseTrial,idNewResp),idFaceOldTrial),idTwoNewResp);

idFace2ndN.recog = intersect(intersect(idHouseTrial,idFaceNewTrial),idBothOldResp);
idFace2ndN.new = intersect(intersect(intersect(idHouseTrial,cat(1,idRecResp,idFmlResp)),idFaceNewTrial),idNotBothOldResp);
idFace3rdN.recog = intersect(intersect(intersect(idHouseTrial,idNewResp),idFaceNewTrial),idOneNewResp);
idFace3rdN.new = intersect(intersect(intersect(idHouseTrial,idNewResp),idFaceNewTrial),idTwoNewResp);

idFace23Old.recog = union(idFace2ndO.recog,idFace3rdO.recog);
idFace23Old.new = union(idFace2ndO.new,idFace3rdO.new);

idFace23New.recog = union(idFace2ndN.recog,idFace3rdN.recog);
idFace23New.new = union(idFace2ndN.new,idFace3rdN.new);

%hosue

idHouse2ndO.recog = intersect(intersect(idFaceTrial,idHouseOldTrial),idBothOldResp);
idHouse2ndO.new = intersect(intersect(intersect(idFaceTrial,idFaceOldTrial),idHouseOldTrial),idNotBothOldResp);
idHouse3rdO.recog = intersect(intersect(intersect(idFaceTrial,idNewResp),idHouseOldTrial),idOneNewResp);
idHouse3rdO.new = intersect(intersect(intersect(idFaceTrial,idNewResp),idHouseOldTrial),idTwoNewResp);

idHouse2ndN.recog = intersect(intersect(idFaceTrial,idHouseNewTrial),idBothOldResp);
idHouse2ndN.new = intersect(intersect(intersect(idFaceTrial,cat(1,idRecResp,idFmlResp)),idHouseNewTrial),idNotBothOldResp);
idHouse3rdN.recog = intersect(intersect(intersect(idFaceTrial,idNewResp),idHouseNewTrial),idOneNewResp);
idHouse3rdN.new = intersect(intersect(intersect(idFaceTrial,idNewResp),idHouseNewTrial),idTwoNewResp);

idHouse23Old.recog = union(idHouse2ndO.recog,idHouse3rdO.recog);
idHouse23Old.new = union(idHouse2ndO.new,idHouse3rdO.new);

idHouse23New.recog = union(idHouse2ndN.recog,idHouse3rdN.recog);
idHouse23New.new = union(idHouse2ndN.new,idHouse3rdN.new);

% find all id with famous face
idColtf = find(strcmp(varNames,'TargetFame')==1);
idFam= find(numData(:,idColtf-1) == 1);
idNonFam= find(numData(:,idColtf-1) == 0);

idIntact = computeRetrDataFamNonFam(idIntact,idFam,idNonFam);
idRecom = computeRetrDataFamNonFam(idRecom,idFam,idNonFam);
idHalfN = computeRetrDataFamNonFam(idHalfN,idFam,idNonFam);
idNewN = computeRetrDataFamNonFam(idNewN,idFam,idNonFam);

intact.Fam.hit = length(idIntact.intactFam)/24;
intact.Fam.false = length(idRecom.intactFam)/24;
intact.NFam.hit = length(idIntact.intactNFam)/24;
intact.NFam.false = length(idRecom.intactNFam)/24;

recom.Fam.hit = length(idRecom.recomFam)/24;
recom.Fam.false = length(idIntact.recomFam)/24;
recom.NFam.hit = length(idRecom.recomNFam)/24;
recom.NFam.false = length(idIntact.recomNFam)/24;

idFaceFirstO = computeRetrDataFamNonFam(idFaceFirstO,idFam,idNonFam);
idFaceFirstN = computeRetrDataFamNonFam(idFaceFirstN,idFam,idNonFam);

faceFirstRec.Fam.hit = length(idFaceFirstO.recFam)/length(intersect(idFam,intersect(idFaceTrial,idFaceOldTrial)));
faceFirstRec.Fam.false = length(idFaceFirstN.recFam)/length(intersect(idFam,intersect(idFaceTrial,idFaceNewTrial)));

faceFirstFml.Fam.hit = length(idFaceFirstO.fmlFam)/length(intersect(idFam,intersect(idFaceTrial,idFaceOldTrial)));
faceFirstFml.Fam.false = length(idFaceFirstN.fmlFam)/length(intersect(idFam,intersect(idFaceTrial,idFaceNewTrial)));

faceFirstRec.NFam.hit = length(idFaceFirstO.recNFam)/length(intersect(idNonFam,intersect(idFaceTrial,idFaceOldTrial)));
faceFirstRec.NFam.false = length(idFaceFirstN.recNFam)/length(intersect(idNonFam,intersect(idFaceTrial,idFaceNewTrial)));

faceFirstFml.NFam.hit = length(idFaceFirstO.fmlNFam)/length(intersect(idNonFam,intersect(idFaceTrial,idFaceOldTrial)));
faceFirstFml.NFam.false = length(idFaceFirstN.fmlNFam)/length(intersect(idNonFam,intersect(idFaceTrial,idFaceNewTrial)));


idHouseFirstO = computeRetrDataFamNonFam(idHouseFirstO,idFam,idNonFam);
idHouseFirstN = computeRetrDataFamNonFam(idHouseFirstN,idFam,idNonFam);


houseFirstRec.Fam.hit = length(idHouseFirstO.recFam)/length(intersect(idFam,intersect(idHouseTrial,idHouseOldTrial)));
houseFirstRec.Fam.false = length(idHouseFirstN.recFam)/length(intersect(idFam,intersect(idHouseTrial,idHouseNewTrial)));

houseFirstFml.Fam.hit = length(idHouseFirstO.fmlFam)/length(intersect(idFam,intersect(idHouseTrial,idHouseOldTrial)));
houseFirstFml.Fam.false = length(idHouseFirstN.fmlFam)/length(intersect(idFam,intersect(idHouseTrial,idHouseNewTrial)));

houseFirstRec.NFam.hit = length(idHouseFirstO.recNFam)/length(intersect(idNonFam,intersect(idHouseTrial,idHouseOldTrial)));
houseFirstRec.NFam.false = length(idHouseFirstN.recNFam)/length(intersect(idNonFam,intersect(idHouseTrial,idHouseNewTrial)));

houseFirstFml.NFam.hit = length(idHouseFirstO.fmlNFam)/length(intersect(idNonFam,intersect(idHouseTrial,idHouseOldTrial)));
houseFirstFml.NFam.false = length(idHouseFirstN.fmlNFam)/length(intersect(idNonFam,intersect(idHouseTrial,idHouseNewTrial)));




idFace23Old = computeRetrDataFamNonFam(idFace23Old,idFam,idNonFam);
idFace23New = computeRetrDataFamNonFam(idFace23New,idFam,idNonFam);

faceSecond.Fam.hit = length(idFace23Old.recogFam)/length(intersect(idFam,intersect(idHouseTrial,idFaceOldTrial)));
faceSecond.Fam.false = length(idFace23New.recogFam)/length(intersect(idFam,intersect(idHouseTrial,idFaceNewTrial)));
faceSecond.NFam.hit = length(idFace23Old.recogNFam)/length(intersect(idNonFam,intersect(idHouseTrial,idFaceOldTrial)));
faceSecond.NFam.false = length(idFace23New.recogNFam)/length(intersect(idNonFam,intersect(idHouseTrial,idFaceNewTrial)));

idHouse23Old = computeRetrDataFamNonFam(idHouse23Old,idFam,idNonFam);
idHouse23New = computeRetrDataFamNonFam(idHouse23New,idFam,idNonFam);

houseSecond.Fam.hit = length(idHouse23Old.recogFam)/length(intersect(idFam,intersect(idFaceTrial,idHouseOldTrial)));
houseSecond.Fam.false = length(idHouse23New.recogFam)/length(intersect(idFam,intersect(idFaceTrial,idHouseNewTrial)));
houseSecond.NFam.hit = length(idHouse23Old.recogNFam)/length(intersect(idNonFam,intersect(idFaceTrial,idHouseOldTrial)));
houseSecond.NFam.false = length(idHouse23New.recogNFam)/length(intersect(idNonFam,intersect(idFaceTrial,idHouseNewTrial)));

summaryAccu.face.firstRecFam = faceFirstRec.Fam.hit - faceFirstRec.Fam.false;
summaryAccu.face.firstFmlFam = faceFirstFml.Fam.hit - faceFirstFml.Fam.false;
summaryAccu.face.firstFam = summaryAccu.face.firstRecFam + summaryAccu.face.firstFmlFam;
summaryAccu.face.secondFam = faceSecond.Fam.hit - faceSecond.Fam.false;
summaryAccu.face.totalFam = mean([summaryAccu.face.firstFam,summaryAccu.face.secondFam]);

summaryAccu.face.firstRecNFam = faceFirstRec.NFam.hit - faceFirstRec.NFam.false;
summaryAccu.face.firstFmlNFam = faceFirstFml.NFam.hit - faceFirstFml.NFam.false;
summaryAccu.face.firstNFam = summaryAccu.face.firstRecNFam + summaryAccu.face.firstFmlNFam;
summaryAccu.face.secondNFam = faceSecond.NFam.hit - faceSecond.NFam.false;
summaryAccu.face.totalNFam = mean([summaryAccu.face.firstNFam,summaryAccu.face.secondNFam]);


summaryAccu.house.firstRecFam = houseFirstRec.Fam.hit - houseFirstRec.Fam.false;
summaryAccu.house.firstFmlFam = houseFirstFml.Fam.hit - houseFirstFml.Fam.false;
summaryAccu.house.firstFam = summaryAccu.house.firstRecFam + summaryAccu.house.firstFmlFam;
summaryAccu.house.secondFam = houseSecond.Fam.hit - houseSecond.Fam.false;
summaryAccu.house.totalFam = mean([summaryAccu.house.firstFam,summaryAccu.house.secondFam]);

summaryAccu.house.firstRecNFam = houseFirstRec.NFam.hit - houseFirstRec.NFam.false;
summaryAccu.house.firstFmlNFam = houseFirstFml.NFam.hit - houseFirstFml.NFam.false;
summaryAccu.house.firstNFam = summaryAccu.house.firstRecNFam + summaryAccu.house.firstFmlNFam;
summaryAccu.house.secondNFam = houseSecond.NFam.hit - houseSecond.NFam.false;
summaryAccu.house.totalNFam = mean([summaryAccu.house.firstNFam,summaryAccu.house.secondNFam]);

summaryAccu.pair.intactFam = intact.Fam.hit-intact.Fam.false;
summaryAccu.pair.recomFam = recom.Fam.hit-recom.Fam.false;
summaryAccu.pair.avgFam = mean([summaryAccu.pair.intactFam,summaryAccu.pair.recomFam]);

summaryAccu.pair.intactNFam = intact.NFam.hit-intact.NFam.false;
summaryAccu.pair.recomNFam = recom.NFam.hit-recom.NFam.false;
summaryAccu.pair.avgNFam = mean([summaryAccu.pair.intactNFam,summaryAccu.pair.recomNFam]);

save([outPath,'retrievalDataSummarry.mat'],'summaryAccu',...
    'intact','recom','faceFirstRec','faceFirstFml','houseFirstRec', 'houseFirstFml',...
    'faceSecond','houseSecond');

function data = computeRetrDataFamNonFam(data,idFam,idNonFam)


oldFieldNames = fieldnames(data);
for i = 1:size(oldFieldNames,1)
   famFieldNames{i}= [oldFieldNames{i},'Fam']; 
   nonFamFieldNames{i}= [oldFieldNames{i},'NFam']; 
   [data.(famFieldNames{i})]=intersect([data.(oldFieldNames{i})],idFam);
   [data.(nonFamFieldNames{i})]=intersect([data.(oldFieldNames{i})],idNonFam);
end

