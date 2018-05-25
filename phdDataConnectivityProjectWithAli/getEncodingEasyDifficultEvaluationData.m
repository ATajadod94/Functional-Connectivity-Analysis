function [picsEvalM scrmEvalM] = getEncodingEasyDifficultEvaluationData(subID,datapath,outpath)
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

fam1Eval = calculateEval('fam1.txt',datapath,stimEncode1.fmpair);
fam2Eval = calculateEval('fam2.txt',datapath,stimEncode1.fmShuffled{1,1});
nonfam1Eval = calculateEval('nonfam1.txt',datapath,stimEncode1.nfmpair);
nonfam2Eval = calculateEval('nonfam2.txt',datapath,stimEncode1.nfmShuffled{1,1});
picsEval=[fam1Eval.pics fam2Eval.pics nonfam1Eval.pics nonfam2Eval.pics];
scrmEval=[fam1Eval.scrm fam2Eval.scrm nonfam1Eval.scrm nonfam2Eval.scrm];
evalNotes = 'column 1- 4: fam1 fam2 nonfam1 nonfam2';
% mean evaluation scores
picsEvalM = mean(picsEval);
scrmEvalM = mean(scrmEval);

save([outpath,'easyDifficultEval.mat'],'picsEval','scrmEval');


function fam1Eval = calculateEval(datafile,datapath,fmpair)
[numData,txtData]=xlsread([datapath,datafile]);
% easy/difficult evaluation data coloum
data = numData(:,58);
idFamScrm = find(cell2mat(fmpair(:,5))==999); %scrambles id
idFamPics = setdiff(1:96, idFamScrm)'; %pictures id

%get intersection ids for famouse condition encoding 1
fam1Eval.pics=data(idFamPics);
fam1Eval.scrm=data(idFamScrm);
%find omitted responses
idPicNan = find(isnan(fam1Eval.pics));
idScrNan = find(isnan(fam1Eval.scrm));
%replace omitted response by zero
if ~isempty(idPicNan)
    fam1Eval.pics(idPicNan) = 0;
end

if ~isempty(idScrNan)
    fam1Eval.scrm(idScrNan) = 0; % nanmean(fam1Eval.scrm);
end


