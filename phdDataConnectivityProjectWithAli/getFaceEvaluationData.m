function faceEvalM = getFaceEvaluationData(subID,datapath,outpath)
%get face evaluation data corresponding to encoding trials that have the
%face pictures. this can be used to change design matrix in fmri analysis
%or treated as modualation factors (in parameter modualation in fmri
%design.)
% the fillings (4 pictures for each condition) were not evaluated
%******need change participant number for each participant (a string)******

if nargin < 2
    datapath = ['C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\',...
        's', sprintf('%03d',subID),'\performanceData\'];
    outpath = datapath;
end
% load design data in which stimEncode1 stim list is used 
rootDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\matlabFunctions\';
load([rootDir,'myDesigntestPicpairFinal.mat']);

familiarityEval = calculateEval('familiarity.txt',datapath,stimEncode1);
emotionEval = calculateEval('emotion.txt',datapath,stimEncode1);
attractivenessEval = calculateEval('attractiveness.txt',datapath,stimEncode1);
memoryEval = calculateEval('memory.txt',datapath,stimEncode1);
faceEvalNotes = 'column 1- 4: fam1 fam2 nonfam1 nonfam2';

% mean evaluation scores
faceEvalM.familiarity = sum(familiarityEval)/56;
faceEvalM.emotion = sum(emotionEval)/56;
faceEvalM.attractiveness = sum(attractivenessEval)/56;
faceEvalM.memory = sum(memoryEval)/56;

save([outpath,'familiarityEval.mat'],'familiarityEval','faceEvalNotes');
save([outpath,'emotionEval.mat'],'emotionEval','faceEvalNotes');
save([outpath,'attractivenessEval.mat'],'attractivenessEval','faceEvalNotes');
save([outpath,'memoryEval.mat'],'memoryEval','faceEvalNotes');

function faceEval = calculateEval(datafile,datapath,stimEncode1)
[numData,txtData]=xlsread([datapath,datafile]);
faceName = txtData(3:end,30);
faceEvaluation = numData(:,26);
faceEval = zeros(size(stimEncode1.fmpair,1),4);
%get intersection ids for famouse condition encoding 1
[faces, idA, idB] = intersect(faceName, stimEncode1.fmpair(:,1));
faceEval(idB,1)=faceEvaluation(idA);

%get intersection ids for famouse condition encoding 2
[faces, idA, idB] = intersect(faceName, stimEncode1.fmShuffled{1}(:,1));
faceEval(idB,2)=faceEvaluation(idA);

%get intersection ids for nonfamouse condition encoding 1
[faces, idA, idB] = intersect(faceName, stimEncode1.nfmpair(:,1));
faceEval(idB,3)=faceEvaluation(idA);

%get intersection ids for nonfamouse condition encoding 2
[faces, idA, idB] = intersect(faceName, stimEncode1.nfmShuffled{1}(:,1));
faceEval(idB,4)=faceEvaluation(idA);
