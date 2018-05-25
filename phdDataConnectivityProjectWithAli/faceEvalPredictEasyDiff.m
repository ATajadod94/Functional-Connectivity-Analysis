function  [bval, surrogatebval]=faceEvalPredictEasyDiff

rootDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\matlabFunctions\';
load([rootDir,'myDesigntestPicpairFinal.mat']);

load([rootDir,'picCorrespondenceAcrossSubj.mat']);
faceEvalNames = {'emotion','memory','familiarity','attractiveness'};

idFamScrm = find(cell2mat(stimEncode1.fmpair(:,5))==999); %scrambles id
idFamPics = setdiff(1:96, idFamScrm)'; %pictures id
for subj=1:length(subID)
    subj
    datapath = ['D:\myStudy\picpairfMRI\',...
        's', sprintf('%03d',subID(subj)),'\performanceData\'];
    outpath = datapath;
    
    load([datapath,'easyDifficultEval.mat']);
    
    picsEval(picsEval==0)=2;
    picsEval(picsEval==2)=0;
    picsEval = picsEval(3:58,:);
    for i = 1:4
        load([datapath,faceEvalNames{i},'Eval.mat']);
    end
    emotionEval = emotionEval(idFamPics,:);
    memoryEval = memoryEval(idFamPics,:);
    familiarityEval = familiarityEval(idFamPics,:);
    attractivenessEval = attractivenessEval(idFamPics,:);
    x=cat(3,emotionEval,memoryEval,familiarityEval,attractivenessEval);
    x = x(3:58,:,:);
    
    for runi=1:4 %for runs
        for evalCat = 1:4 % for face eval
            lastwarn = [];
%             [b,dev,stats] = glmfit(x(:,runi,evalCat),picsEval(:,runi),'binomial','link','logit');
            b=corr(x(:,runi,evalCat),picsEval(:,runi))
            %             [msglast, msgidlast] = lastwarn;
            %             if strfind(msglast,'Iteration limit reached') | strfind(msglast,'X is ill conditioned')
            if ~isempty(lastwarn)
                bval(evalCat,runi,subj)=b;
            else
                bval(evalCat,runi,subj)=b ;%b(2);
            end
        end
        %       [b,dev,stats] = glmfit(squeeze(x(3:58,runi,:)),picsEval(3:58,runi),'binomial','link','logit')
        %      bval(:,runi,subj)=b(2:5);
    end
    
    for shufn=1:1000
        clc;
        rng(subj*shufn);
        idshuff=randsample(1:56,56);
        xreshuff=x(idshuff,:,:);
        
        for runi=1:2 %for runs
            for evalCat = 1:4 % for face eval
                lastwarn = [];
                
%                 [b,dev,stats] = glmfit(xreshuff(:,runi,evalCat),picsEval(:,runi),'binomial','link','logit');
                 b= corr(xreshuff(:,runi,evalCat),picsEval(:,runi));
                %                 [msglast, msgidlast] = lastwarn;
                %                 if strfind(msglast,'Iteration limit reached') | strfind(msglast,'X is ill conditioned')
                if ~isempty(lastwarn)
                    surrogatebval(evalCat,runi,shufn,subj)=b;
                    
                else
                    surrogatebval(evalCat,runi,shufn,subj)=b;
                end
            end
        end
    end
    
end
save([rootDir,'faceEvalPredictEasyDiff.mat'],'bval','surrogatebval')