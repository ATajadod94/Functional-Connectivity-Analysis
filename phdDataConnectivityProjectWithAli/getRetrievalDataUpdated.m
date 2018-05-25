function getRetrievalDataUpdated(subjID,saveOrNot,datapath,outpath)
%get encoding trials that produce different retrieval performance.
% this can be used to construct design matrix in fmri analysis
%or used as modualation factors (in parameter modualation in fmri design.)
%******need change participant number for each participant (a string)******
%imput: participantNumber, e.g., '01', or '02', two digit string
%       saveOrNot: whether save data, usually should be 1: save.
%       datapath outpath: default is participant performance folder

participantNumber = sprintf('%03d',subjID);
rootDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\';
if nargin ==1
    datapath = ['D:\myStudy\picpairfMRI\',...
        's', participantNumber,'\performanceData\'];
    outpath = datapath;
    saveOrNot = 0;
end

if nargin ==2
    datapath = ['D\myStudy\picpairfMRI\',...
        's', participantNumber,'\performanceData\'];
    outpath = datapath;
end
% load design data in which stimEncode1 stim list is used
load([rootDir,'matlabFunctions\', 'myDesigntestPicpairFinal.mat']);

% load retrieval txt file (converted manually from eprime eData file)
[numData,txtData]=xlsread([datapath,'PicPairfMRI_',sprintf('%02d',subjID),'-1-13.txt']); %PicPairfMRI_01-1-13
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
%*************************************************************************

%find "intact" response
idColb = find(strcmp(varNames,'PairOldQ.RESP')==1);

%***************************************************************************
% intact pairs correctly identified
%**************************************************************************
%find the colum of pairtype
idCola = find(strcmp(varNames,'TestItemType')==1);


%find "intact" response
idColb = find(strcmp(varNames,'PairOldQ.RESP')==1);


% get the house and face file namse that are correctly identified as intact
idColc = find(strcmp(varNames,'Context')==1);

idCold = find(strcmp(varNames,'Target')==1);


idCole = find(strcmp(varNames,'recombinedCorresp')==1);

%find column of bothold, i.e., 'PairTypeQ.RESP'
idColf = find(strcmp(varNames,'PairTypeQ.RESP')==1);

idColfh = find(strcmp(varNames,'fh')==1);

idColg = find(strcmp(varNames,'FHFAMQ.RESP')==1);

%find oneNew response
idColi = find(strcmp(varNames,'PairNewQ.RESP')==1);


idColj = find(strcmp(varNames,'TargetOldNew')==1);


idColk = find(strcmp(varNames,'ContextOldNew')==1);

idColtf = find(strcmp(varNames,'TargetFame')==1);

encodeData = stimEncode1.fmpair;
[faceRecogFam1,houseRecogFam1,intactRecogFam1,recomRecogFam1,checkInfoFam1] = ...
    getDataFromRetr(encodeData,txtData,numData,idCola,idColb,idColf,...
    idCole, idColg, idColi, idColj, idColfh, idColk, idColtf);

encodeData = stimEncode1.fmShuffled{1};

[faceRecogFam2,houseRecogFam2,intactRecogFam2,recomRecogFam2,checkInfoFam2] = ...
    getDataFromRetr(encodeData,txtData,numData,idCola,idColb,idColf,...
    idCole, idColg, idColi, idColj,idColfh, idColk, idColtf);


encodeData = stimEncode1.nfmpair;
[faceRecogNFam1,houseRecogNFam1,intactRecogNFam1,recomRecogNFam1,checkInfoNFam1] = ...
    getDataFromRetr(encodeData,txtData,numData,idCola,idColb,idColf,...
    idCole, idColg, idColi, idColj,idColfh, idColk, idColtf);

encodeData = stimEncode1.nfmShuffled{1};

[faceRecogNFam2,houseRecogNFam2,intactRecogNFam2,recomRecogNFam2,checkInfoNFam2] = ...
    getDataFromRetr(encodeData,txtData,numData,idCola,idColb,idColf,...
    idCole, idColg, idColi,idColj, idColfh, idColk, idColtf);

save([outpath,'retrievalDataUpdatedMethod.mat'],...
    'faceRecogFam1','faceRecogFam2','faceRecogNFam1','faceRecogNFam2',...
    'houseRecogFam1','houseRecogFam2','houseRecogNFam1','houseRecogNFam2',...
    'intactRecogFam1','intactRecogFam2','intactRecogNFam1','intactRecogNFam2',...
    'recomRecogFam1','recomRecogFam2','recomRecogNFam1','recomRecogNFam2',...
    'checkInfoFam1','checkInfoFam2','checkInfoNFam1','checkInfoNFam2');

function [faceRecog,houseRecog,intactRecog,recomRecog,checkInfo] = ...
    getDataFromRetr(encodeData,txtData,numData,idCola,idColb,idColf,...
    idCole,  idColg, idColi, idColj,idColfh, idColk, idColtf)
idInEncode = find(cell2mat(encodeData(:,5))~=999);
faceRecog.recall = zeros(96,1);
faceRecog.fml = zeros(96,1);
faceRecog.recogInOneNew = zeros(96,1);
faceRecog.recogInBothOld = zeros(96,1);

houseRecog.recall = zeros(96,1);
houseRecog.fml = zeros(96,1);
houseRecog.recogInOneNew = zeros(96,1);
houseRecog.recogInBothOld = zeros(96,1);

checkInfo.targetFame= zeros(96,1);
checkInfo.targetOldNew= zeros(96,1);
checkInfo.contextOldNew= zeros(96,1);

intactRecog = zeros(96,1);
recomRecog  = zeros(96,3);
%*****************
for i = 1:length(idInEncode)
    k=idInEncode(i);
    idInRetr(k,1) = strmatch(encodeData{k,1},txtData(:,102),'exact');%face pic
    idInRetr(k,2) = strmatch(encodeData{k,2},txtData(:,53),'exact'); %house pic
    isFace = numData(idInRetr(k,1),idColfh-1);%face 1 or house 0
    isRec = numData(idInRetr(k,1),idColg-1);% first pic response 1, 2, 3
    isBothOld = numData(idInRetr(k,1),idColf-1);
    isOneNew = numData(idInRetr(k,1),idColi-1);
    isPairType = numData(idInRetr(k,1),idCola-1);
    isIntactResp = numData(idInRetr(k,1),idColb-1);
    
    %single face recognized
    if isFace==1 && isRec==1
        faceRecog.recall(k,1) = 1;
    elseif isFace==1 && isRec == 2
        faceRecog.fml(k,1) = 1;
    elseif isBothOld ==1
        faceRecog.recogInBothOld(k,1) = 1;
    elseif isFace==0 && isRec ==3 && isOneNew == 1
        faceRecog.recogInOneNew(k,1) = 1;
        
    end
    
    isFace = numData(idInRetr(k,2),idColfh-1);%face 1 or house 0
    isRec = numData(idInRetr(k,2),idColg-1);% first pic response 1, 2, 3
    isBothOld = numData(idInRetr(k,2),idColf-1);
    isOneNew = numData(idInRetr(k,2),idColi-1);
    isPairType = numData(idInRetr(k,2),idCola-1);
    isIntactResp = numData(idInRetr(k,2),idColb-1);
    % single house recognized
    if isFace==0 && isRec==1
        houseRecog.recall(k,1) = 1; % first question, recalled
    elseif isFace==0 && isRec ==2
        houseRecog.fml(k,1) = 1; % first question, familiar
    elseif isBothOld ==1
        houseRecog.recogInBothOld(k,1) = 1; % second question, bothold
    elseif isFace==1 && isRec ==3 && isOneNew == 1
        houseRecog.recogInOneNew(k,1) = 1;%3rd question, one new
        
    end
    
    
    checkInfo.targetFame(k,1) = numData(idInRetr(k,1),idColtf-1);
    checkInfo.targetOldNew(k,1) = numData(idInRetr(k,1),idColj-1);
    checkInfo.contextOldNew(k,1) = numData(idInRetr(k,1),idColk-1);
    if isPairType ==1 & isIntactResp ==1
        intactRecog(k,1) = 1;
    end
    if isPairType ==2 & isIntactResp ==2
        recomRecog(k,1) = 1;
        recomRecog(k,2) = numData(idInRetr(k,1),idCole-1);
    end
end

ida = find(recomRecog(:,2)>0 & recomRecog(:,2)<100);
idb = find(recomRecog(:,2)>100);
if ~isempty(ida) && ~isempty(idb)
    recomTrial1 = recomRecog(ida,2)+100;
    recomTrial2 = recomRecog(idb,2);
    
    recomTrial = intersect(recomTrial1,recomTrial2);
    if ~isempty(recomTrial)
        [aa bb] = intersect(recomRecog(:,2),cat(1,recomTrial, recomTrial-100));
        recomRecog(bb,3) = 1;
    end
end