function [intact,recom,recomOmitted,singleFace,singleHouse,singleNoPair] = ...
    getRetrievalData(subjID,saveOrNot,datapath,outpath)
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
    datapath = ['D:\myStudy\picpairfMRI\',...
        's', participantNumber,'\performanceData\'];
    outpath = datapath;
    saveOrNot = 0;
end

if nargin ==2
    datapath = ['D:\myStudy\picpairfMRI\',...
        's', participantNumber,'\performanceData\'];
    outpath = datapath;
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
%***************************************************************************
% intact pairs correctly identified
%**************************************************************************
%find the colum of pairtype
idCola = find(strcmp(varNames,'TestItemType')==1);
% get the data idCol -  in numData
idIntactPair = find(numData(:,idCola-1) == 1);

% find all id with famous face
idColtf = find(strcmp(varNames,'TargetFame')==1);
idIntactPair = find(numData(:,idColtf-1) == 1);


%find "intact" response
idColb = find(strcmp(varNames,'PairOldQ.RESP')==1);
idIntactResp = find(numData(:,idColb-1) ==1);
idRecomResp = find(numData(:,idColb-1) ==2);
idNotKnowResp = find(numData(:,idColb-1) ==3);
% corrected intact responses ids
idCorrectIntact = intersect(idIntactPair,idIntactResp);%this index is important
idOmittedIntact = intersect(idIntactPair,idRecomResp);% respond to intact pairs as recombine
idNotKnowIntact = intersect(idIntactPair,idNotKnowResp);% respond to intact pairs as don't know


% get the house and face file namse that are correctly identified as intact
idColc = find(strcmp(varNames,'Context')==1);
houseCorrectIntact = txtData(idCorrectIntact, idColc);
houseOmittedIntact = txtData(idOmittedIntact, idColc);
idCold = find(strcmp(varNames,'Target')==1);
faceCorrectIntact = txtData(idCorrectIntact, idCold);
faceOmittedIntact = txtData(idOmittedIntact, idCold);
%************************************************************************
% recombined pairs correctly identified (for both cross-over pairs)
%************************************************************************
% get recombined pair ides in numData
idRecomPair = find(numData(:,idCola-1) == 2);

%find "recombined" response
idRecomResp = find(numData(:,idColb-1) ==2);

% corrected recombined responses ids
idCorrectRecom = intersect(idRecomPair,idRecomResp);
idOmittedRecom = intersect(idRecomPair,idIntactResp); % i.e., indicated as intact
%find the column indicating the cross-over recombined pairs e.g., 1 and
%101, 2 and 102 etc.
idCole = find(strcmp(varNames,'recombinedCorresp')==1);
idRecombCorrectIndex = numData(idCorrectRecom, idCole-1);
%find both crossover correct id
if ~isempty(idRecombCorrectIndex)
    ida = idRecombCorrectIndex(idRecombCorrectIndex<100)+100;
    idb = idRecombCorrectIndex(idRecombCorrectIndex>100);
    bothCorr = intersect(ida,idb); %bothcorr only contain numbers >100
    
    if ~isempty(bothCorr)
        [a,idCorrectRecomBoth,c] = intersect(numData(:,idCole-1),...
                                              [bothCorr; bothCorr-100]); % this index is important
        %just print to check whether the data is correct: 3 columns:
        %crossover index, recombine response,recombine pairs
        numData(idCorrectRecomBoth,[idCole-1,idColb-1,idCola-1]);
        houseCorrectRecom = txtData(idCorrectRecomBoth, idColc);
        faceCorrectRecom = txtData(idCorrectRecomBoth, idCold);
    else
        idCorrectRecomBoth=[];
        houseCorrectRecom =[];
        faceCorrectRecom = [];
    end
else
    idCorrectRecomBoth=[];
    houseCorrectRecom =[];
    faceCorrectRecom = [];
end

houseOmittedRecom = txtData(idOmittedRecom, idColc);
faceOmittedRecom = txtData(idOmittedRecom, idCold);
%*************************************************************************
% both face and houes are correctly identified
%**************************************************************************
%find column of bothold, i.e., 'PairTypeQ.RESP'
idColf = find(strcmp(varNames,'PairTypeQ.RESP')==1);
idBothOldResp = find(numData(:,idColf-1) == 1);
idBothOldPair = union(idIntactPair,idRecomPair);
idCorrectBothOld = intersect(idBothOldPair, idBothOldResp); %important index
%face and house file names that both
houseCorrectBothOld = txtData(idCorrectBothOld, idColc);
faceCorrectBothOld = txtData(idCorrectBothOld, idCold);

%**************************************************************************
%*** single pictures are correctly recognized
%**************************************************************************

%***************** single faces correctly identified******************
idColfh = find(strcmp(varNames,'fh')==1);
idFaceTrial = find(numData(:,idColfh-1) == 1);
idHouseTrial = find(numData(:,idColfh-1) == 0);

idColg = find(strcmp(varNames,'FHFAMQ.RESP')==1);
idSingleOldResp = union(find(numData(:,idColg-1) == 1),find(numData(:,idColg-1) == 2)); %including both recollection and familiarity
idSingleNewResp = find(numData(:,idColg-1) == 3);

%find oneNew response
idColi = find(strcmp(varNames,'PairNewQ.RESP')==1);
idOneNewResp = find(numData(:,idColi-1) == 1);

%in house first trial, find ids of faces that were recognized at the last
%step i.e., onenew and bothnew question
idFaceRecogInOneNew = intersect(intersect(idHouseTrial,idSingleNewResp),...
    idOneNewResp); %recognized in onenew trials where house presented first

idFaceRecogInSingle = intersect(idFaceTrial,idSingleOldResp); %recognized in single picture trials
idFaceRecoginBothOld = idBothOldResp; %recognized in both old trials
idFaceRecogTotal = union(union(idFaceRecogInOneNew,idFaceRecogInSingle),...
    idFaceRecoginBothOld); %all faces indicated as old
%find ids of faces that are truely old
idColj = find(strcmp(varNames,'TargetOldNew')==1);
idFaceOldTrial = find(numData(:,idColj-1) == 1);

%find ids of trails that faces are correctly recognized
idCorrectAllFace = intersect(idFaceOldTrial, idFaceRecogTotal);
%file names of faces correctly recognized
faceCorrect = txtData(idCorrectAllFace, idCold);

%*************** single house correctly identified**********************

idHouseRecogInOneNew = intersect(intersect(idFaceTrial,idSingleNewResp),...
    idOneNewResp); %recognized in onenew trial where face presneted first
idHouseRecogInSingle = intersect(idHouseTrial,idSingleOldResp);%recognized in single picture trials
idHouseRecoginBothOld = idBothOldResp;%recognized in both old trials
idHouseRecogTotal = union(union(idHouseRecogInOneNew,idHouseRecogInSingle),...
    idHouseRecoginBothOld); %all faces indicated as old

%find ids of houses that are truely old
idColk = find(strcmp(varNames,'ContextOldNew')==1);
idHouseOldTrial = find(numData(:,idColk-1) == 1);

%find ids of trails that houses are correctly recognized
idCorrectAllHouse = intersect(idHouseOldTrial, idHouseRecogTotal);

%file names of houses correctly recognized
houseCorrect = txtData(idCorrectAllHouse, idColc);

%**************************************************************************
%******* both faceHouse recognized but associations are not***************
%**************************************************************************

%***** ids of pairs in which both face and hose are recognized************
idCorrectFaceHouseRecog = intersect(idCorrectAllHouse, idCorrectAllFace);

% ids of pairs in which both face and house are recognized but assoications
% are not recognized
idCorrFHNoAssociation = setdiff(idCorrectFaceHouseRecog,...
    union(idCorrectIntact,idCorrectRecomBoth));
%names of houses and faces in pairs that both house and face is recognized but
%assoication is not recognized **** be careful: this does not include the
%oldnew and newold pairs. Because we don't know whether the original pairs
%are memorized, therefore it is reasonable to exclude them, espeically
%considering the fact that some of the orignal pairs are the filling pairs
%which is likely ot be momorized well. therefore, to compare assoication vs
%single picture, we'd better exclude the newold and oldnew pairs

houseFHNOAssociation = txtData(idCorrFHNoAssociation, idColc);
faceFHNOAssociation = txtData(idCorrFHNoAssociation, idCold);

%*************************************************************************
%*************************************************************************
%************ find ids in ECONDING TASKS for each type of perfomrance*****
%**************** by calling embeded functioned (see below)***************
%intact pairs
idIntactCondFam{:,1} = pairCorrectResp(stimEncode1.fmpair(:,1),...
                                       stimEncode1.fmpair(:,2),...
                                       faceCorrectIntact,...
                                       houseCorrectIntact);
idIntactCondFam{:,2} = pairCorrectResp(stimEncode1.fmShuffled{1}(:,1),...
                                       stimEncode1.fmShuffled{1}(:,2),...
                                       faceCorrectIntact,...
                                       houseCorrectIntact);

idIntactCondNFam{:,1} = pairCorrectResp(stimEncode1.nfmpair(:,1),...
                                        stimEncode1.nfmpair(:,2),...
                                        faceCorrectIntact,...
                                        houseCorrectIntact);
idIntactCondNFam{:,2} = pairCorrectResp(stimEncode1.nfmShuffled{1}(:,1),...
                                        stimEncode1.nfmShuffled{1}(:,2),...
                                        faceCorrectIntact,...
                                        houseCorrectIntact);


%recombined pairs
idRecomCondFam{:,1} = pairCorrectResp(stimEncode1.fmpair(:,1),...
                                        stimEncode1.fmpair(:,2),...
                                        faceCorrectRecom,...
                                        houseCorrectRecom);
idRecomCondFam{:,2} = pairCorrectResp(stimEncode1.fmShuffled{1}(:,1),...
                                        stimEncode1.fmShuffled{1}(:,2),...
                                        faceCorrectRecom,...
                                        houseCorrectRecom);

idRecomCondNFam{:,1} = pairCorrectResp(stimEncode1.nfmpair(:,1),...
                                        stimEncode1.nfmpair(:,2),...
                                        faceCorrectRecom,...
                                        houseCorrectRecom);
idRecomCondNFam{:,2} = pairCorrectResp(stimEncode1.nfmShuffled{1}(:,1),...
                                        stimEncode1.nfmShuffled{1}(:,2),...
                                        faceCorrectRecom,...
                                        houseCorrectRecom);
                                    
%false alarm (omitted pairs)

idRecomOmittedFam{:,1} = pairCorrectResp(stimEncode1.fmpair(:,1),...
                                        stimEncode1.fmpair(:,2),...
                                        faceOmittedRecom,...
                                        houseOmittedRecom);
idRecomOmittedFam{:,2} = pairCorrectResp(stimEncode1.fmShuffled{1}(:,1),...
                                        stimEncode1.fmShuffled{1}(:,2),...
                                        faceOmittedRecom,...
                                        houseOmittedRecom);

idRecomOmittedNFam{:,1} = pairCorrectResp(stimEncode1.nfmpair(:,1),...
                                        stimEncode1.nfmpair(:,2),...
                                        faceOmittedRecom,...
                                        houseOmittedRecom);
idRecomOmittedNFam{:,2} = pairCorrectResp(stimEncode1.nfmShuffled{1}(:,1),...
                                        stimEncode1.nfmShuffled{1}(:,2),...
                                        faceOmittedRecom,...
                                        houseOmittedRecom);

%single faces
idSingleFaceFam{:,1} = singlePicCorrectResp(stimEncode1.fmpair(:,1),...
                                            faceCorrect);
idSingleFaceFam{:,2} = singlePicCorrectResp(stimEncode1.fmShuffled{1}(:,1),...
                                            faceCorrect);

idSingleFaceNFam{:,1} = singlePicCorrectResp(stimEncode1.nfmpair(:,1),...
                                            faceCorrect);
idSingleFaceNFam{:,2} = singlePicCorrectResp(stimEncode1.nfmShuffled{1}(:,1),...
                                            faceCorrect);

%single Houses
idSingleHouseFam{:,1} = singlePicCorrectResp(stimEncode1.fmpair(:,2),...
                                             houseCorrect);
idSingleHouseFam{:,2} = singlePicCorrectResp(stimEncode1.fmShuffled{1}(:,2),...
                                             houseCorrect);

idSingleHouseNFam{:,1} = singlePicCorrectResp(stimEncode1.nfmpair(:,2),...
                                             houseCorrect);
idSingleHouseNFam{:,2} = singlePicCorrectResp(stimEncode1.nfmShuffled{1}(:,2),...
                                             houseCorrect);

%both facehouse recognized but assoications not
idBothFHNOAssociationFam{:,1}=singlePicCorrectResp(stimEncode1.fmpair(:,1),...
    faceFHNOAssociation,...
    stimEncode1.fmpair(:,2),...
    houseFHNOAssociation);
idBothFHNOAssociationFam{:,2}=singlePicCorrectResp(stimEncode1.fmShuffled{1}(:,1),...
    faceFHNOAssociation,...
    stimEncode1.fmShuffled{1}(:,2),...
    houseFHNOAssociation);

idBothFHNOAssociationNFam{:,1}=singlePicCorrectResp(stimEncode1.nfmpair(:,1),...
    faceFHNOAssociation,...
    stimEncode1.nfmpair(:,2),...
    houseFHNOAssociation);
idBothFHNOAssociationNFam{:,2}=singlePicCorrectResp(stimEncode1.nfmShuffled{1}(:,1),...
    faceFHNOAssociation,...
    stimEncode1.nfmShuffled{1}(:,2),...
    houseFHNOAssociation);

% put results into structures
intact.fam = idIntactCondFam;
intact.nfam= idIntactCondNFam;

recom.fam = idRecomCondFam;
recom.nfam = idRecomCondNFam;

%false alarm
recomOmitted.fam = idRecomOmittedFam;
recomOmitted.nfam = idRecomOmittedNFam;

singleFace.fam = idSingleFaceFam;
singleFace.nfam = idSingleFaceNFam;

singleHouse.fam = idSingleHouseFam;
singleHouse.nfam = idSingleHouseNFam;

singleNoPair.fam = idBothFHNOAssociationFam;
singleNoPair.nfam = idBothFHNOAssociationNFam;

%other data may needed for performance accuracy calculation
% pairtype, intact 1, recombined 2, halfnewold 3, newnew 4
pairType = numData(:,idCola-1);
% id of old, i.e., studied faces
OldFace = numData(:,idColj-1);
% id of old, i.e., studied house
OldHouse = numData(:,idColk-1);
% id of face or house presented first
FaceHouseFirstPresented = numData(:,idColfh-1);
%face fame
idColl = find(strcmp(varNames,'TargetFame')==1);
faceFame = numData(:,idColl-1);
%*************************************************************************
%**************************************************************************
%**************************************************************************
%save data
if saveOrNot==1
    save([outpath,'RetrievalDataForfMRIDesign.mat'],...
        'intact','recom','recomOmitted','singleFace','singleHouse','singleNoPair');
    save([outpath,'retrievalData.mat'],...
        'idCorrectIntact','idCorrectRecom','idCorrectRecomBoth',...
        'idOmittedIntact','idOmittedRecom',...
        'idCorrectBothOld', 'idCorrectAllFace','idCorrectAllHouse',...
        'idCorrectFaceHouseRecog','OldFace','OldHouse',...
        'FaceHouseFirstPresented','pairType','faceFame');
end

%**************************************************************************
%**************************************************************************
%**************************************************************************
% get pair ids in encoding that are recognized
function ic = pairCorrectResp(encodingFacePic,encodingHousePic,...
                               retrievedFacePic,retrievedHousePic)
[c,ia,ib]=intersect(encodingFacePic,retrievedFacePic);
[c,ic,id]=intersect(encodingHousePic,retrievedHousePic);
if (length(intersect(ia,ic))==length(ia))&&(length(intersect(ia,ic))==length(ic))
    disp('corrrect')
else
    sprintf('need check pair data');
end

% get pair ids in encoding that contains at leat one picture in retrieval recombined pairs which is responded as intact 
function ia = pairCorrectRespRecomFA(encodingFacePic,encodingHousePic,...
                               retrievedFacePic,retrievedHousePic)
[c,ia,ib]=intersect(encodingFacePic,retrievedFacePic);
[c,ic,id]=intersect(encodingHousePic,retrievedHousePic);
ia = union(ia,ic);


%**************************************************************************
% get pairs ids where single pictures are recognized
function ia = singlePicCorrectResp(encodingPic1,retrievedPic1,...
                                   encodingPic2,retrievedPic2)
if nargin ==2
    [c,ia,ib]=intersect(encodingPic1,retrievedPic1);
end
if nargin==4 % both face house recognized but ossication not
    [c,ia,ib]=intersect(encodingPic1,retrievedPic1);
    [c,ic,id]=intersect(encodingPic2,retrievedPic2);
    ia = intersect(ia,ic);
end